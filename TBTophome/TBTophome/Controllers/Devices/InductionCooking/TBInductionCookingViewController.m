//
//  TBInductionCookingViewController.m
//  TBTophome
//
//  Created by Topband on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBInductionCookingViewController.h"
#import "UIColor+Ex.h"
#import "LFInductionCookingPowerControlPanelView.h"
#import "NSArray+HoF.h"
#import "UIView+HighlightedMessage.h"
#import "LFInductionCookingCountdownView.h"

@interface TBInductionCookingViewController () <LFInductionCookingPowerControlPanelViewDelegate, LFInductionCookingCountdownViewDelegate>

//灶头1
@property (weak, nonatomic) IBOutlet UIButton *st1Bt;
@property (weak, nonatomic) IBOutlet UILabel *st1Gear;
@property (weak, nonatomic) IBOutlet UILabel *st1GearLabel;
@property (weak, nonatomic) IBOutlet UILabel *st1Timing;
@property (weak, nonatomic) IBOutlet UILabel *st1TimingLabel;
//灶头2
@property (weak, nonatomic) IBOutlet UIButton *st2Bt;
@property (weak, nonatomic) IBOutlet UILabel *st2Gear;
@property (weak, nonatomic) IBOutlet UILabel *st2GearLabel;
@property (weak, nonatomic) IBOutlet UILabel *st2Timing;
@property (weak, nonatomic) IBOutlet UILabel *st2TimingLabel;
//灶头3
@property (weak, nonatomic) IBOutlet UIButton *st3Bt;
@property (weak, nonatomic) IBOutlet UILabel *st3Gear;
@property (weak, nonatomic) IBOutlet UILabel *st3GearLabel;
@property (weak, nonatomic) IBOutlet UILabel *st3Timing;
@property (weak, nonatomic) IBOutlet UILabel *st3TimingLabel;
//灶头4
@property (weak, nonatomic) IBOutlet UIButton *st4Bt;
@property (weak, nonatomic) IBOutlet UILabel *st4Gear;
@property (weak, nonatomic) IBOutlet UILabel *st4GearLabel;
@property (weak, nonatomic) IBOutlet UILabel *st4Timing;
@property (weak, nonatomic) IBOutlet UILabel *st4TimingLabel;

@property (weak, nonatomic) IBOutlet UIButton *maxPowerBt;
@property (weak, nonatomic) IBOutlet UIView *maxPowerBgView;
@property (weak, nonatomic) IBOutlet UIImageView *maxPowerIcon;
@property (weak, nonatomic) IBOutlet UILabel *maxPowerLabel;

@property (weak, nonatomic) IBOutlet UIButton *lowPowerBt;
@property (weak, nonatomic) IBOutlet UIView *lowPowerBgView;
@property (weak, nonatomic) IBOutlet UIImageView *lowPowerIcon;
@property (weak, nonatomic) IBOutlet UILabel *lowPowerLabel;

@property (weak, nonatomic) IBOutlet UIButton *timingPowerBt;
@property (weak, nonatomic) IBOutlet UIView *timingPowerBgView;
@property (weak, nonatomic) IBOutlet UIImageView *timingPowerIcon;
@property (weak, nonatomic) IBOutlet UILabel *timingPowerLabel;

@property (weak, nonatomic) IBOutlet UIButton *childLockBt;
@property (weak, nonatomic) IBOutlet UIView *childLockBgView;
@property (weak, nonatomic) IBOutlet UIImageView *childLockIcon;
@property (weak, nonatomic) IBOutlet UILabel *childLockLabel;

@property (weak, nonatomic) IBOutlet UIView *topOverlay;

@property (weak, nonatomic) IBOutlet LFInductionCookingPowerControlPanelView *powerControlPanelView;
@property (nonatomic, strong) LFInductionCookingCountdownView *countDownView;
@end

@interface TBInductionCookingViewController (LFInductionCookingPowerControlPanelViewDelegate)

@end

@interface TBInductionCookingViewController (LFInductionCookingCountdownViewDelegate)

@end

@implementation TBInductionCookingViewController
//NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//invocation.target = viewController;
//invocation.selector = NSSelectorFromString(@"isInteractivePop");
//[invocation invoke];
//BOOL isEnable = NO;
//[invocation getReturnValue:&isEnable];
//pan.enabled = isEnable;
/**
 返回当前灶头是否是最大功率
 */
