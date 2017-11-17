//
//  TBCookingMachineViewController.m
//  TBTophome
//
//  Created by Topband on 2017/2/16.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBCookingMachineViewController.h"
#import "TBIconImageView.h"
#import "LFCookingMachineView.h"
#import "LFCookingMachineTimeView.h"
#import "UIColor+Ex.h"
#import "UIView+HighlightedMessage.h"

static uint8 temperatureList[] = {0, 37, 50, 60, 70, 80, 90, 100, 120};

@interface TBCookingMachineViewController ()<LFCookingMachineViewDelegate, LFCookingMachineTimeViewDelegate>

@property (nonatomic) LFCookingMachineView *cookingMachineView;
@property (weak, nonatomic) IBOutlet LFCookingMachineTimeView *timeView;
    
@end

@interface TBCookingMachineViewController (LFCookingMachineViewDelegate)

@end

@interface TBCookingMachineViewController (LFCookingMachineTimeViewDelegate)

@end

@implementation TBCookingMachineViewController

- (void)bindState {
    @weakify(self)
    //监听档位
    RACSignal *gearSignal = [RACObserve(self.device, curGears) takeUntil:[self rac_willDeallocSignal]];
    //温度监听
    RACSignal *tempSignal = [RACObserve(self.device, curTemp) takeUntil:[self rac_willDeallocSignal]];
    //监听工作模式
    RACSignal *workModeSignal = [RACObserve(self.device, curWorkMode) takeUntil:[self rac_willDeallocSignal]];
    //监听转向
    RACSignal *steering = [RACObserve(self.device, curSteering) takeUntil:[self rac_willDeallocSignal]];
    //是否处于称重
    RACSignal *weightSignal = [[RACObserve(self.device, curMenu) takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(id  _Nullable value) {
        return @([value integerValue] == 1);
    }];
    //监听倒计时时间
    RACSignal *timeSignal = [RACObserve(self.device, curTime) takeUntil:[self rac_willDeallocSignal]];
    //监听当前重量
    RACSignal *curWeightSignal = [RACObserve(self.device, curWeight) takeUntil:[self rac_willDeallocSignal]];
    //档位
//    RACSignal *gearSignal = RACObserve(self.device, curGears);
//    RAC(_cookingMachineView, circleSegmentIndex) = gearSignal;
    RAC(self.cookingMachineView, circleSegmentIndex) = [gearSignal map:^id _Nullable(id  _Nullable x) {
        if ([x integerValue] == 0) {
            return @11;
        } else {
            return @([x integerValue] - 1);
        }
    }];
    RAC(self.cookingMachineView.gearLabel, text) = [gearSignal map:^id _Nullable(id  _Nullable x) {
        if ([x integerValue] == 0) {
            return @"揉面档";
        } else {
            return [NSString stringWithFormat:@"%@档", @([x integerValue] - 1)];
        }
    }];
    
    //温度
    RAC(self.cookingMachineView, temperatureIndex) = tempSignal;
    RAC(self.cookingMachineView.temperatureLabel, text) = [tempSignal map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%d℃", temperatureList[[value intValue]]];
    }];
    //时间
    RACSignal *timeFormatSignal = [timeSignal map:^id _Nullable(NSNumber * _Nullable time) {
        int ti = [time intValue];
        return [NSString stringWithFormat:@"%02d:%02d", ti / 60, ti % 60];
    }];
    RAC(self.timeView, seconds) = timeSignal;
    RAC(self.cookingMachineView.machineTimeLabel, text) = timeFormatSignal;
    RAC(self.cookingMachineView.timeLabel, text) = timeFormatSignal;
    
    //点动
    RACSignal *rollMaxStateSignal =
    [RACSignal combineLatest:@[workModeSignal, gearSignal, steering]
                      reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3){
                          @strongify(self)
                          NSInteger workMode = [value1 integerValue];
                          NSInteger gear = [value2 integerValue];
                          NSInteger steering = [value3 integerValue];
                        
                          if (workMode == 3) {
                              return @1;
                          } else if (workMode == 1) {
                              return @2;
                          } else if (workMode == 4 || workMode == 5) {
                              if (gear == 0 || gear == 1 || steering == 1) {
                                  return @2;
                              }
                          }
                          return @0;
                      }];
