//
//  TBLEDLightViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBLEDLightViewController.h"
#import "TBLEDLightColorView.h"

@interface TBLEDLightViewController ()<TBLEDLightColorViewDelegate>
@property (nonatomic, weak) IBOutlet TBLEDLightColorView *colorView;
@property (nonatomic, weak) IBOutlet UISlider *brightnessSlider;
@property (nonatomic, weak) IBOutlet UIButton *powerSetting;

@property (weak, nonatomic) IBOutlet UIButton *preBt;

@end

@interface TBLEDLightViewController (UI_Config)
- (void)setup_ui;
@end

@interface TBLEDLightViewController (TBLEDLightColorViewDelegate)

@end

@implementation TBLEDLightViewController

- (void)adjustLightColor {
    UIColor *color = self.colorView.currentColor;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
//    green = 0;
//    blue = 0;
    RACTuple *tuple = [RACTuple tupleWithObjects:@(red), @(green), @(blue), @(self.brightnessSlider.value), nil];
    [self.device.colorSetting execute:tuple];
}

- (IBAction)brightnessAction:(UISlider *)slider {
    [self adjustLightColor];
}

- (void)bindState {
    //开关状态
    RACChannelTo(self.powerSetting, selected) = RACChannelTo(self.device, powerStatus);
//    RACChannelTo(self.powerState, highlighted) = RACChannelTo(self.device, powerStatus);
    RACChannelTo(self, hideOverlay) = RACChannelTo(self.device, powerStatus);
    RAC(self.brightnessSlider, value) =
    [RACObserve(self.device, white) map:^id _Nullable(NSNumber *_Nullable white) {
        return @([white unsignedShortValue] / 1023.f);
    }];
}

- (void)bindAction {
    @weakify(self)
    self.powerSetting.rac_command = self.device.power;
}

- (IBAction)modeChangeAction:(UIButton *)sender {
    if (sender.selected) { return; }
    sender.selected = YES;
    self.preBt.selected = NO;
    self.preBt = sender;
    self.colorView.mode = sender.tag - 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    [self bindState];
    [self bindAction];
    [self.device.deviceState execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overwrite
- (BOOL)isInteractivePop {
    return NO;
}
@end
#pragma mark - UI_Config
@implementation TBLEDLightViewController (UI_Config)
- (void)setup_ui {
    self.colorView.delegate = self;
}
@end
#pragma mark - TBLEDLightColorViewDelegate
@implementation TBLEDLightViewController (TBLEDLightColorViewDelegate)
- (void)ledLightColorView:(TBLEDLightColorView *)view didChangeColor:(UIColor *)color {
    [self adjustLightColor];
}
@end
