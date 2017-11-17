//
//  TBAirPurifierViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBAirPurifierViewController.h"
#import "UIView+HighlightedMessage.h"
#import "UIColor+Ex.h"

@interface TBAirPurifierViewController ()

@property (nonatomic, weak) IBOutlet UIView *timerBgView;
@property (nonatomic, weak) IBOutlet UIView *fanSpeedBgView;
@property (nonatomic, weak) IBOutlet UIView *swingBgView;
@property (nonatomic, weak) IBOutlet UIView *lightBelfBgView;

@property (nonatomic, weak) IBOutlet UIButton *timerSetting;
@property (nonatomic, weak) IBOutlet UIButton *powerSetting;
@property (nonatomic, weak) IBOutlet UIButton *fanSpeedSetting;
@property (nonatomic, weak) IBOutlet UIButton *swingSetting;
@property (nonatomic, weak) IBOutlet UIButton *lightBelfSetting;

@property (nonatomic, weak) IBOutlet UIImageView *powerState;
@property (nonatomic, weak) IBOutlet UIImageView *timerIcon;
@property (nonatomic, weak) IBOutlet UIImageView *timerGearIcon;
@property (nonatomic, weak) IBOutlet UIImageView *environment;
@property (nonatomic, weak) IBOutlet UIImageView *fanSpeed;
@property (nonatomic, weak) IBOutlet UIImageView *swingIcon;
@property (nonatomic, weak) IBOutlet UIImageView *lightBelfIcon;
@property (nonatomic, weak) IBOutlet UIImageView *lightBelfBrightnessIcon;

@property (nonatomic, weak) IBOutlet UILabel *filterTip;

@end

@implementation TBAirPurifierViewController

- (void)bindState {
    @weakify(self)
    //开关状态
    RACChannelTo(self.powerSetting, selected) = RACChannelTo(self.device, powerStatus);
    RACChannelTo(self.powerState, highlighted) = RACChannelTo(self.device, powerStatus);
    RACChannelTo(self, hideOverlay) = RACChannelTo(self.device, powerStatus);
    
    //环境状态
    RAC(self.environment, image) =
    [[RACObserve(self.device, environmentStatus) map:^id _Nullable(NSNumber *  _Nullable state) {
        if ([state integerValue] == 0x01) {
            return @"heater_best.png";
        } else if ([state integerValue] == 0x02) {
            return @"heater_good.png";
        } else if ([state integerValue] == 0x03) {
            return @"heater_bad.png";
        } else {
            return @"heater_best.png";
        }
    }] map:^id _Nullable(NSString *  _Nullable icon) {
        return [UIImage imageNamed:icon];
    }];
    
    //定时器
    RACSignal *timerSignal = RACObserve(self.device, timerMode);
    RAC(self.timerIcon, highlighted) =
    [timerSignal map:^id _Nullable(NSNumber *_Nullable value) {
        return @([value integerValue] > 0x00);
    }];
    RAC(self.timerGearIcon, hidden) =
    [timerSignal map:^id _Nullable(NSNumber *_Nullable value) {
        return @([value integerValue] == 0x00);
    }];
    RAC(self.timerGearIcon, image) =
    [timerSignal map:^id _Nullable(NSNumber *_Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"btn_time_%@h.png", value]];
    }];
    
    //风速
    RAC(self.fanSpeed, image) = 
    [RACObserve(self.device, fanSpeed) map:^id _Nullable(NSNumber *  _Nullable fanSpeed) {
        NSString *icon = [NSString stringWithFormat:@"btn_speed_%@X.png",
                          ([fanSpeed integerValue] >= 1 && [fanSpeed integerValue] <= 5) ? fanSpeed : @3];
        return [UIImage imageNamed:icon];
    }];
    
    //摆头
    RACChannelTo(self.swingIcon, highlighted) = RACChannelTo(self.device, swingMode);
    //滤网
    RACChannelTo(self.filterTip, text) = RACChannelTo(self.device, filteringTime);
    //灯带
    RACSignal *lightBelfSignal = RACObserve(self.device, lightBelfMode);
    RAC(self.lightBelfIcon, highlighted) =
    [lightBelfSignal map:^id _Nullable(NSNumber *  _Nullable lightBelfMode) {
        return @([lightBelfMode integerValue] > 0);
    }];
    RAC(self.lightBelfBrightnessIcon, hidden) =
    [lightBelfSignal map:^id _Nullable(NSNumber *  _Nullable lightBelfMode) {
        return @([lightBelfMode integerValue] == 0);
    }];
    RAC(self.lightBelfBrightnessIcon, highlighted) =
    [lightBelfSignal map:^id _Nullable(NSNumber *  _Nullable lightBelfMode) {
        return @([lightBelfMode integerValue] == 0x01);
    }];
}

- (void)bindAction {
    @weakify(self)
    //动作绑定
    //开关机
    self.powerSetting.rac_command = self.device.power;
    //定时器设定
    self.timerSetting.rac_command = self.device.timerSetting;
    [[self.timerSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.timerBgView showHightLightMessage:
          (self.device.timerMode == 0x0C ? @"定时关闭" : [NSString stringWithFormat: @"定时%@h", @(self.device.timerMode + 0x02)])
                                             bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
     }];
    //风速设定
    self.fanSpeedSetting.rac_command = self.device.fanSpeedSetting;
    [[self.fanSpeedSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.fanSpeedBgView showHightLightMessage:[NSString stringWithFormat:@"档位: %@X", @(x.tag)]
                                            bgColor:[UIColor colorWithHexString:@"#61c23e"]];
     }];
    //摆头
    self.swingSetting.rac_command = self.device.swingSetting;
    [[self.swingSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.swingBgView showHightLightMessage:
          [NSString stringWithFormat:@"摇头模式\n%@", (self.device.swingMode ? @"已关闭" : @"已开启")]
                                            bgColor:[UIColor colorWithHexString:@"#6666ff"]];
     }];
    //灯带
    self.lightBelfSetting.rac_command = self.device.lightBelfSetting;
    [[self.lightBelfSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         NSInteger lightBelfMode = self.device.lightBelfMode;
         [self.lightBelfBgView showHightLightMessage:
          (lightBelfMode == 0x0 ? @"灯带高亮" : (lightBelfMode == 0x01 ? @"灯带低亮" : @"灯带关闭"))
                                         bgColor:[UIColor colorWithHexString:@"#fda215"]];
     }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

@end
