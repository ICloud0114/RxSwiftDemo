//
//  TBAircDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAircDeviceViewModel.h"

@interface TBAircDeviceViewModel () {
    BOOL isSetTemp; //是否设置过温度
}

@end

@implementation TBAircDeviceViewModel

- (instancetype)initWithBrandId:(NSInteger)brandId {
    self = [super init];
    if (self) {
        _brandId = brandId;
    }
    return self;
}

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    //    TBLog(@"cmd: %d", cmd)
    //    TBLog(@"payload: %@", payload)
}

- (UIImage *)deviceIcon {
    if ([[_device.company pathExtension] integerValue] == 0)
        return UIImage.aricIconImage;
    return UIImage.aricCIconImage;
}

- (UIImage *)deviceOffIcon {
    if ([[_device.company pathExtension] integerValue] == 0)
        return UIImage.aricOffIconImage;
    return UIImage.aricCOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBAirConditioningViewController");
}

- (RACSignal<NSArray<NSNumber *> *> *)getInfraredCodes {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [TBInfrared getRidsWithDeviceId:5
                                brandId:self.brandId
                         completeHandle:^(NSArray * _Nullable rids, NSError * _Nullable error) {
                             if (error == nil) {
                                 [subscriber sendNext:rids];
                                 [subscriber sendCompleted];
                             } else {
                                 [subscriber sendError:error];
                             }
                         }];
        return nil;
    }];
}

