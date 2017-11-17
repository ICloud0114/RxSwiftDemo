//
//  TBHeaterDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBHeaterDeviceViewModel.h"

@interface TBHeaterDeviceViewModel ()
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *brightnessSetting;
@property (nonatomic, strong) RACCommand *temperatureSetting;
@end

@interface TBHeaterDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;
- (RACSignal *)settingBrightness:(NSInteger)bright;
- (RACSignal *)settingTemperature:(NSInteger)temperature;
@end

@implementation TBHeaterDeviceViewModel

- (instancetype)initWithDevice:(HMDevice *)device {
    self = [super initWithDevice:device];
    if (self) {
        _ledBrightness = 1;
    }
    return self;
}

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)
    uint8 curTemperature = [[payload objectForKey:@"curTemperature"] unsignedCharValue];
    uint8 ledBrightness = [[payload objectForKey:@"ledBrightness"] unsignedCharValue];
    uint8 setTemperature = [[payload objectForKey:@"setTemperature"] unsignedCharValue];
    uint8 workStatus = [[payload objectForKey:@"workStatus"] unsignedCharValue];
    
    Unequal_Assign(currentTemperature, curTemperature)
    Unequal_Assign(ledBrightness, ledBrightness)
    Unequal_Assign(setTemperature, setTemperature)
    Unequal_Assign(heaterStatus, workStatus)
//    self.currentTemperature = curTemperature;
//    self.ledBrightness = ledBrightness;
//    self.setTemperature = setTemperature;
//    self.heaterStatus = workStatus;
}

- (UIImage *)deviceIcon {
    return UIImage.heaterDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.heaterDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBHeaterViewController");
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

- (RACCommand *)brightnessSetting {
    if (!_brightnessSetting) {
        @weakify(self)
        _brightnessSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *_Nullable brightness) {
            @strongify(self)
            return [self settingBrightness:[brightness integerValue]];
        }];
    }
    return _brightnessSetting;
}

- (RACCommand *)temperatureSetting {
    if (!_temperatureSetting) {
        @weakify(self)
        _temperatureSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *_Nullable temperature) {
            @strongify(self)
            self.setTemperature = [temperature integerValue];
            return [self settingTemperature:[temperature integerValue]];
        }];
    }
    return _temperatureSetting;
}
@end

@implementation TBHeaterDeviceViewModel (DeviceOperatorSignal)

//获取设备初始状态
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

//设置亮度
- (RACSignal *)settingBrightness:(uint8)bright {
    NSMutableDictionary * payload = [self payloadWithTempletId:5 cmdId:0x0001 subCmdId:0x2002];
    [payload setObject:@(bright) forKey:@"param"];
    return [self dataToDevice:payload];
}

//设定温度
- (RACSignal *)settingTemperature:(NSInteger)temperature {
    NSMutableDictionary * payload = [self payloadWithTempletId:5 cmdId:0x0001 subCmdId:0x2001];
    [payload setObject:@(temperature) forKey:@"param"];
    return [self dataToDevice:payload];
}
@end
