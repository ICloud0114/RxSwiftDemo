//
//  TBHumidifierViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/19.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBHumidifierViewController.h"
#import "TBHumidifierHygrometerView.h"
#import "TBHumidifierTemperatureView.h"
#import "UIView+HighlightedMessage.h"
#import "UIColor+Ex.h"

@interface TBHumidifierViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *warningIcon;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@property (weak, nonatomic) IBOutlet TBHumidifierHygrometerView *humidifyView;;
@property (weak, nonatomic) IBOutlet TBHumidifierTemperatureView *temperatureView;

@property (nonatomic, weak) IBOutlet UIImageView *powerState;
@property (weak, nonatomic) IBOutlet UIButton *powerSetting;
@property (weak, nonatomic) IBOutlet UIImageView *gear; //雾量模式
@property (weak, nonatomic) IBOutlet UILabel *gearDes;

@property (weak, nonatomic) IBOutlet UIButton *humidityAdd;
@property (weak, nonatomic) IBOutlet UIView *addBgView;

@property (weak, nonatomic) IBOutlet UIButton *humidityReduce;
@property (weak, nonatomic) IBOutlet UIView *reduceBgView;

@property (weak, nonatomic) IBOutlet UIButton *gearSetting;
@property (weak, nonatomic) IBOutlet UIView *gearBgView;

@end


@implementation TBHumidifierViewController

- (void)dealloc {
    
}

- (void)bindState {
    @weakify(self)
    //开关状态
    RACChannelTo(self.powerSetting, selected) = RACChannelTo(self.device, powerStatus);
    RACChannelTo(self.powerState, highlighted) = RACChannelTo(self.device, powerStatus);
    [[RACObserve(self.device, powerStatus) takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        if ([x boolValue]) {
            [self.humidifyView continueWaving];
        } else {
            [self.humidifyView stopWaving];
        }
    }];

    //是否缺水
    RACSignal *lockWaterSignal = [[RACObserve(self.device, isLackWater) takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    RAC(self.warningIcon, hidden) = lockWaterSignal;
    RAC(self.warningLabel, hidden) = lockWaterSignal;
    //当前温度
    [[self.temperatureView rac_liftSelector:@selector(setTemperature:animated:)
                     withSignalOfArguments:[[RACObserve(self.device, currentTemperature) takeUntil:[self rac_willDeallocSignal]]
                                            map:^id _Nullable(NSNumber *_Nullable curTemp) {
                                                return [RACTuple tupleWithObjects:curTemp, @YES, nil];
                                            }]] takeUntil:[self rac_willDeallocSignal]];
    //设定湿度
    [[self.humidifyView rac_liftSelector:@selector(startWaveProgress:)
                  withSignalOfArguments:[[RACObserve(self.device, setHumidity) takeUntil:[self rac_willDeallocSignal]]
                                         map:^id _Nullable(NSNumber *_Nullable setHygrometer) {
                                             return [RACTuple tupleWithObjects:setHygrometer, nil];
                                         }]] takeUntil:[self rac_willDeallocSignal]];
    //雾量模式
    RAC(self.gear, highlighted) =
    [[[RACObserve(self.device, gear) takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(NSNumber *_Nullable gear) {
        return @([gear integerValue] == 2);
    }] doNext:^(NSNumber *_Nullable x) {
        @strongify(self)
        self.gearDes.text = [x boolValue] ? @"雾量高" : @"雾量低";
    }];
}

- (void)bindAction {
    @weakify(self)
    //开关机
    self.powerSetting.rac_command = self.device.power;
    RACChannelTo(self, hideOverlay) = RACChannelTo(self.device, powerStatus);
    //湿度减
    [[[self.humidityReduce rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
         [self.device.humiditySetting execute:@NO];
         [self.reduceBgView showHightLightMessage:@"湿度减" bgColor:[UIColor colorWithHexString:@"#fda215"]];
    }];
    //湿度加
    [[[self.humidityAdd rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.device.humiditySetting execute:@YES];
         [self.addBgView showHightLightMessage:@"湿度加" bgColor:[UIColor colorWithHexString:@"#01a4f5"]];
     }];
    //档位切换
    self.gearSetting.rac_command = self.device.gearSetting;
    [[[self.gearSetting rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         if (self.device.gear == 1) {
             [self.gearBgView showHightLightMessage:@"雾量高模式\n已开启" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
         } else {
             [self.gearBgView showHightLightMessage:@"雾量低模式\n已开启" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
         }
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindState];
    [self bindAction];
    [self.device.deviceState execute:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
