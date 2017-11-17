//
//  TBInductionCookingDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBInductionCookingDeviceViewModel.h"

@interface TBInductionCookingDeviceViewModel ()

@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *switchStoveHead;
@property (nonatomic, strong) RACCommand *switchStoveHeadGear;
@property (nonatomic, strong) RACCommand *switchStoveHeadTimming;
@property (nonatomic, strong) RACCommand *childLockSetting;

@end

@interface TBInductionCookingDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;

/**
 切换灶头
 */
- (RACSignal *)switchStoveHead:(uint8)headIndex;
- (RACSignal *)switchGear:(uint8)st1Gear st2Gear:(uint8)st2Gear st3Gear:(uint8)st3Gear st4Gear:(uint8)st4Gear;
- (RACSignal *)switchTiming:(uint8)st1Timing st2Timing:(uint8)st2Timing st3Timing:(uint8)st3Timing st4Timing:(uint8)st4Timing;

/**
 切换童锁
 */
- (RACSignal *)switchChildLock:(uint8)status;
@end

@implementation TBInductionCookingDeviceViewModel
//@synthesize st1WorkGear = _st1WorkGear;
    
#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
//    TBLog(@"cmd: %d", cmd)
//    TBLog(@"payload: %@", payload)
    uint8 stoveHeadCount = [[payload objectForKey:@"stoveHeadCount"] unsignedCharValue];
    uint8 lockKeyStatus = [[payload objectForKey:@"lockKeyStatus"] unsignedCharValue];
    uint8 selectedStoveHead = [[payload objectForKey:@"selectedStoveHead"] unsignedCharValue];
    uint8 st1WorkGear = [[payload objectForKey:@"st1WorkGear"] unsignedCharValue];
    uint8 st1RemainingTimging = [[payload objectForKey:@"st1RemainingTimging"] unsignedCharValue];
    uint8 st1FaultCode = [[payload objectForKey:@"st1FaultCode"] unsignedCharValue];
    uint8 st2WorkGear = [[payload objectForKey:@"st2WorkGear"] unsignedCharValue];
    uint8 st2RemainingTimging = [[payload objectForKey:@"st2RemainingTimging"] unsignedCharValue];
    uint8 st2FaultCode = [[payload objectForKey:@"st2FaultCode"] unsignedCharValue];
    uint8 st3WorkGear = [[payload objectForKey:@"st3WorkGear"] unsignedCharValue];
    uint8 st3RemainingTimging = [[payload objectForKey:@"st3RemainingTimging"] unsignedCharValue];
    uint8 st3FaultCode = [[payload objectForKey:@"st3FaultCode"] unsignedCharValue];
    uint8 st4WorkGear = [[payload objectForKey:@"st4WorkGear"] unsignedCharValue];
    uint8 st4RemainingTimging = [[payload objectForKey:@"st4RemainingTimging"] unsignedCharValue];
    uint8 st4FaultCode = [[payload objectForKey:@"st4FaultCode"] unsignedCharValue];
    
    self.stoveHeadCount = stoveHeadCount;
    self.lockKeyStatus = (lockKeyStatus == 1);
//    self.selectedStoveHead = selectedStoveHead;
    self.st1WorkGear = st1WorkGear;
    self.st1RemainingTimging = st1RemainingTimging;
    self.st1FaultCode = st1FaultCode;
    self.st2WorkGear = st2WorkGear;
    self.st2RemainingTimging = st2RemainingTimging;
    self.st2FaultCode = st2FaultCode;
    self.st3WorkGear = st3WorkGear;
    self.st3RemainingTimging = st3RemainingTimging;
    self.st3FaultCode = st3FaultCode;
    self.st4WorkGear = st4WorkGear;
    self.st4RemainingTimging = st4RemainingTimging;
    self.st4FaultCode = st4FaultCode;
    
    self.st1WorkGearIsMaxPower = (st1WorkGear == 0x0B);
    self.st1WorkGearIsLowPower = (st1WorkGear == 0x0A);
    
    self.st2WorkGearIsMaxPower = (st2WorkGear == 0x0B);
    self.st2WorkGearIsLowPower = (st2WorkGear == 0x0A);
    
    self.st3WorkGearIsMaxPower = (st3WorkGear == 0x0B);
    self.st3WorkGearIsLowPower = (st3WorkGear == 0x0A);
    
    self.st4WorkGearIsMaxPower = (st4WorkGear == 0x0B);
    self.st4WorkGearIsLowPower = (st4WorkGear == 0x0A);
}

- (UIImage *)deviceIcon {
    return UIImage.inductionCookingIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.inductionCookingOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBInductionCookingViewController");
}

#pragma mark - getter setter
//- (void)setSt1WorkGear:(NSInteger)st1WorkGear {
//    if (_st1WorkGear != st1WorkGear) {
//        _st1WorkGear = st1WorkGear;
//    }
//}
    
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

- (RACCommand *)switchStoveHead {
    if (!_switchStoveHead) {
        @weakify(self)
        _switchStoveHead = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton * _Nullable input) {
            @strongify(self)
            return [self switchStoveHead:input.tag];
        }];
    }
    return _switchStoveHead;
}

