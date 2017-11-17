//
//  TBCoffeeDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/2/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBCoffeeDeviceViewModel.h"

@interface TBCoffeeDeviceViewModel ()
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *startWorkSetting;
@property (nonatomic, strong) RACCommand *stopWorkSetting;
@property (nonatomic, strong) RACCommand *wakeupSetting;
@property (nonatomic, strong) RACCommand *temperatureSetting;
@end

@interface TBCoffeeDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;

/**
 启动工作
 @param size 杯尺寸
 */
- (RACSignal *)startWorkWithSize:(uint8)size;
- (RACSignal *)stopWork;
- (RACSignal *)wakeup;
- (RACSignal *)settingTemperature:(uint8)temp;
@end

@implementation TBCoffeeDeviceViewModel

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"payload: %@", payload)
    uint8 handleStatus = [[payload objectForKey:@"handleStatus"] unsignedCharValue]; //拉柄状态
    uint8 coffeeStatus = [[payload objectForKey:@"coffeeStatus"] unsignedCharValue]; //煲咖啡状态
    uint8 systemStatus = [[payload objectForKey:@"systemStatus"] unsignedCharValue]; //系统状态
    uint8 currentTemp = [[payload objectForKey:@"currentTemp"] unsignedCharValue]; //当前温度
    uint32 coffeeCups = [[payload objectForKey:@"coffeeCups"] unsignedIntValue]; //咖啡杯数

    Unequal_Assign(curHandleStatus, handleStatus)
    Unequal_Assign(curCoffeeStatus, coffeeStatus)
    Unequal_Assign(curSystemStatus, systemStatus)
    Unequal_Assign(curTemp, currentTemp)
    Unequal_Assign(curCoffeeCups, coffeeCups)
}

- (UIImage *)deviceIcon {
    return UIImage.coffeeDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.coffeeDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBCoffeeViewController");
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

- (RACCommand *)startWorkSetting {
    if (!_startWorkSetting) {
        @weakify(self)
        _startWorkSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            uint8 size = [input unsignedCharValue];
            return [self startWorkWithSize:size];
        }];
    }
    return _startWorkSetting;
}

- (RACCommand *)stopWorkSetting {
    if (!_stopWorkSetting) {
        @weakify(self)
        _stopWorkSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self stopWork];
        }];
    }
    return _stopWorkSetting;
}

- (RACCommand *)wakeupSetting {
    if (!_wakeupSetting) {
        @weakify(self)
        _wakeupSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self wakeup];
        }];
    }
    return _wakeupSetting;
}

- (RACCommand *)temperatureSetting {
    if (!_temperatureSetting) {
        @weakify(self)
        _temperatureSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            uint8 temp = [input unsignedCharValue];
            return [self settingTemperature:temp];
        }];
    }
    return _temperatureSetting;
}
@end

@implementation TBCoffeeDeviceViewModel (DeviceOperatorSignal)

- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

- (RACSignal *)startWorkWithSize:(uint8)size {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2007];
    [payload setObject:@(size) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)stopWork {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2009];
    return [self dataToDevice:payload];
}

- (RACSignal *)wakeup {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2006];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingTemperature:(uint8)temp {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2008];
    [payload setObject:@(temp) forKey:@"param"];
    return [self dataToDevice:payload];
}

@end