- (RACSignal<TBAircModeModel *> *)getAirModeWithRid:(NSInteger)rid {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [TBInfrared getAcirModeWithRid:rid completeHandle:^(TBAircModeModel * _Nullable mode, NSError * _Nullable error) {
            if (error == nil) {
                [subscriber sendNext:mode];
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }];
}

- (RACSignal *)controlWithParams:(NSDictionary *)params rid:(NSInteger)rid {
    @weakify(self)
    return
    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [TBInfrared getAcirComposeInfraredWithRid:rid
                                     composeParam:params
                                   completeHandle:^(TBAcirComposeInfraredModel * _Nullable model, NSError * _Nullable error) {
            if (error == nil) {
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }] flattenMap:^__kindof RACSignal * _Nullable(TBAcirComposeInfraredModel * _Nullable model) {
        @strongify(self)
        ControlDeviceCmd *cmd = [ControlDeviceCmd object];
        cmd.order = @"ir control";
        cmd.freq = model.fre;
        cmd.pluseNum = model.pattern.count;
        cmd.pluseData = [model.pattern componentsJoinedByString:@","];
        cmd.userName = userAccout().userName;
        if (_device == nil) {
            cmd.uid = [TBAddRemoteConfig xiaofang_uid];
            cmd.deviceId = [TBAddRemoteConfig xiaofang_deviceId];
        } else { //去数据库查询小方
            __block HMDevice *xiaofang = nil;
            NSString *sql2 = [NSString stringWithFormat:@"select * from device where uid = '%@' and deviceType = %@", _device.uid, @(KDeviceTypeAllone)];
            queryDatabase(sql2, ^(FMResultSet *rs) {
                xiaofang = [HMDevice object:rs];
                //            [devcieList addObject:deivce];
            });
            NSAssert(xiaofang != nil, @"未查到小方");
            cmd.uid = xiaofang.uid;
            cmd.deviceId = xiaofang.uid;
        }
        return [[self class] sendCmd:cmd];
    }];
}

- (RACSignal *)controlWithCmdIndex:(NSInteger)index {
    NSInteger rid = [self.rids[self.ridIndex] integerValue];
    NSDictionary *params = @{};
    switch (index) {
        case 1: { //模式
            self.modeIndex += 1;
            if (self.modeIndex >= self.currentMode.modes.count) {
                self.modeIndex = 0;
            }
            NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
            self.currentModeValue = mode;
            self.power = YES;
            if (mode == 2) { //自动
                params = @{@"mode": @(mode), @"fid": @2};
            } else {
                NSInteger temp = self.currentTemp;
                TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
                modeValue.tempIndex = [modeValue.temp indexOfObject:@(temp)];
                params = @{@"mode": @(mode), @"temp": @(temp), @"fid": @2};
            }
            break;
        }
        case 2: { //电源
            self.power = !self.power;
            if (self.power) { //开机
                self.modeIndex = 0;
                NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
                self.currentModeValue = mode;
                NSInteger temp = self.currentTemp;
                TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
                modeValue.tempIndex = [modeValue.temp indexOfObject:@(temp)];
                params = @{@"power": @0, @"mode": @(mode), @"temp": @(temp), @"fid": @1};
            } else { //关机
                params = @{@"power": @1, @"fid": @1};
            }
            break;
        }
        case 3: { //风速
            NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
            TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
            if (!(ArrayIsNotEmpty()(modeValue.speed))) {
                return [RACSignal error:[NSError errorWithDomain:ViewModelErrorDomain code:-1001 userInfo:@{NSLocalizedDescriptionKey: @"此按键没有红外码"}]];
            }
            modeValue.speedIndex += 1;
            if (modeValue.speedIndex >= modeValue.speed.count) {
                modeValue.speedIndex = 0;
            }
            NSInteger speed = [modeValue.speed[modeValue.speedIndex] integerValue];
            params = @{@"mode": @(mode), @"speed": @(speed), @"fid": @5};
            self.currentSpeed = speed;
            self.power = YES;
            break;
        }
        case 4: { //制冷
            NSInteger mode = 0;
            self.modeIndex = [self.currentMode.modes indexOfObject:@0];
            self.currentModeValue = 0;
            self.power = YES;
            NSInteger temp = self.currentTemp;
            TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
            modeValue.tempIndex = [modeValue.temp indexOfObject:@(temp)];
            params = @{@"mode": @(mode), @"temp": @(temp), @"fid": @2};
            break;
        }
        case 5: { //温度+
            isSetTemp = YES;
            NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
            TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
            NSInteger tempIndex = modeValue.tempIndex;
            NSInteger tempCount = modeValue.temp.count;
            if (tempIndex < tempCount) {
                tempIndex += 1;
            }
            if (tempIndex >= tempCount) {
                return [RACSignal error:[NSError errorWithDomain:ViewModelErrorDomain code:-1001 userInfo:@{NSLocalizedDescriptionKey: @"此按键没有红外码"}]];
            }
            modeValue.tempIndex = tempIndex;
            NSInteger temp = [modeValue.temp[modeValue.tempIndex] integerValue];
            params = @{@"mode": @(mode), @"temp": @(temp), @"fid": @2};
            self.currentTemp = temp;
            self.power = YES;
            break;
        }
        case 6: {//温度-
            isSetTemp = YES;
            NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
            TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
            if (modeValue.tempIndex >= 0) { modeValue.tempIndex -= 1; }
            if (modeValue.tempIndex < 0) {
                return [RACSignal error:[NSError errorWithDomain:ViewModelErrorDomain code:-1001 userInfo:@{NSLocalizedDescriptionKey: @"此按键没有红外码"}]];
            }
            NSInteger temp = [modeValue.temp[modeValue.tempIndex] integerValue];
            params = @{@"mode": @(mode), @"temp": @(temp), @"fid": @2};
            self.currentTemp = temp;
            self.power = YES;
            break;
        }
        case 7: {//扫风
            NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
            if (self.currentDirect == nil || [self.currentDirect integerValue] > 0) {
                self.currentDirect = @0;
                params = @{@"mode": @(mode), @"direct": self.currentDirect, @"fid": @6};
            } else {
                self.currentDirect = @1;
                params = @{@"mode": @(mode), @"direct": self.currentDirect, @"fid": @7};
            }
            self.power = YES;
            break;
        }
        case 8: {//制热
            NSInteger mode = 1;
            self.modeIndex = [self.currentMode.modes indexOfObject:@1];
            self.currentModeValue = 1;
            self.power = YES;
            NSInteger temp = self.currentTemp;
            TBAricMode *modeValue = self.currentMode.modeValues[self.modeIndex];
            modeValue.tempIndex = [modeValue.temp indexOfObject:@(temp)];
            params = @{@"mode": @(mode), @"fid": @2};
            break;
        }
        case 9: {//风向
            if (self.currentDirect == nil) {
                self.currentDirect = @1;
            } else if ([self.currentDirect integerValue] == 1 && [self.currentMode.direct containsObject:@2]) {
                self.currentDirect = @2;
            } else if ([self.currentDirect integerValue] == 2 && [self.currentMode.direct containsObject:@3]) {
                self.currentDirect = @3;
            } else {
                self.currentDirect = @1;
            }
            NSInteger mode = [self.currentMode.modes[self.modeIndex] integerValue];
            params = @{@"mode": @(mode), @"direct": self.currentDirect, @"fid": @7};
            self.power = YES;
            break;
        }
        default:
            break;
    }
    return [self controlWithParams:params rid:rid];
}

- (RACSignal *)save:(NSInteger)style {
    WiFiAddDevice *wifi = [WiFiAddDevice object];
    wifi.irDeviceId = [self.rids[self.ridIndex] stringValue];
    wifi.company = [@"97" stringByAppendingPathExtension:[@(style) stringValue]];
    wifi.deviceId = [TBAddRemoteConfig xiaofang_deviceId];
    wifi.uid = [TBAddRemoteConfig xiaofang_uid];
    wifi.userName = userAccout().userName;
    wifi.deviceName = (style == 0) ? @"格力空调遥控器-壁式" : @"格力空调遥控器-柜式";
    wifi.sendToServer = YES;
    wifi.deviceType = KDeviceTypeAirconditioner;
    return [[[self class] sendCmd:wifi] doNext:^(NSDictionary * _Nullable x) {
        HMDevice *device = [HMDevice objectFromDictionary:x];
//        HMDeviceStatus *status = [HMDeviceStatus objectFromDictionary:x];
        [device insertObject];
//        [status insertObject];
    }];
}

- (void)setCurrentModeValue:(NSInteger)currentModeValue {
    _currentModeValue = currentModeValue;
    NSInteger tempDefaultValue = 0;
    if (_currentModeValue == 0) { //制冷
        tempDefaultValue = 26;
    } else if (_currentModeValue == 1) { //制热
        tempDefaultValue = 20;
    } else if (_currentModeValue == 2) { //自动
        tempDefaultValue = -1;
    } else if (_currentModeValue == 3) { //送风
        tempDefaultValue = 24;
    } else if (_currentModeValue == 4) { //除湿
        tempDefaultValue = 23;
    }
    self.currentTemp = tempDefaultValue;

}

@end