- (RACCommand *)switchStoveHeadGear {
    if (!_switchStoveHeadGear) {
        @weakify(self)
        _switchStoveHeadGear = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple * _Nullable input) {
            @strongify(self)
            NSInteger curStHead = [input.first integerValue]; //当前灶头
            NSInteger curSwitchGear = [input.second integerValue]; //当前要切换的灶头的档位
            if (curStHead == 0) {
                NSInteger st2WorkGear = self.st2WorkGear;
                if (curSwitchGear == 0x0B && st2WorkGear > 0x08) { st2WorkGear = 0x08; }
                return [self switchGear:curSwitchGear st2Gear:st2WorkGear st3Gear:self.st3WorkGear st4Gear:self.st4WorkGear];
            } else if (curStHead == 1) {
                NSInteger st1WorkGear = self.st1WorkGear;
                if (curSwitchGear == 0x0B && st1WorkGear > 0x08) { st1WorkGear = 0x08; }
                return [self switchGear:st1WorkGear st2Gear:curSwitchGear st3Gear:self.st3WorkGear st4Gear:self.st4WorkGear];
            } else if (curStHead == 2) {
                NSInteger st4WorkGear = self.st4WorkGear;
                if (curSwitchGear == 0x0B && st4WorkGear > 0x08) { st4WorkGear = 0x08; }
                return [self switchGear:self.st1WorkGear st2Gear:self.st2WorkGear st3Gear:curSwitchGear st4Gear:st4WorkGear];
            } else {
                NSInteger st3WorkGear = self.st3WorkGear;
                if (curSwitchGear == 0x0B && st3WorkGear > 0x08) { st3WorkGear = 0x08; }
                return [self switchGear:self.st1WorkGear st2Gear:self.st2WorkGear st3Gear:st3WorkGear st4Gear:curSwitchGear];
            }
        }];
    }
    return _switchStoveHeadGear;
}

- (RACCommand *)childLockSetting {
    if (!_childLockSetting) {
        @weakify(self)
        _childLockSetting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton * _Nullable input) {
            @strongify(self)
            NSInteger lock = self.lockKeyStatus ? 0 : 1;
            return [self switchChildLock:lock];
        }];
    }
    return _childLockSetting;
}

- (RACCommand *)switchStoveHeadTimming {
    if (!_switchStoveHeadTimming) {
        @weakify(self)
        _switchStoveHeadTimming = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple * _Nullable input) {
            @strongify(self)
            NSInteger curStHead = [input.first integerValue]; //当前灶头
            NSInteger curSwitchTiming = [input.second integerValue]; //当前要切换的灶头的时间
            if (curStHead == 0) {
                return [self switchTiming:curSwitchTiming st2Timing:self.st2RemainingTimging st3Timing:self.st3RemainingTimging st4Timing:self.st4RemainingTimging];
            } else if (curStHead == 1) {
                return [self switchTiming:self.st1RemainingTimging st2Timing:curSwitchTiming st3Timing:self.st3RemainingTimging st4Timing:self.st4RemainingTimging];
            } else if (curStHead == 2) {
                return [self switchTiming:self.st1RemainingTimging st2Timing:self.st2RemainingTimging st3Timing:curSwitchTiming st4Timing:self.st4RemainingTimging];
            } else {
                return [self switchTiming:self.st1RemainingTimging st2Timing:self.st2RemainingTimging st3Timing:self.st3RemainingTimging st4Timing:curSwitchTiming];
            }
        }];
    }
    return _switchStoveHeadTimming;
}

- (NSInteger)st1WorkGear {
    return _st1WorkGear;
}

- (NSInteger)st2WorkGear {
    return _st2WorkGear;
}

- (NSInteger)st3WorkGear {
    return _st3WorkGear;
}

- (NSInteger)st4WorkGear {
    return _st4WorkGear;
}
@end

#pragma mark - DeviceOperatorSignal
@implementation TBInductionCookingDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

- (RACSignal *)switchStoveHead:(uint8)headIndex {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x0015];
    [payload setObject:@(headIndex) forKey:@"param"];
    return [self dataToDevice:payload];
}

- (RACSignal *)switchGear:(uint8)st1Gear st2Gear:(uint8)st2Gear st3Gear:(uint8)st3Gear st4Gear:(uint8)st4Gear {
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x0010];
    [payload setObject:@(st1Gear) forKey:@"param1"];
    [payload setObject:@(st2Gear) forKey:@"param2"];
    [payload setObject:@(st3Gear) forKey:@"param3"];
    [payload setObject:@(st4Gear) forKey:@"param4"];
    return [self dataToDevice:payload];
}

- (RACSignal *)switchTiming:(uint8)st1Timing st2Timing:(uint8)st2Timing st3Timing:(uint8)st3Timing st4Timing:(uint8)st4Timing {
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x0011];
    [payload setObject:@(st1Timing) forKey:@"param1"];
    [payload setObject:@(st2Timing) forKey:@"param2"];
    [payload setObject:@(st3Timing) forKey:@"param3"];
    [payload setObject:@(st4Timing) forKey:@"param4"];
    return [self dataToDevice:payload];
}

- (RACSignal *)switchChildLock:(uint8)status {
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x0017];
    [payload setObject:@(status) forKey:@"param"];
    return [self dataToDevice:payload];
}
@end
