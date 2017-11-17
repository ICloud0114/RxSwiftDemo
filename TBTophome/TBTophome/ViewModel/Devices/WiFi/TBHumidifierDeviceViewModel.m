//
//  TBHumidifierDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/1/19.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBHumidifierDeviceViewModel.h"

@interface TBHumidifierDeviceViewModel()
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *power;
@property (nonatomic, strong) RACCommand *humiditySetting;
@property (nonatomic, strong) RACCommand *gearSetting;
@end

@interface TBHumidifierDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;
- (RACSignal *)turnOnWithGear:(uint8)gear hygrometer:(uint8)hy;
- (RACSignal *)turnOff;
- (RACSignal *)settingHumidity:(uint8)humidity;
- (RACSignal *)adjustGear:(uint8)gear;
@end


@implementation TBHumidifierDeviceViewModel

- (instancetype)initWithDevice:(HMDevice *)device {
    self = [super initWithDevice:device];
    if (self) {
        _gear = 1;
        _setHumidity = 40;
    }
    return self;
}

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)
    
    uint8 curTemperature = [[payload objectForKey:@"curTemperature"] unsignedCharValue];
    uint8 setHumidity = [[payload objectForKey:@"setHumidity"] unsignedCharValue];
    uint8 curHumidity = [[payload objectForKey:@"curHumidity"] unsignedCharValue];
    uint8 workStatus = [[payload objectForKey:@"workStatus"] unsignedCharValue];
    uint8 gear = [[payload objectForKey:@"gear"] unsignedCharValue];

    self.currentTemperature = curTemperature;
    Unequal_Assign(setHumidity, setHumidity)
//    self.setHumidity = setHumidity;
    self.gear = gear;
    self.powerStatus = (workStatus != 0);
    self.isLackWater = (workStatus == 2);
}

- (UIImage *)deviceIcon {
    return UIImage.humidifierDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.humidifierDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBHumidifierViewController");
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

- (RACCommand *)power {
    if (!_power) {
        @weakify(self)
        _power = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            TBLog(@"%@", @(input.selected));
            if (input.selected) { //关机
                return [self turnOff];
            } else {//开机
                return [self turnOnWithGear:self.gear hygrometer:self.setHumidity];
            }
        }];
    }
    return _power;
}

- (RACCommand *)humiditySetting {
    if (!_humiditySetting) {
        @weakify(self)
        _humiditySetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *_Nullable input) {
            @strongify(self)
            NSInteger humidity = self.setHumidity;
            if ([input boolValue]) {//增加
                humidity += 5;
                if (humidity > 85) {
                    humidity = 85;
                }
            } else {
                humidity -= 5;
                if (humidity < 40) {
                    humidity = 40;
                }
            }
            return [self settingHumidity:humidity];
        }];
    }
    return _humiditySetting;
}

- (RACCommand *)gearSetting {
    if (!_gearSetting) {
        _gearSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            uint8 gear = self.gear;
            if (gear == 1) gear = 2;
            else gear = 1;
            return [self adjustGear:gear];
        }];
    }
    return _gearSetting;
}
@end

@implementation TBHumidifierDeviceViewModel (DeviceOperatorSignal)
//获取设备初始状态
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

- (RACSignal *)turnOnWithGear:(uint8)gear hygrometer:(uint8)hy {
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x1002];
    [payload setObject:@(gear) forKey:@"param1"];
    [payload setObject:@(hy) forKey:@"param2"];
    return [self dataToDevice:payload];
}

- (RACSignal *)turnOff {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0006 subCmdId:0x1003];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingHumidity:(uint8)humidity {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2008];
    [payload setObject:@(humidity) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)adjustGear:(uint8)gear {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2007];
    [payload setObject:@(gear) forKey:@"param"];
    return [self dataToDevice:payload];
}
@end
