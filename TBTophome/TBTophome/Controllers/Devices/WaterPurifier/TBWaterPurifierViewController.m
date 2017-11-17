//
//  TBWaterPurifierViewController.m
//  TBTophome
//
//  Created by Topband on 2017/2/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBWaterPurifierViewController.h"
#import "UIView+HighlightedMessage.h"
#import "UIView+Hud.h"
#import "UIColor+Ex.h"
#import "ICFilterElementView.h"

@interface TBWaterPurifierViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *power;

@property (weak, nonatomic) IBOutlet UIImageView *warningIcon;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@property (weak, nonatomic) IBOutlet UIButton *rinseSetting; //冲洗
@property (weak, nonatomic) IBOutlet UIView *rinseBgView;
@property (weak, nonatomic) IBOutlet UIImageView *rinseIcon;
@property (weak, nonatomic) IBOutlet UILabel *rinseLabel;

@property (weak, nonatomic) IBOutlet UIButton *filterSetting; //选芯
@property (weak, nonatomic) IBOutlet UIView *filterBgView;
@property (weak, nonatomic) IBOutlet UIImageView *filterIcon;

@property (weak, nonatomic) IBOutlet UIButton *resetSetting; //复位
@property (weak, nonatomic) IBOutlet UIView *resetBgView;
@property (weak, nonatomic) IBOutlet UIImageView *resetIcon;
@property (weak, nonatomic) IBOutlet UILabel *resetLabel;

@property (weak, nonatomic) IBOutlet UILabel *iTds;
@property (weak, nonatomic) IBOutlet UILabel *oTds;

@property (weak, nonatomic) IBOutlet ICFilterElementView *filter1View; //滤芯1
@property (weak, nonatomic) IBOutlet ICFilterElementView *filter2View; //滤芯2

@property (weak, nonatomic) IBOutlet UIView *leftView;
@end

@implementation TBWaterPurifierViewController

- (void)bindState {
    @weakify(self)
    RACChannelTo(self.power, highlighted) = RACChannelTo(self.device, power);
    //冲洗
    RACSignal *waterPurifierState = RACObserve(self.device, waterPurifierStatus);
    RAC(self.rinseIcon, highlighted) =
    [waterPurifierState map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        return @([state integerValue] == 1 && self.rinseSetting.enabled);
    }];
    RACSignal *isEnableSelectedFilterSignal = RACObserve(self.filterSetting, selected);
    RAC(self.rinseIcon, image) = [isEnableSelectedFilterSignal map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if ([value boolValue]) {
            self.rinseIcon.highlighted = NO;
            return [UIImage imageNamed:@"btn_wash_disable.png"];
        } else {
            return (self.device.waterPurifierStatus == 1) ? [UIImage imageNamed:@"btn_wash_select.png"] : [UIImage imageNamed:@"btn_wash_normal.png"];
        }
    }];
    RAC(self.rinseLabel, textColor) = [isEnableSelectedFilterSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.rinseSetting, enabled) = [isEnableSelectedFilterSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    
    //tds
    RAC(self.leftView.layer, opacity) = [isEnableSelectedFilterSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? @0.4 : @1;
    }];
    
    //⚠️⚠️