- (BOOL)currentStoveHeadGearIsEqualTargetGear:(NSInteger)tGear {
    NSInteger stHeadTag =
    [[[NSArray<UIButton *> arrayWithObjects:_st1Bt, _st2Bt, _st3Bt, _st4Bt, nil]
      filter:^BOOL(UIButton * _Nonnull x) {
          return x.selected;
      }] lastObject].tag;
    NSString *method = [NSString stringWithFormat:@"st%@WorkGear", @(stHeadTag)];
    NSMethodSignature *signature = [self.device methodSignatureForSelector:NSSelectorFromString(method)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self.device;
    invocation.selector = NSSelectorFromString(method);
    [invocation invoke];
    NSInteger gear = 0;
    [invocation getReturnValue:&gear];
    return (gear == tGear);
}

- (void)bindStoveHeadState {
    @weakify(self)
    //选中灶头信号
    RACSignal *selectedStoveHeadSignal = RACObserve(self.device, selectedStoveHead);
    
    //灶头1
    RACSignal *st1StatusSignal = [selectedStoveHeadSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] == 0);
    }];
    RAC(self.st1Bt, selected) = st1StatusSignal;
    RACSignal *st1ValueTextColorSignal = [st1StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#ff0000"] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st1Gear, textColor) = st1ValueTextColorSignal;
    RAC(self.st1Timing, textColor) = st1ValueTextColorSignal;
    RACSignal *st1ValueLabelTextColorSignal = [st1StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st1GearLabel, textColor) = st1ValueLabelTextColorSignal;
    RAC(self.st1TimingLabel, textColor) = st1ValueLabelTextColorSignal;
    //工作档位
    RAC(self.st1Gear, text) = [RACObserve(self.device, st1WorkGear) map:^id _Nullable(NSNumber * _Nullable value) {
        if ([value integerValue] == 0x0A) {
            return @"L";
        } else if ([value integerValue] == 0x0B) {
            return @"P";
        } else {
            return [value stringValue];
        }
    }];
    //定时剩余时间
    RAC(self.st1Timing, text) = [RACObserve(self.device, st1RemainingTimging) map:^id _Nullable(NSNumber * _Nullable value) {
        return [NSString stringWithFormat:@"%02d", [value intValue]];
    }];
    
    //灶头2
    RACSignal *st2StatusSignal = [selectedStoveHeadSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] == 1);
    }];
    RAC(self.st2Bt, selected) = st2StatusSignal;
    RACSignal *st2ValueTextColorSignal = [st2StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#ff0000"] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st2Gear, textColor) = st2ValueTextColorSignal;
    RAC(self.st2Timing, textColor) = st2ValueTextColorSignal;
    RACSignal *st2ValueLabelTextColorSignal = [st2StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st2GearLabel, textColor) = st2ValueLabelTextColorSignal;
    RAC(self.st2TimingLabel, textColor) = st2ValueLabelTextColorSignal;
    //工作档位
    RAC(self.st2Gear, text) = [RACObserve(self.device, st2WorkGear) map:^id _Nullable(NSNumber * _Nullable value) {
        if ([value integerValue] == 0x0A) {
            return @"L";
        } else if ([value integerValue] == 0x0B) {
            return @"P";
        } else {
            return [value stringValue];
        }
    }];
    //定时剩余时间
    RAC(self.st2Timing, text) = [RACObserve(self.device, st2RemainingTimging) map:^id _Nullable(NSNumber * _Nullable value) {
        return [NSString stringWithFormat:@"%02d", [value intValue]];
    }];
    
    //灶头3
    RACSignal *st3StatusSignal = [selectedStoveHeadSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] == 2);
    }];
    RAC(self.st3Bt, selected) = st3StatusSignal;
    RACSignal *st3ValueTextColorSignal = [st3StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#ff0000"] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st3Gear, textColor) = st3ValueTextColorSignal;
    RAC(self.st3Timing, textColor) = st3ValueTextColorSignal;
    RACSignal *st3ValueLabelTextColorSignal = [st3StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st3GearLabel, textColor) = st3ValueLabelTextColorSignal;
    RAC(self.st3TimingLabel, textColor) = st3ValueLabelTextColorSignal;
    //工作档位
    RAC(self.st3Gear, text) = [RACObserve(self.device, st3WorkGear) map:^id _Nullable(NSNumber * _Nullable value) {
        if ([value integerValue] == 0x0A) {
            return @"L";
        } else if ([value integerValue] == 0x0B) {
            return @"P";
        } else {
            return [value stringValue];
        }
    }];
    //定时剩余时间
    RAC(self.st3Timing, text) = [RACObserve(self.device, st3RemainingTimging) map:^id _Nullable(NSNumber * _Nullable value) {
        return [NSString stringWithFormat:@"%02d", [value intValue]];
    }];
    
    //灶头4
    RACSignal *st4StatusSignal = [selectedStoveHeadSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] == 3);
    }];
    RAC(self.st4Bt, selected) = st4StatusSignal;
    RACSignal *st4ValueTextColorSignal = [st4StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#ff0000"] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st4Gear, textColor) = st4ValueTextColorSignal;
    RAC(self.st4Timing, textColor) = st4ValueTextColorSignal;
    RACSignal *st4ValueLabelTextColorSignal = [st4StatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#8c8c8c"];
    }];
    RAC(self.st4GearLabel, textColor) = st4ValueLabelTextColorSignal;
    RAC(self.st4TimingLabel, textColor) = st4ValueLabelTextColorSignal;
    //工作档位
    RAC(self.st4Gear, text) = [RACObserve(self.device, st4WorkGear) map:^id _Nullable(NSNumber * _Nullable value) {
        if ([value integerValue] == 0x0A) {
            return @"L";
        } else if ([value integerValue] == 0x0B) {
            return @"P";
        } else {
            return [value stringValue];
        }
    }];
    //定时剩余时间
    RAC(self.st4Timing, text) = [RACObserve(self.device, st4RemainingTimging) map:^id _Nullable(NSNumber * _Nullable value) {
        return [NSString stringWithFormat:@"%02d", [value intValue]];
    }];
    
    //最大功率
    RACSignal *curStIsMaxPowerSignal =
    [selectedStoveHeadSignal map:^id _Nullable(NSNumber *_Nullable value) {
        @strongify(self)
        NSInteger stHead = [value integerValue];
        if (stHead == 0) { return @(self.device.st1WorkGear == 0x0B); }
        else if (stHead == 1) { return @(self.device.st2WorkGear == 0x0B); }
        else if (stHead == 2) { return @(self.device.st3WorkGear == 0x0B); }
        else { return @(self.device.st4WorkGear == 0x0B); }
    }];
    
    //保温
    RACSignal *curStIsLowPowerSignal =
    [selectedStoveHeadSignal map:^id _Nullable(NSNumber *_Nullable value) {
        @strongify(self)
        NSInteger stHead = [value integerValue];
        if (stHead == 0) { return @(self.device.st1WorkGear == 0x0A); }
        else if (stHead == 1) { return @(self.device.st2WorkGear == 0x0A); }
        else if (stHead == 2) { return @(self.device.st3WorkGear == 0x0A); }
        else { return @(self.device.st4WorkGear == 0x0A); }
    }];
    
    /**
     当前灶头档位发生变化
     */
    RACSignal *curStHeadGearChangeSignal =
    [RACSignal merge:@[
                        [RACObserve(self.device, st1WorkGear)
                         filter:^BOOL(id  _Nullable value) {
                             @strongify(self)
                             return self.st1Bt.selected;
                         }],
                        [RACObserve(self.device, st2WorkGear)
                         filter:^BOOL(id  _Nullable value) {
                             @strongify(self)
                             return self.st2Bt.selected;
                         }],
                        [RACObserve(self.device, st3WorkGear)
                         filter:^BOOL(id  _Nullable value) {
                             @strongify(self)
                             return self.st3Bt.selected;
                         }],
                        [RACObserve(self.device, st4WorkGear)
                         filter:^BOOL(id  _Nullable value) {
                             @strongify(self)
                             return self.st4Bt.selected;
                         }]]
     ];
    
    RACSignal *maxPowerIsSelectedSignal = [RACSignal merge:@[
                                                             curStIsMaxPowerSignal,
                                                             [curStHeadGearChangeSignal map:^id _Nullable(NSNumber * _Nullable gear) {
        return @([gear integerValue] == 0x0B);
    }]]];
    RACSignal *lowPowerIsSelectedSignal = [RACSignal merge:@[
                                                             curStIsLowPowerSignal,
                                                             [curStHeadGearChangeSignal map:^id _Nullable(NSNumber * _Nullable gear) {
        return @([gear integerValue] == 0x0A);
    }]]];

    RAC(self.maxPowerIcon, highlighted) = [maxPowerIsSelectedSignal filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return !self.device.lockKeyStatus;
    }];
    RAC(self.maxPowerBt, selected) = maxPowerIsSelectedSignal;

    RAC(self.lowPowerIcon, highlighted) = [lowPowerIsSelectedSignal filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return !self.device.lockKeyStatus;
    }];
    RAC(self.lowPowerBt, selected) = lowPowerIsSelectedSignal;
    
    //绑定童锁状态
    RACChannelTo(self.childLockIcon, highlighted) = RACChannelTo(self.device, lockKeyStatus);
    RACChannelTo(self.childLockBt, selected) = RACChannelTo(self.device, lockKeyStatus);
    RAC(self.topOverlay, hidden) = [RACObserve(self.device, lockKeyStatus) map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    
    RACSignal *lockKeyStatusSignal = RACObserve(self.device, lockKeyStatus);
    
    //控制面板
//    RACSignal *panelSignal = [RACSignal combineLatest:@[
//                                                        lockKeyStatusSignal,
//                                                        [selectedStoveHeadSignal map:^id _Nullable(NSNumber *_Nullable value) {
//        @strongify(self)
//        NSInteger stHead = [value integerValue];
//        NSInteger gear = 0;
//        if (stHead == 0) { gear = self.device.st1WorkGear; }
//        else if (stHead == 1) { gear = self.device.st2WorkGear; }
//        else if (stHead == 2) { gear = self.device.st3WorkGear; }
//        else { gear = self.device.st4WorkGear; }
//            return @(gear == 0x0B || gear == 0x0A);
//    }], [curStHeadGearChangeSignal map:^id _Nullable(NSNumber * _Nullable gear) {
//        return @([gear integerValue] == 0x0A || [gear integerValue] == 0x0B);
//    }]] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3){
//        return @([value1 boolValue] || [value2 boolValue] || [value3 boolValue]);
//    }];
//    [RACSignal merge:@[lockKeyStatusSignal, curStIsMaxPowerSignal, curStIsLowPowerSignal, [curStHeadGearChangeSignal map:^id _Nullable(NSNumber * _Nullable gear) {
//        return @([gear integerValue] == 0x0A || [gear integerValue] == 0x0B);
//    }]]];
//    RAC(self.powerControlPanelView.layer, opacity) = [panelSignal map:^id _Nullable(NSNumber * _Nullable value) {
//        return [value boolValue] ? @0.4 : @1;
//    }];
//    RAC(self.powerControlPanelView, disenabled) = panelSignal;//RACChannelTo(self.device, lockKeyStatus);
    RACSignal *panelSinal =
    [RACObserve(self.device, selectedStoveHead) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        NSInteger stHead = [value integerValue];
        NSInteger gear = 0;
        if (stHead == 0) { gear = self.device.st1WorkGear; }
        else if (stHead == 1) { gear = self.device.st2WorkGear; }
        else if (stHead == 2) { gear = self.device.st3WorkGear; }
        else { gear = self.device.st4WorkGear; }
        return @((gear == 0x0A || gear == 0x0B));
    }];
    RAC(self.powerControlPanelView.layer, opacity) = [panelSinal map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];
    RACSignal *gear1 = [[RACSignal combineLatest:@[RACObserve(self.device, st1WorkGearIsMaxPower), RACObserve(self.device, st1WorkGearIsLowPower)] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
        return @(([value1 boolValue] || [value2 boolValue]));
    }] filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return self.st1Bt.selected && !self.device.lockKeyStatus;
    }];
    RACSignal *gear2 = [[RACSignal combineLatest:@[RACObserve(self.device, st2WorkGearIsMaxPower), RACObserve(self.device, st2WorkGearIsLowPower)] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
        return @(([value1 boolValue] || [value2 boolValue]));
    }] filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return self.st2Bt.selected && !self.device.lockKeyStatus;
    }];
    RACSignal *gear3 = [[RACSignal combineLatest:@[RACObserve(self.device, st3WorkGearIsMaxPower), RACObserve(self.device, st3WorkGearIsLowPower)] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
        return @(([value1 boolValue] || [value2 boolValue]));
    }] filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return self.st3Bt.selected && !self.device.lockKeyStatus;
    }];
    RACSignal *gear4 = [[RACSignal combineLatest:@[RACObserve(self.device, st4WorkGearIsMaxPower), RACObserve(self.device, st4WorkGearIsLowPower)] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
        return @(([value1 boolValue] || [value2 boolValue]));
    }] filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return self.st4Bt.selected && !self.device.lockKeyStatus;
    }];
    
