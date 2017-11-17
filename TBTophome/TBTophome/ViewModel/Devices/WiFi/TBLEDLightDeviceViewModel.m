//
//  TBLEDLightDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/1/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBLEDLightDeviceViewModel.h"

static uint16 pwm[] = {0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                      2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4,
                      4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8,
                      8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13, 13, 13, 13, 14,
                      14, 15, 15, 15, 16, 16, 17, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 23, 23,
                      24, 24, 25, 26, 26, 27, 28, 28, 29, 30, 31, 31, 32, 33, 34, 35, 36, 37, 38, 38,
                      39, 41, 42, 43, 44, 45, 46, 47, 48, 50, 51, 52, 54, 55, 56, 58, 59, 61, 63, 64,
                      66, 68, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 90, 92, 94, 97, 99, 102, 105, 107,
                      110, 113, 116, 119, 122, 125, 128, 132, 135, 139, 142, 146, 150, 154, 158, 162, 166,
                      170, 175, 179, 184, 188, 193, 198, 204, 209, 214, 220, 225, 231, 237, 243, 250, 256,
                      263, 270, 277, 284, 291, 299, 307, 315, 323, 331, 340, 349, 358, 367, 376, 386, 396,
                       406, 417, 428, 439, 450, 462, 474, 486, 499, 512, 525, 539, 553, 567, 582, 597, 612, 628, 645, 661, 678, 696, 714, 733, 752, 771, 791, 812, 833, 854, 877, 899, 923, 947, 971, 996, 1022};

@interface TBLEDLightDeviceViewModel ()
@property (nonatomic, strong) RACCommand *power;
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *colorSetting;
@end

@interface TBLEDLightDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)adjustLight:(uint16)red green:(uint16)green blue:(uint16)blue white:(uint16)white;
- (RACSignal *)initializerState;
@end

@implementation TBLEDLightDeviceViewModel

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)
    uint16 red = [[payload objectForKey:@"red"] unsignedShortValue];
    uint16 green = [[payload objectForKey:@"green"] unsignedShortValue];
    uint16 blue = [[payload objectForKey:@"blue"] unsignedShortValue];
    uint16 white = [[payload objectForKey:@"white"] unsignedShortValue];
    
    BOOL power = !(red == 0 && green == 0 && blue == 0 && white == 0);
    self.powerStatus = power;
    self.white = white;
}

- (UIImage *)deviceIcon {
    return UIImage.ledDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.ledDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBLEDLightViewController");
}

#pragma mark - getter setter
- (RACCommand *)power {
    if (!_power) {
        @weakify(self)
        _power = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            uint16 red = input.selected ? 0 : 255;
            uint16 green = input.selected ? 0 : 0;
            uint16 blue = input.selected ? 0 : 0;
            uint16 white = input.selected ? 0 : 0;
            return [self adjustLight:red green:green blue:blue white:white];
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

- (RACCommand *)colorSetting {
    if (!_colorSetting) {
        @weakify(self)
        _colorSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple *_Nullable value) {
            @strongify(self)
            return [self adjustLight:[value.first floatValue] * 255 green:[value.second floatValue] * 255 blue:[value.third floatValue] * 255 white:[value.fourth floatValue] * 1023];
        }];
    }
    return _colorSetting;
}
@end

@implementation TBLEDLightDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)adjustLight:(uint16)red green:(uint16)green blue:(uint16)blue white:(uint16)white {
    TBLog(@"red: %d, green: %d, blue: %d, white: %d", red, green, blue, white)
    
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2001];
    [payload setObject:@(pwm[red]) forKey:@"red"];
    [payload setObject:@(pwm[green]) forKey:@"green"];
    [payload setObject:@(pwm[blue]) forKey:@"blue"];
    [payload setObject:@(white) forKey:@"white"];
    return [self dataToDevice:payload];
}

//获取设备状态
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}
@end