//    RACSignal *hideWarning = RAC(self.warningIcon, hidden) = [waterPurifierState map:^id _Nullable(NSNumber *_Nullable state) {
//        return @([state integerValue] == 2);
//    }];
//    RAC(self.warningIcon, hidden) = hideWarning;
//    RAC(self.warningLabel, hidden) = hideWarning;
    RAC(self.warningIcon, image) = [waterPurifierState map:^id _Nullable(NSNumber *_Nullable state) {
        if ([state integerValue] == 0) {
            return UIImage.waterPurifierMadeImage;
        } else if ([state integerValue] == 1) {
            return UIImage.waterPurifierWashImage;
        }
        return nil;
    }];
    RAC(self.warningLabel, text) = [waterPurifierState map:^id _Nullable(NSNumber *_Nullable state) {
        if ([state integerValue] == 0) {
            return @"制水中...";
        } else if ([state integerValue] == 1) {
            return @"冲洗中...";
        }
        return nil;
    }];
    
    //自来水
    RAC(self.iTds, text) = [RACObserve(self.device, iTds) map:^id _Nullable(NSNumber *  _Nullable itds) {
        return [NSString stringWithFormat:@"%03d", [itds intValue]];
    }];
    //饮用水
    RAC(self.oTds, text) = [RACObserve(self.device, oTds) map:^id _Nullable(NSNumber *  _Nullable itds) {
        return [NSString stringWithFormat:@"%03d", [itds intValue]];
    }];
    //选芯
    RACChannelTo(self.filterIcon, highlighted) = RACChannelTo(self.filterSetting, selected);
    RACChannelTo(self.filter1View.selectButton, userInteractionEnabled) = RACChannelTo(self.filterSetting, selected);
    RACChannelTo(self.filter2View.selectButton, userInteractionEnabled) = RACChannelTo(self.filterSetting, selected);
    RAC(self.filter1View.selectButton, selected) = [RACObserve(self.filterSetting, selected)
                                                    filter:^BOOL(NSNumber  *_Nullable value) {
                                                        return ([value boolValue] == NO);
                                                    }];
    RAC(self.filter2View.selectButton, selected) = [RACObserve(self.filterSetting, selected)
                                                    filter:^BOOL(NSNumber  *_Nullable value) {
                                                        return ([value boolValue] == NO);
                                                    }];

    [self.filter1View rac_liftSelector:@selector(changeFilterImageState:)
                 withSignalOfArguments:[[self.filter1View.selectButton rac_signalForControlEvents:UIControlEventTouchUpInside]
                                        map:^id _Nullable(__kindof UIButton * _Nullable x) {
                                            x.selected = !x.selected;
                                            return [RACTuple tupleWithObjects:@(x.selected), nil];
                                        }]];
    [self.filter1View rac_liftSelector:@selector(changeFilterImageState:)
                 withSignalOfArguments:[RACObserve(self.filterSetting, selected)
                                          map:^id _Nullable(NSNumber * _Nullable value) {
                                             return [RACTuple tupleWithObjects:@(![value boolValue]), nil];
                                         }]];
    [self.filter2View rac_liftSelector:@selector(changeFilterImageState:)
                 withSignalOfArguments:[[self.filter2View.selectButton rac_signalForControlEvents:UIControlEventTouchUpInside]
                                        map:^id _Nullable(__kindof UIButton * _Nullable x) {
                                            x.selected = !x.selected;
                                            return [RACTuple tupleWithObjects:@(x.selected), nil];
                                        }]];
    [self.filter2View rac_liftSelector:@selector(changeFilterImageState:)
                 withSignalOfArguments:[RACObserve(self.filterSetting, selected)
                                        map:^id _Nullable(NSNumber * _Nullable value) {
                                            return [RACTuple tupleWithObjects:@(![value boolValue]), nil];
                                         }]];
    //关联芯片状态
    [self.filter1View rac_liftSelector:@selector(showFilterDamagePercent:)
                 withSignalOfArguments:[RACObserve(self.device, filterC2Status)
                                        map:^id _Nullable(NSNumber * _Nullable value) {
                                            return [RACTuple tupleWithObjects:@([value floatValue] / 10.f * 100.f), nil];
                                        }]];
    [self.filter2View rac_liftSelector:@selector(showFilterDamagePercent:)
                 withSignalOfArguments:[RACObserve(self.device, filterRoStatus)
                                        map:^id _Nullable(NSNumber * _Nullable value) {
                                            return [RACTuple tupleWithObjects:@([value floatValue] / 10.f * 100.f), nil];
                                        }]];
    
    //复位
    RACSignal *isSelectedFilterSignal =
    [RACSignal combineLatest:@[RACObserve(self.filter1View.selectButton, selected),
                               RACObserve(self.filter2View.selectButton, selected)]
                      reduce:^id _Nullable(NSNumber *filter1, NSNumber *filter2){
                          return @([filter1 boolValue] || [filter2 boolValue]);
                      }];
    RAC(self.resetIcon, image) = [isSelectedFilterSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIImage imageNamed:@"btn_reset_normal.png"] : [UIImage imageNamed:@"btn_reset_disable.png"];
    }];
    RAC(self.resetLabel, textColor) = [isSelectedFilterSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value boolValue] ? [UIColor colorWithHexString:@"#282828"] : [UIColor colorWithHexString:@"#d4d4d4"];
    }];
    RAC(self.resetSetting, enabled) = isSelectedFilterSignal;
}

- (void)bindAction {
    @weakify(self)
    //冲洗
    self.rinseSetting.rac_command = self.device.rinseSetting;
    [[self.rinseSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
         if (self.device.waterPurifierStatus == 1) { //冲洗中
             [self.rinseBgView showHightLightMessage:@"冲洗模式\n已关闭"
                                             bgColor:[UIColor colorWithHexString:@"#ef5239"]];
         } else {
             [self.rinseBgView showHightLightMessage:@"冲洗模式\n已开启"
                                             bgColor:[UIColor colorWithHexString:@"#ef5239"]];
         }
    }];
    
    //选芯
    [[self.filterSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIButton * _Nullable x) {
         @strongify(self)
         x.selected = !x.selected;
         if (x.selected) {
             [self.filterBgView showHightLightMessage:@"选芯模式\n已开启" bgColor:[UIColor colorWithHexString:@"#fda215"]];
             [self.filter1View changeFilterImageState:YES];
             self.filter1View.selectButton.selected = YES;
         } else {
             [self.filterBgView showHightLightMessage:@"选芯模式\n已关闭" bgColor:[UIColor colorWithHexString:@"#fda215"]];
         }
    }];
    
    //复位
    [[self.resetSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIButton * _Nullable x) {
         @strongify(self)
         if (!self.filter1View.selectButton.selected && !self.filter2View.selectButton.selected) {
             [self.view showMessage:@"请选择要复位的芯片"];
             return;
         }
         [self.resetBgView showHightLightMessage:@"复位模式\n已开启" bgColor:[UIColor colorWithHexString:@"#01a4f5"]];
         if (self.filter1View.selectButton.selected && self.filter2View.selectButton.selected) { //复位所有芯片
             [self.device.resetFilterSetting execute:@0];
         } else if (self.filter1View.selectButton.selected) {
             [self.device.resetFilterSetting execute:@1];
         } else {
             [self.device.resetFilterSetting execute:@2];
         }
         self.filterSetting.selected = NO;
     }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

