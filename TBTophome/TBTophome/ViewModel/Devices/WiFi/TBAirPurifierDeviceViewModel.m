//
//  TBAirPurifierDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBAirPurifierDeviceViewModel.h"
#import "RACBaseHelper.h"

@interface TBAirPurifierDeviceViewModel ()
@property (nonatomic, strong) RACCommand *power;
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *timerSetting;
@property (nonatomic, strong) RACCommand *fanSpeedSetting;
@property (nonatomic, strong) RACCommand *swingSetting;
@property (nonatomic, strong) RACCommand *lightBelfSetting;
@end

@interface TBAirPurifierDeviceViewModel (DeviceOperatorSignal)

- (RACSignal *)power:(BOOL)power;
- (RACSignal *)initializerState;
- (RACSignal *)settingTimer:(NSInteger)timer;
- (RACSignal *)settingFanSpeed:(NSInteger)fanSpeed;
- (RACSignal *)settingSwing:(BOOL)swing;
- (RACSignal *)settingLightBelf:(NSInteger)mode;

@end

@implementation TBAirPurifierDeviceViewModel

- (void)bind {
//    @weakify(self)
//    RAC(self, power) = 
//    [self.power.executionSignals flattenMap:^__kindof RACSignal * _Nullable(RACSignal *  _Nullable subscribeSignal) {
//        return [[[subscribeSignal materialize]
//                 filter:RACEventFilter(RACEventTypeNext)]
//                map:^id _Nullable(id  _Nullable value) {
//                    @strongify(self)
//                    return @(!self.isPower);
//                }];
//    }];
    
//    [[self.deviceState.executionSignals flattenMap:^__kindof RACSignal * _Nullable(RACSignal *  _Nullable subscribeSignal) {
//        return [[[subscribeSignal materialize]
//                 filter:RACEventFilter(RACEventTypeNext)]
//                map:^id _Nullable(RACEvent *  _Nullable event) {
//                    return event.value;
//                }];
//    }] subscribeNext:^(id  _Nullable x) {
//        
//    }];
}

- (instancetype)initWithDevice:(HMDevice *)device {
    self = [super initWithDevice:device];
    if (self) {
        _fanSpeed = 3;
        [self bind];
    }
    return self;
}

#pragma mark - getter setter
- (RACCommand *)power {
    if (!_power) {
        @weakify(self)
        _power = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            TBLog(@"%@", @(input.selected));
            return [self power: !input.selected];
        }];
    }
    return _power;
}

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

- (RACCommand *)timerSetting {
    if (!_timerSetting) {
        @weakify(self)
        _timerSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            NSInteger timer = self.timerMode;
            timer += 0x02;
            if (timer > 0x0C) {
                timer = 0x00;
            }
            return [self settingTimer:timer];
        }];
    }
    return _timerSetting;
}

- (RACCommand *)fanSpeedSetting {
    if (!_fanSpeedSetting) {
        @weakify(self)
        _fanSpeedSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            NSInteger fanSpeed = self.fanSpeed + 1;
            if (fanSpeed > 5) { fanSpeed = 1; }
            input.tag = fanSpeed;
            return [self settingFanSpeed:fanSpeed];
        }];
    }
    return _fanSpeedSetting;
}

- (RACCommand *)swingSetting {
    if (!_swingSetting) {
        @weakify(self)
        _swingSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton * _Nullable input) {
            @strongify(self)
            return [self settingSwing:!self.swingMode];
        }];
    }
    return _swingSetting;
}

- (RACCommand *)lightBelfSetting {
    if (!_lightBelfSetting) {
        @weakify(self)
        _lightBelfSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *_Nullable input) {
            @strongify(self)
            NSInteger mode = self.lightBelfMode + 1;
            if (mode > 0x02) {
                mode = 0x00;
            }
            input.tag = mode;
            return [self settingLightBelf:mode];
        }];
    }
    return _lightBelfSetting;
}

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)
    uint8 workStatus = [[payload objectForKey:@"workStatus"] unsignedCharValue]; //开关机状态
    uint8 envStatus = [[payload objectForKey:@"envStatus"] unsignedCharValue]; //环境情况
    uint8 fanSpeed = [[payload objectForKey:@"fanSpeed"] unsignedCharValue]; //风速档位
    uint8 swing = [[payload objectForKey:@"swing"] unsignedCharValue]; //摆头
    uint8 lightBelt = [[payload objectForKey:@"lightBelt"] unsignedCharValue]; //灯带
    uint8 timingStatus = [[payload objectForKey:@"timingStatus"] unsignedCharValue]; //定时状态
    uint16 filteringTime = [[payload objectForKey:@"filteringTime"] unsignedShortValue]; //滤网时间
    
    self.powerStatus = (workStatus == 0x01);
    self.environmentStatus = envStatus;
    self.fanSpeed = fanSpeed;
    self.swingMode = swing == 0x01;
    if (filteringTime <= 2160) {
        self.filteringTime = [NSString stringWithFormat:@"滤网已使用%d小时", filteringTime];
    } else {
        self.filteringTime = @"请更换滤网";
    }
    self.lightBelfMode = lightBelt;
    self.timerMode = timingStatus;
}

- (UIImage *)deviceIcon {
    return UIImage.airPurifierDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.airPurifierDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBAirPurifierViewController");
}
@end

#pragma mark - 设备的一些操作
@implementation TBAirPurifierDeviceViewModel (DeviceOperatorSignal)
//开关机
- (RACSignal *)power:(BOOL)power {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:power ? 0x1002: 0x1003];
    return [self dataToDevice:payload];
}

//获取设备初始状态
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

//设置风速
- (RACSignal *)settingFanSpeed:(NSInteger)fanSpeed {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2007];
    [payload setObject:@(fanSpeed) forKey:@"param"];
    return [self dataToDevice:payload];
}

//摆头设定
- (RACSignal *)settingSwing:(BOOL)swing {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2009];
    [payload setObject:swing ? @0x01 : @0x00 forKey:@"param"];
    return [self dataToDevice:payload];
}

//设定灯带
- (RACSignal *)settingLightBelf:(NSInteger)mode {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0X2010];
    [payload setObject:@(mode) forKey:@"param"];
    return [self dataToDevice:payload];
}

//设定定时器
- (RACSignal *)settingTimer:(NSInteger)timer {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0X2008];
    [payload setObject:@(timer) forKey:@"param"];
    return [self dataToDevice:payload];
}
@end
