//
//  TBHeaterViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBHeaterViewController.h"
#import "MTTCircularSlider.h"
#import "TBHeaterBrightnessView.h"
#import "TBHeaterTemperatureView.h"
@interface TBHeaterViewController () <TBHeaterBrightnessViewDelegate, TBHeaterTemperatureViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *currentTemperature;
@property (nonatomic, weak) IBOutlet UILabel *setTemperature;

@property (nonatomic, weak) IBOutlet TBHeaterBrightnessView *brightnessView;
@property (nonatomic, weak) IBOutlet TBHeaterTemperatureView *temperatureView;
@end

@interface TBHeaterViewController (UI_Config)

- (void)setup_ui;

@end

@interface TBHeaterViewController (TBHeaterBrightnessViewDelegate)

@end

@interface TBHeaterViewController (TBHeaterTemperatureViewDelegate)

@end

@implementation TBHeaterViewController


- (void)bindState {
    @weakify(self)
    //当前温度
    RAC(self.currentTemperature, text) =
    [RACObserve(self.device, currentTemperature) map:^id _Nullable(NSNumber *_Nullable currentTemperature) {
        return [currentTemperature stringValue];
    }];
    //设定温度
    RACSignal *setTempSignal = RACObserve(self.device, setTemperature);
    RAC(self.setTemperature, text) =
    [setTempSignal map:^id _Nullable(NSNumber *_Nullable setTemperature) {
        return [setTemperature stringValue];
    }];
    RAC(self.temperatureView, progress) =
    [setTempSignal map:^id _Nullable(NSNumber *_Nullable setTemperature) {
        return @(([setTemperature floatValue] - 25) / 50.f);
    }];
    //led亮度
    [self.brightnessView rac_liftSelector:@selector(setNodeIndex:animated:)
                    withSignalOfArguments:[RACObserve(self.device, ledBrightness)
                                           map:^id _Nullable(NSNumber *_Nullable ledBrightness) {
                                               return [RACTuple tupleWithObjects:@(9 - [ledBrightness integerValue] - 1), @YES, nil];
                                           }]
     ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    [self bindState];
    [self.device.deviceState execute:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
@implementation TBHeaterViewController (UI_Config)

- (void)setup_ui {
    self.brightnessView.delegate = self;
    self.temperatureView.delegate = self;
}

@end
#pragma mark - TBHeaterBrightnessViewDelegate
@implementation TBHeaterViewController (TBHeaterBrightnessViewDelegate)

- (void)heaterBrightnessView:(TBHeaterBrightnessView *)view didMoveToNodeIndex:(NSInteger)index {
    [self.device.brightnessSetting execute:@(9 - index - 1)];
}

@end
#pragma mark - TBHeaterTemperatureViewDelegate
@implementation TBHeaterViewController (TBHeaterTemperatureViewDelegate)
- (void)heaterTemperatureView:(TBHeaterTemperatureView *)view didChangeValue:(CGFloat)progress {
    NSInteger temperature = (NSInteger)(progress * 50) + 25;
    [self.device.temperatureSetting execute:@(temperature)];
}

@end