//    RACSignal *gearTotalSianl = [RACSignal combineLatest:@[gear1, gear2, gear3, gear4]
//                                                  reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3, NSNumber *value4){
//                                                      return @(([value1 boolValue] || [value2 boolValue] || [value3 boolValue] || [value4 boolValue]));
//                                                  }];
    RAC(self.powerControlPanelView.layer, opacity) = [gear1 map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];
    RAC(self.powerControlPanelView.layer, opacity) = [gear2 map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];
    RAC(self.powerControlPanelView.layer, opacity) = [gear3 map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];
    RAC(self.powerControlPanelView.layer, opacity) = [gear4 map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];
    RAC(self.powerControlPanelView.layer, opacity) = [RACObserve(self.device, lockKeyStatus) map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];

    RAC(self.powerControlPanelView, disenabled) = gear1;
    RAC(self.powerControlPanelView, disenabled) = gear2;
    RAC(self.powerControlPanelView, disenabled) = gear3;
    RAC(self.powerControlPanelView, disenabled) = gear4;
    
    RAC(self.powerControlPanelView, disenabled) = RACObserve(self.device, lockKeyStatus);

//    RAC(self.powerControlPanelView.layer, opacity) = [[[RACSignal combineLatest:@[RACObserve(self.device, st1WorkGearIsMaxPower), RACObserve(self.device, st1WorkGearIsLowPower)] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
//        return @(([value1 boolValue] || [value2 boolValue]));
//    }] filter:^BOOL(id  _Nullable value) {
//        @strongify(self)
//        return self.st1Bt.selected;
//    }] map:^id _Nullable(id  _Nullable value) {
//        return [value boolValue] ? @0.4 : @1;
//    }];
    