//    RACSignal *rollMaxStateSignal = [workModeSignal map:^id _Nullable(id  _Nullable value) {
//        @strongify(self)
//        NSInteger workMode = [value integerValue];
//        if (workMode == 3) {
//            return @1;
//        } else if (workMode == 1) {
//            return @2;
//        } else if (workMode == 4 || workMode == 5) {
//            if (self.device.curGears == 0 || self.device.curSteering == 1) {
//                return @2;
//            }
//        }
//        return @0;
//    }];
    RAC(self.overlay, hidden) = [workModeSignal map:^id _Nullable(id  _Nullable value) {
        return @([value integerValue] != 3);
    }];
    RAC(self.cookingMachineView.rollMaxIcon, state) = rollMaxStateSignal;
    RAC(self.cookingMachineView.rollMaxLabel, textColor) = [rollMaxStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.cookingMachineView.rollMaxBts, enabled) = [rollMaxStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    //反转
    RACSignal *reverseStateSignal =
    [RACSignal combineLatest:@[workModeSignal, steering] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
//        TBLog(@"value1: %@, value2: %@", value1, value2)
        NSInteger steering = [value2 integerValue]; //转向
        NSInteger mode = [value1 integerValue]; //模式
        if (mode == 0) { //料理机处于停止
            return @(steering);
        } else {
            return @2;
        }
    }];
    RAC(self.cookingMachineView.reverseState, hidden) = [steering map:^id _Nullable(id  _Nullable value) {
        return @([value intValue] == 0);
    }];
    RAC(self.cookingMachineView.reverseIcon, state) = reverseStateSignal;
    RAC(self.cookingMachineView.reverseLabel, textColor) = [reverseStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.cookingMachineView.reverseBts, enabled) = [reverseStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    //称重
    RACSignal *weightStateSignal = [RACSignal combineLatest:@[workModeSignal, weightSignal] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
//        TBLog(@"value1: %@, value2: %@", value1, value2)
        BOOL weightState = [value2 boolValue]; //称重
        NSInteger mode = [value1 integerValue]; //模式
        if (mode == 0) { //料理机处于停止
            return weightState ? @1 : @0;
        } else {
            return @2;
        }
    }];
    RACSignal *isShowWeightStateSignal = [weightSignal map:^id _Nullable(id  _Nullable value) {
        return @(![value boolValue]);
    }];
    RAC(self.cookingMachineView.weightState, hidden) = isShowWeightStateSignal;
    RAC(self.cookingMachineView.weightValue, hidden) = isShowWeightStateSignal;
    RAC(self.cookingMachineView.weightValue, text) = [curWeightSignal map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%@g", value];
    }];
    RAC(self.cookingMachineView.weightIcon, state) = weightStateSignal;
    RAC(self.cookingMachineView.weightLabel, textColor) = [weightStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.cookingMachineView.weightBts, enabled) = [weightStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    //开始/暂停
    //开始的按钮状态和当前工作模式和档位有关
    RACSignal *startStateSignal = [RACSignal combineLatest:@[workModeSignal, gearSignal, tempSignal, timeSignal, steering] reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3, NSNumber *value4, NSNumber *value5){
        NSInteger mode = [value1 integerValue]; //工作模式
        NSInteger gear = [value2 integerValue]; //档位
        NSInteger temp = [value3 integerValue]; //温度
        NSInteger time = [value4 integerValue]; //时间
        NSInteger steering = [value5 integerValue]; //转向
        if (mode == 3) { //点动
            return @2;
        } else if (mode == 1 || mode == 0) { //暂停或停止中要判断当前档位是否是0挡
            if (gear == 0 && steering == 1) { //当处于揉面档时开启反转不可开始
                return @2;
            }
            if (temp == 0) { //如果温度等于0，则不考虑时间, 否则要考虑时间
                return gear == 1 ? @2 : @0;
            } else {
                return (gear == 1 || time == 0) ? @2 : @0; //档位或时间为0则都不可以开始
            }
        } else {
            return @1;
        }
    }];
    RAC(self.cookingMachineView.playPauseIcon, state) = startStateSignal;
    RAC(self.cookingMachineView.playPauseLabel, textColor) = [startStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.cookingMachineView.playPauseBts, enabled) = [startStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    
    //停止
    RACSignal *stopStateSignal = [workModeSignal map:^id _Nullable(id  _Nullable value) {
        NSInteger mode = [value integerValue]; //模式
        if (mode == 0 || mode == 3) { //停止或点动
            return @2;
        } else {
            return @0;
        }
    }];
    RAC(self.cookingMachineView.stopIcon, state) = stopStateSignal;
    RAC(self.cookingMachineView.stopLabel, textColor) = [stopStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.cookingMachineView.stopBts, enabled) = [stopStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
//    RACSignal *reverseStateSignal = [workModeSignal map:^id _Nullable(id  _Nullable value) {
//        NSInteger workMode = [value integerValue];
//        if (workMode == 3) {
//            return @1;
//        } else if (workMode == 1) {
//            return @2;
//        }
//        return @0;
//    }];
}
    
- (void)bindAction {
    @weakify(self)
    self.cookingMachineView.rollMaxBts.rac_command = self.device.rollMaxSetting;
    [[self.cookingMachineView.rollMaxBts rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.cookingMachineView.rollMaxIcon.state == normalState) {
            [self.cookingMachineView.rollMaxBgView showHightLightMessage:@"点动模式\n已开启" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
        } else {
            [self.cookingMachineView.rollMaxBgView showHightLightMessage:@"点动模式\n已关闭" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
        }
    }];
    
    self.cookingMachineView.reverseBts.rac_command = self.device.reverseSetting;
    [[self.cookingMachineView.reverseBts rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        NSInteger gear = self.device.curGears;
        if (self.cookingMachineView.reverseIcon.state == normalState) {
            [self.cookingMachineView.reverseBgView showHightLightMessage:@"反转模式\n已开启" bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
        } else {
            [self.cookingMachineView.reverseBgView showHightLightMessage:@"反转模式\n已关闭" bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
        }
    }];
    
//    self.cookingMachineView.weightBts.rac_command = self.device.weightSetting;
    [[self.cookingMachineView.weightBts rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.cookingMachineView.weightIcon.state == normalState) {
            [self.device.weightSetting execute:nil];
            [self.cookingMachineView.weightBgView showHightLightMessage:@"称重模式\n已开启"
                                                                bgColor:[UIColor colorWithHexString:@"#6466F3"]];
        } else {
            [self.device.gearSetting execute:@(self.device.curGears)];
            [self.cookingMachineView.weightBgView showHightLightMessage:@"称重模式\n已关闭"
                                                                bgColor:[UIColor colorWithHexString:@"#6466F3"]];
        }
    }];
    
    [[self.cookingMachineView.playPauseBts rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
         NSInteger steering = self.device.curSteering;
         NSString *message = @"";
         if (self.cookingMachineView.playPauseIcon.state == normalState) {
             message = steering == 0 ? @"正常模式\n已开启" : @"反转模式\n已开启";
             [self.device.startWorkSetting execute:nil];
         } else {
             message = steering == 0 ? @"正常模式\n已暂停" : @"反转模式\n已暂停";
             [self.device.pauseWorkSetting execute:nil];
         }
         [self.cookingMachineView.playPauseBgView showHightLightMessage:message
                                                                bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
    }];
    
    self.cookingMachineView.stopBts.rac_command = self.device.stopSetting;
    [[self.cookingMachineView.stopBts rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         NSString *message = self.device.curSteering == 1 ? @"反转模式\n已停止" : @"正常模式\n已停止";
         [self.cookingMachineView.stopBgView showHightLightMessage:@"反转模式\n已停止" bgColor:[UIColor colorWithHexString:@"#ef5239"]];
    }];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindState];
    [self bindAction];
    self.cookingMachineView.delegate = self;
    [self.device.deviceState execute:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter setter
- (LFCookingMachineView *)cookingMachineView {
    if ([self.view isKindOfClass:[LFCookingMachineView class]]) {
        return (LFCookingMachineView *)(self.view);
    }
    return nil;
}
@end

@implementation TBCookingMachineViewController (LFCookingMachineViewDelegate)

- (void)didMoveGearIndex:(NSInteger)index {
    NSInteger gear = index;
    if (gear == 11) {
        gear = 0;
    } else {
        gear += 1;
    }
    [self.device.gearSetting execute:@(gear)];
}

- (void)didMoveTemperatureGearIndex:(NSInteger)index {
    [self.device.tempSetting execute:@(index)];
}

@end

@implementation TBCookingMachineViewController (LFCookingMachineTimeViewDelegate)

- (void)didSelected:(NSInteger)min second:(NSInteger)second {
    [self.device.timeSetting execute:@(min * 60 + second)];
}

@end
