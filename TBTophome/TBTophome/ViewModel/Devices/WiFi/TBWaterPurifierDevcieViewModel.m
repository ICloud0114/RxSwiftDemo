//
//  TBWaterPurifierDevcieViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/2/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBWaterPurifierDevcieViewModel.h"

@interface TBWaterPurifierDevcieViewModel ()
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *rinseSetting;
@property (nonatomic, strong) RACCommand *resetFilterSetting;
@end

@interface TBWaterPurifierDevcieViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;
- (RACSignal *)settingRinse:(uint8)rinse;
//复位芯片
- (RACSignal *)settingResetFilter:(uint8)filter;
@end


@implementation TBWaterPurifierDevcieViewModel

- (instancetype)initWithDevice:(HMDevice *)device {
    self = [super initWithDevice:device];
    if (self) {
        _waterPurifierStatus = 2;
        _power = NO;
    }
    return self;
}

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)
    
    uint8 workStatus = [[payload objectForKey:@"workStatus"] unsignedCharValue];
    uint8 filterC2Status = [[payload objectForKey:@"filterC2Status"] unsignedCharValue];
    uint8 filterRoStatus = [[payload objectForKey:@"filterRoStatus"] unsignedCharValue];
    uint8 waterTimeoutStatus = [[payload objectForKey:@"waterTimeoutStatus"] unsignedCharValue];
    uint16 oTDS = [[payload objectForKey:@"oTDS"] unsignedShortValue];
    uint16 iTDS = [[payload objectForKey:@"iTDS"] unsignedShortValue];
    
    self.waterPurifierStatus = workStatus;
    self.filterC2Status = filterC2Status;
    self.filterRoStatus = filterRoStatus;
    self.waterTimoutStatus = waterTimeoutStatus;
    self.oTds = oTDS;
    self.iTds = iTDS;
    self.power = YES;
}

- (UIImage *)deviceIcon {
    return UIImage.waterPurifierIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.waterPurifierOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBWaterPurifierViewController");
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

- (RACCommand *)rinseSetting {
    if (!_rinseSetting) {
        @weakify(self)
        _rinseSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            NSInteger rinse = self.waterPurifierStatus;
            if (rinse == 1) {
                rinse = 2;
            } else {
                rinse = 1;
            }
            return [self settingRinse:rinse];
        }];
    }
    return _rinseSetting;
}

- (RACCommand *)resetFilterSetting {
    if (!_resetFilterSetting) {
        _resetFilterSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable reset) {
            return [self settingResetFilter:[reset unsignedCharValue]];
        }];
    }
    return _resetFilterSetting;
}

@end

@implementation TBWaterPurifierDevcieViewModel (DeviceOperatorSignal)

- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingRinse:(uint8)rinse {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2001];
    [payload setObject:@(rinse) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)settingResetFilter:(uint8)filter {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x2016];
    [payload setObject:@(filter) forKey:@"param"];
    return [self dataToDevice:payload];
}

@end