//    RAC(self.powerControlPanelView.layer, opacity) = [lowPowerIsSelectedSignal map:^id _Nullable(id  _Nullable value) {
//        return [value boolValue] ? @0.4 : @1;
//    }];
    //当灶头发生变化
    RACSignal *panelValueSignal1 =
    [[selectedStoveHeadSignal map:^id _Nullable(NSNumber *_Nullable value) {
        @strongify(self)
        NSInteger stHead = [value integerValue];
        if (stHead == 0) { return @(self.device.st1WorkGear); }
        else if (stHead == 1) { return @(self.device.st2WorkGear); }
        else if (stHead == 2) { return @(self.device.st3WorkGear); }
        else { return @(self.device.st4WorkGear); }
    }] map:^id _Nullable(NSNumber *_Nullable value) {
        if ([value integerValue] > 0x09) {
            return @(0x00);
        }
        return value;
    }];
    RACSignal *panelValueSignal2 = [curStHeadGearChangeSignal map:^id _Nullable(NSNumber *_Nullable value) {
        if ([value integerValue] > 0x09) {
            return @(0x00);
        }
        return value;
    }];
    RAC(self.powerControlPanelView, power) = [RACSignal merge:@[panelValueSignal1, panelValueSignal2]];
    //童锁和最大功率关联
    RAC(self.maxPowerIcon, image) = [lockKeyStatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if ([value boolValue]) {
            self.maxPowerIcon.highlighted = NO;
        } else {
            self.maxPowerIcon.highlighted = [self currentStoveHeadGearIsEqualTargetGear:0x0B];
        }
        return [value boolValue] ? [UIImage imageNamed:@"btn_P_disable.png"] : [UIImage imageNamed:@"btn_P_normal.png"];
    }];
    RAC(self.maxPowerLabel, textColor) = [lockKeyStatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.maxPowerBt, enabled) = [lockKeyStatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    //童锁和最小功率关联
    RAC(self.lowPowerIcon, image) = [lockKeyStatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if ([value boolValue]) {
            self.lowPowerIcon.highlighted = NO;
        } else {
            self.lowPowerIcon.highlighted = [self currentStoveHeadGearIsEqualTargetGear:0x0A];
        }
        return [value boolValue] ? [UIImage imageNamed:@"btn_L_disable.png"] : [UIImage imageNamed:@"btn_L_normal.png"];
    }];
    RAC(self.lowPowerLabel, textColor) = [lockKeyStatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.lowPowerBt, enabled) = [lockKeyStatusSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    
    //定时状态
    RACSignal *timmingGearSignal =
    [selectedStoveHeadSignal map:^id _Nullable(NSNumber *_Nullable value) {
        @strongify(self)
        NSInteger stHead = [value integerValue];
        if (stHead == 0) { return @((self.device.st1WorkGear == 0x0A || self.device.st1WorkGear == 0x00)); }
        else if (stHead == 1) { return @((self.device.st2WorkGear == 0x0A || self.device.st2WorkGear == 0x00)); }
        else if (stHead == 2) { return @((self.device.st3WorkGear == 0x0A || self.device.st3WorkGear == 0x00)); }
        else { return @((self.device.st4WorkGear == 0x0A || self.device.st4WorkGear == 0x00)); }
    }];
    RACSignal *timmingDisenableSignal =
    [RACSignal merge:@[
                       timmingGearSignal,
                       RACObserve(self.childLockIcon, highlighted),
                       [[curStHeadGearChangeSignal filter:^BOOL(id  _Nullable value) {
        @strongify(self)
        return !self.device.lockKeyStatus;
    }] map:^id _Nullable(NSNumber * _Nullable gear) {
        return @(([gear integerValue] == 0x0A || [gear integerValue] == 0x00));
    }]
                       ]];
//    [RACSignal combineLatest:@[
//                               timmingGearSignal,
//                               RACObserve(self.childLockIcon, highlighted),
//                               [curStHeadGearChangeSignal map:^id _Nullable(NSNumber * _Nullable gear) {
//        return @(([gear integerValue] == 0x0A || [gear integerValue] == 0x00));
//    }]
//                               ] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3){
//                                   TBLog(@"1:%@,2:%@,3:%@", value1, value2, value3)
////                                   TBLog(@"4:%@", @([value1 boolValue] || [value2 boolValue] || [value3 boolValue]))
//                                   return @([value1 boolValue] || [value2 boolValue] || [value3 boolValue]);
//                               }];
//    [RACSignal merge:@[
//                       [curStHeadGearChangeSignal map:^id _Nullable(NSNumber * _Nullable gear) {
//        return @([gear integerValue] == 0x0A);
//    }],
//                        RACObserve(self.childLockIcon, highlighted)
//                        ]];
    [timmingDisenableSignal subscribeNext:^(id  _Nullable x) {
//        TBLog(@"%@", x)
        self.timingPowerIcon.highlighted = [x boolValue];
//        self.timingPowerIcon.image = [x boolValue] ? [UIImage imageNamed:@"btn_countdown_disable.png"] : [UIImage imageNamed:@"btn_countdown_normal.png"];
    }];
//    RAC(self.timingPowerIcon, highlighted) = timmingDisenableSignal;
    RAC(self.timingPowerLabel, textColor) = [timmingDisenableSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.timingPowerBt, enabled) = [timmingDisenableSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
}

- (void)bindState {
    @weakify(self)
    [self bindStoveHeadState];
// 
//   
//    
//    //定时状态
//    RAC(self.timingPowerIcon, highlighted) = RACObserve(self.device, selected);
//    RAC(self.timingPowerIcon, highlighted) = RACObserve(self.lowPowerIcon, highlighted);
//    RAC(self.timingPowerIcon, highlighted) = RACObserve(self.childLockIcon, highlighted);

}

- (void)bindMaxPowerAction {
    @weakify(self)
    /**
     最大功率
     */
    [[self.maxPowerBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         NSInteger stHeadIndex =
         [[[NSArray<UIButton *> arrayWithObjects:self.st1Bt, self.st2Bt, self.st3Bt, self.st4Bt, nil]
           filter:^BOOL(UIButton * _Nonnull x) {
               return x.selected;
           }] lastObject].tag - 1;
         
         NSString *message = nil;
         if (x.selected) {
             message = [NSString stringWithFormat:@"%@\n%@", LFLocalizableString(@"Max Power", nil), LFLocalizableString(@"Closed", nil)];
             [self.device.switchStoveHeadGear execute:[RACTuple tupleWithObjects:@(stHeadIndex), @(0x00), nil]];
         } else {
             message = [NSString stringWithFormat:@"%@\n%@", LFLocalizableString(@"Max Power", nil), LFLocalizableString(@"Opened", nil)];
             [self.device.switchStoveHeadGear execute:[RACTuple tupleWithObjects:@(stHeadIndex), @(0x0B), nil]];
         }
         [self.maxPowerBgView showHightLightMessage:message bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
     }];
}

- (void)bindLowPowerAction {
    @weakify(self)
    [[self.lowPowerBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         NSInteger stHeadIndex =
         [[[NSArray<UIButton *> arrayWithObjects:self.st1Bt, self.st2Bt, self.st3Bt, self.st4Bt, nil]
           filter:^BOOL(UIButton * _Nonnull x) {
               return x.selected;
           }] lastObject].tag - 1;
         
         NSString *message = nil;
         if (x.selected) {
             message = [NSString stringWithFormat:@"%@\n%@", LFLocalizableString(@"Heat Pre", nil), LFLocalizableString(@"Closed", nil)];
             [self.device.switchStoveHeadGear execute:[RACTuple tupleWithObjects:@(stHeadIndex), @(0x00), nil]];
         } else {
             message = [NSString stringWithFormat:@"%@\n%@", LFLocalizableString(@"Heat Pre", nil), LFLocalizableString(@"Opened", nil)];
             [self.device.switchStoveHeadGear execute:[RACTuple tupleWithObjects:@(stHeadIndex), @(0x0A), nil]];
         }
         [self.lowPowerBgView showHightLightMessage:message bgColor:[UIColor colorWithHexString:@"#EE5340"]];
     }];
}

- (void)bindChildLockAction {
    @weakify(self)
    self.childLockBt.rac_command = self.device.childLockSetting;
    [[self.childLockBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         NSString *message =
         x.selected ? [NSString stringWithFormat:@"%@\n%@", LFLocalizableString(@"Locking", nil), LFLocalizableString(@"Closed", nil)] : [NSString stringWithFormat:@"%@\n%@", LFLocalizableString(@"Locking", nil), LFLocalizableString(@"Opened", nil)];
         [self.childLockBgView showHightLightMessage:message bgColor:[UIColor colorWithHexString:@"#63C145"]];
    }];
}

- (void)bindAction {
    @weakify(self)
    //切换灶头
    [[RACSignal merge:@[
                        [self.st1Bt rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.st2Bt rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.st3Bt rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.st4Bt rac_signalForControlEvents:UIControlEventTouchUpInside]
                       ]] subscribeNext:^(UIButton * _Nullable x) {
        @strongify(self)
        self.device.selectedStoveHead = x.tag - 1;
    }];
    
    [self bindMaxPowerAction];
    [self bindLowPowerAction];
    [self bindChildLockAction];
    
    //定时action
    [self.countDownView rac_liftSelector:@selector(showInView:)
                   withSignalOfArguments:[[self.timingPowerBt rac_signalForControlEvents:UIControlEventTouchUpInside]
                                          map:^id _Nullable(__kindof UIControl * _Nullable value) {
                                              @strongify(self)
                                              return [RACTuple tupleWithObjects:self.navigationController.view, nil];
                                          }]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindState];
    [self bindAction];
    [self.device.deviceState execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter setter
- (LFInductionCookingCountdownView *)countDownView {
    if (!_countDownView) {
        _countDownView = [LFInductionCookingCountdownView inductionCookingCountdownView];
        _countDownView.delegate = self;
    }
    return _countDownView;
}
@end

@implementation TBInductionCookingViewController (LFInductionCookingPowerControlPanelViewDelegate)

- (void)didChangeGear:(NSInteger)gear {
    NSInteger stHeadIndex =
    [[[NSArray<UIButton *> arrayWithObjects:_st1Bt, _st2Bt, _st3Bt, _st4Bt, nil]
     filter:^BOOL(UIButton * _Nonnull x) {
        return x.selected;
    }] lastObject].tag - 1;
    [self.device.switchStoveHeadGear execute:[RACTuple tupleWithObjects:@(stHeadIndex), @(gear), nil]];
}

@end

@implementation TBInductionCookingViewController (LFInductionCookingCountdownViewDelegate)

- (void)didSelectedCountdownTime:(NSUInteger)min {
    NSInteger stHeadIndex =
    [[[NSArray<UIButton *> arrayWithObjects:_st1Bt, _st2Bt, _st3Bt, _st4Bt, nil]
      filter:^BOOL(UIButton * _Nonnull x) {
          return x.selected;
      }] lastObject].tag - 1;
    [self.device.switchStoveHeadTimming execute:[RACTuple tupleWithObjects:@(stHeadIndex), @(min), nil]];
}

@end
