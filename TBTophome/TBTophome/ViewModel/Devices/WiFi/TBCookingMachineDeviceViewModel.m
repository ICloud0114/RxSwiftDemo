//
//  TBCookingMachineDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/2/16.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBCookingMachineDeviceViewModel.h"

@interface TBCookingMachineDeviceViewModel ()

@property (atomic, assign) NSInteger curWillSetGear; //保存当前将要设置的档位值,-1表示app没有主动设置
@property (atomic, assign) NSInteger curWillSetTemp; //保存当前将要设置的温度值,-1表示app没有主动设置
@property (atomic, assign) NSInteger curWillSetTime; //保存当前将要设置的时间值,-1表示app没有主动设置


@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *gearSetting;
@property (nonatomic, strong) RACCommand *tempSetting;
@property (nonatomic, strong) RACCommand *timeSetting;
@property (nonatomic, strong) RACCommand *rollMaxSetting;
@property (nonatomic, strong) RACCommand *startWorkSetting;
@property (nonatomic, strong) RACCommand *pauseWorkSetting;
@property (nonatomic, strong) RACCommand *weightSetting;
@property (nonatomic, strong) RACCommand *stopSetting;
@property (nonatomic, strong) RACCommand *reverseSetting;

@end

@interface TBCookingMachineDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;
- (RACSignal *)settingGear:(uint8)gear;
- (RACSignal *)settingTemp:(uint8)temp;
- (RACSignal *)settingTime:(uint16)time;
//设置点动
- (RACSignal *)settingRollMax;
//启动工作
- (RACSignal *)startWork;
//暂停工作
- (RACSignal *)pauseWork;
//打开称重模式
- (RACSignal *)weight;
//停止
- (RACSignal *)stop;
//反转
- (RACSignal *)reverse;
@end

@implementation TBCookingMachineDeviceViewModel
- (instancetype)initWithDevice:(HMDevice *)device {
    self = [super initWithDevice:device];
    if (self) {
        _curGears = 1;
        _curWillSetGear = -1;
        _curWillSetTemp = -1;
        _curWillSetTime = -1;
    }
    return self;
}

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
//    TBLog(@"cmd: %d", cmd)
//    TBLog(@"payload: %@", payload)
    uint8 workMode = [[payload objectForKey:@"workMode"] unsignedCharValue];
    uint8 steering = [[payload objectForKey:@"steering"] unsignedCharValue];
    uint8 gears = [[payload objectForKey:@"gears"] unsignedCharValue];
    uint8 temp = [[payload objectForKey:@"temp"] unsignedCharValue];
    uint16 time = [[payload objectForKey:@"time"] unsignedShortValue];
    uint16 weight = [[payload objectForKey:@"weight"] unsignedShortValue];
    uint8 panStatus = [[payload objectForKey:@"panStatus"] unsignedCharValue];
    uint8 menu = [[payload objectForKey:@"menu"] unsignedCharValue];
    
    if ((self.curWillSetGear > -1 && self.curWillSetGear == gears) ||
        (self.curTemp > 0 && self.curWillSetGear > 6) ||
        (self.curSteering == 1 && self.curWillSetGear > 4)) {
        self.curWillSetGear = -1;
        self.curGears = gears;
    } else {
    //    if (self.curGears != gears) { self.curGears = gears; }
        Unequal_Assign(curGears, gears)
    }
    
    if (self.curWillSetTemp > -1 && self.curWillSetTemp == temp) {
        self.curWillSetTemp = -1;
        self.curTemp = temp;
    } else {
//        if (self.curTemp != temp) { self.curTemp = temp; }
        Unequal_Assign(curTemp, temp)
    }
    
    if (self.curWillSetTime > -1 && self.curWillSetTime == time) {
        self.curWillSetTime = -1;
        self.curTime = time;
    } else {
//        if (self.curTime != time) { self.curTime = time; }
        Unequal_Assign(curTime, time)
    }
    
    Unequal_Assign(curWorkMode, workMode)
//    if (self.curWorkMode != workMode) { self.curWorkMode = workMode; }
    Unequal_Assign(curSteering, steering)
//    if (self.curSteering != steering) { self.curSteering = steering; }
    Unequal_Assign(curWeight, weight)
//    if (self.curWeight != weight) { self.curWeight = weight; }
    Unequal_Assign(curMenu, menu)
//    if (self.curMenu != menu) { self.curMenu = menu; }

//    Unequal_Assign(curGears, gears)
//    Unequal_Assign(curWorkMode, workMode)
//    Unequal_Assign(curSteering, steering)
//    Unequal_Assign(curTemp, temp)
//    Unequal_Assign(curTime, time)
//    Unequal_Assign(curWeight, weight)
//    Unequal_Assign(curMenu, menu)

    //处理当设置温度后回归档位到5挡
//    if (self.curTemp > 0 && self.curGears > 6) {
//        self.curGears = gears;
//    }
}
    
- (UIImage *)deviceIcon {
    return UIImage.cookingMachineIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.cookingMachineOffIconImage;
}
    
- (Class)viewControllerClass {
    return NSClassFromString(@"TBCookingMachineViewController");
}
#pragma mark - getter setter

- (RACCommand *)deviceState {
    if (!_deviceState) {
        @weakify(self)
        _deviceState = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self initializerState];
        }];
    }
    return _deviceState;
}

- (RACCommand *)gearSetting {
    if (!_gearSetting) {
        @weakify(self)
        _gearSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            if (self.curWorkMode == 4 || self.curWorkMode == 5) { //设备运行期间，如果设置0挡则发送停止命令
                if ([input unsignedCharValue] == 1) {
                    return [self stop];
                }
            }
            self.curWillSetGear = [input unsignedCharValue];
            return [self settingGear:[input unsignedCharValue]];
        }];
    }
    return _gearSetting;
}

- (RACCommand *)tempSetting {
    if (!_tempSetting) {
        @weakify(self)
        _tempSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            self.curWillSetTemp = [input unsignedCharValue];
            return [self settingTemp:[input unsignedCharValue]];
        }];
    }
    return _tempSetting;
}

- (RACCommand *)timeSetting {
    if (!_timeSetting) {
        @weakify(self)
        _timeSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            self.curWillSetTime = [input unsignedShortValue];
            return [self settingTime:[input unsignedShortValue]];
        }];
    }
    return _timeSetting;
}

- (RACCommand *)rollMaxSetting {
    if (!_rollMaxSetting) {
        @weakify(self)
        _rollMaxSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            return [self settingRollMax];
        }];
    }
    return _rollMaxSetting;
}

- (RACCommand *)startWorkSetting {
    if (!_startWorkSetting) {
        @weakify(self)
        _startWorkSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple * _Nullable input) {
            @strongify(self)
            return [self startWork];
        }];
    }
    return _startWorkSetting;
}

- (RACCommand *)pauseWorkSetting {
    if (!_pauseWorkSetting) {
        @weakify(self)
        _pauseWorkSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple * _Nullable input) {
            @strongify(self)
            return [self pauseWork];
        }];
    }
    return _pauseWorkSetting;
}

- (RACCommand *)weightSetting {
    if (!_weightSetting) {
        @weakify(self)
        _weightSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            return [self weight];
        }];
    }
    return _weightSetting;
}

- (RACCommand *)stopSetting {
    if (!_stopSetting) {
        @weakify(self)
        _stopSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            return [self stop];
        }];
    }
    return _stopSetting;
}

- (RACCommand *)reverseSetting {
    if (!_reverseSetting) {
        @weakify(self)
        _reverseSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
            @strongify(self)
            return [self reverse];
        }];
    }
    return _reverseSetting;
}
    
@end

@implementation TBCookingMachineDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingGear:(uint8)gear {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2007];
    [payload setObject:@(gear) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingTemp:(uint8)temp {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2008];
    [payload setObject:@(temp) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingTime:(uint16)time {
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x2009];
    [payload setObject:@(time) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingRollMax {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2010];
    return [self dataToDevice:payload];
}

- (RACSignal *)startWork {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2002];
    return [self dataToDevice:payload];
}

- (RACSignal *)pauseWork {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2003];
    return [self dataToDevice:payload];
}

- (RACSignal *)weight {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2011];
    return [self dataToDevice:payload];
}

- (RACSignal *)stop {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2004];
    return [self dataToDevice:payload];
}

- (RACSignal *)reverse {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2017];
    return [self dataToDevice:payload];
}
@end
