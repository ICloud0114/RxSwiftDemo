//
//  TBCoffeeViewController.m
//  TBTophome
//
//  Created by Topband on 2017/2/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBCoffeeViewController.h"
#import "LFWaterTemperatureView.h"
#import "LFCoffeeWorkingView.h"
#import "TBIconImageView.h"
#import "UIColor+Ex.h"
#import "UIView+HighlightedMessage.h"

@interface TBCoffeeViewController () <LFWaterTemperatureViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startWorkBt;
@property (weak, nonatomic) IBOutlet TBIconImageView *startWorkIcon;
@property (weak, nonatomic) IBOutlet UILabel *startWorkLabel;
@property (weak, nonatomic) IBOutlet UIView *startWorkBgView;

@property (weak, nonatomic) IBOutlet UIButton *stopWorkBt;
@property (weak, nonatomic) IBOutlet TBIconImageView *stopWorkIcon;
@property (weak, nonatomic) IBOutlet UILabel *stopWorkLabel;
@property (weak, nonatomic) IBOutlet UIView *stopWorkBgView;

@property (weak, nonatomic) IBOutlet UIButton *wakeupBt;
@property (weak, nonatomic) IBOutlet TBIconImageView *wakeupIcon;
@property (weak, nonatomic) IBOutlet UILabel *wakeupLabel;
@property (weak, nonatomic) IBOutlet UIView *wakeupBgView;

@property (weak, nonatomic) IBOutlet UILabel *cupCount; //杯数
@property (weak, nonatomic) IBOutlet UIButton *currentCup; //记录当前杯

@property (weak, nonatomic) IBOutlet UIImageView *infoIcon;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) LFCoffeeWorkingView *workingView;
@property (weak, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet LFWaterTemperatureView *waterTemperatureView;
@end

@interface TBCoffeeViewController (LFWaterTemperatureViewDelegate)

@end

@implementation TBCoffeeViewController

- (void)bindState {
    @weakify(self)
    //监听拉柄状态
    RACSignal *handleStatusSignal = [RACObserve(self.device, curHandleStatus) takeUntil:[self rac_willDeallocSignal]];
    //煲咖啡状态
    RACSignal *coffeeStatusSignal = [RACObserve(self.device, curCoffeeStatus) takeUntil:[self rac_willDeallocSignal]];
    //系统状态
    RACSignal *systemStatusSignal = [RACObserve(self.device, curSystemStatus) takeUntil:[self rac_willDeallocSignal]];
    //温度状态
    RACSignal *temperatureSignal = [RACObserve(self.device, curTemp) takeUntil:[self rac_willDeallocSignal]];
    //杯数状态
    RACSignal *cupsSignal = [RACObserve(self.device, curCoffeeCups) takeUntil:[self rac_willDeallocSignal]];
    
    //overlay
    RACSignal *overlayStatusSignal = [RACSignal combineLatest:@[handleStatusSignal, systemStatusSignal]
                                                      reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
                                                          NSInteger handleStatus = [value1 integerValue];
                                                          NSInteger systemStatus = [value2 integerValue];
                                                          if (handleStatus == 1) {
                                                              return @NO;
                                                          }
                                                          if (systemStatus == 1 ||
                                                              systemStatus == 2 ||
                                                              systemStatus == 4 ||
                                                              systemStatus == 5) {
                                                              return @NO;
                                                          }
                                                          return @YES;
                                                      }];
    RAC(self, hideOverlay) = overlayStatusSignal;
    //杯数
    RAC(self.cupCount, text) = [cupsSignal map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%@杯", value];
    }];
    //开始
    RACSignal *startWorkSignal = [RACSignal combineLatest:@[handleStatusSignal, coffeeStatusSignal, systemStatusSignal]
                                                   reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3){
                                                       NSInteger handleStatus = [value1 integerValue];
                                                       NSInteger coffeeStatus = [value2 integerValue];
                                                       NSInteger systemStatus = [value3 integerValue];
                                                       if (handleStatus == 1) {
                                                           return @2;
                                                       }
                                                       if (systemStatus == 1 ||
                                                           systemStatus == 2 ||
                                                           systemStatus == 4 ||
                                                           systemStatus == 5) {
                                                           return @2;
                                                       }
                                                       if (coffeeStatus == 1) {
                                                           return @2;
                                                       }
                                                       return @0;
                                                   }];
    RAC(self.startWorkIcon, state) = startWorkSignal;
    RAC(self.startWorkLabel, textColor) = [startWorkSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.startWorkBt, enabled) = [startWorkSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    //停止
    RACSignal *stopWorkSignal = [RACSignal combineLatest:@[handleStatusSignal, coffeeStatusSignal, systemStatusSignal]
                                                  reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3){
                                                      NSInteger handleStatus = [value1 integerValue];
                                                      NSInteger coffeeStatus = [value2 integerValue];
                                                      NSInteger systemStatus = [value3 integerValue];
                                                      if (handleStatus == 1) { return @2; }
                                                      if (systemStatus == 1 ||
                                                          systemStatus == 2 ||
                                                          systemStatus == 4 ||
                                                          systemStatus == 5) {
                                                          return @2;
                                                      }
                                                      if (coffeeStatus == 0) {
                                                          return @2;
                                                      }
                                                      return @0;
                                                  }];
    RAC(self.stopWorkIcon, state) = stopWorkSignal;
    RAC(self.stopWorkLabel, textColor) = [stopWorkSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.stopWorkBt, enabled) = [stopWorkSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    
    //唤醒
    RACSignal *wakeupSignal = [systemStatusSignal map:^id _Nullable(id  _Nullable value) {
        if ([value integerValue] == 4) {
            return @0;
        }
        return @2;
    }];
    RAC(self.wakeupIcon, state) = wakeupSignal;
    RAC(self.wakeupLabel, textColor) = [wakeupSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return ([value integerValue] == 2) ? [UIColor colorWithHexString:@"#d4d4d4"] : [UIColor colorWithHexString:@"#282828"];
    }];
    RAC(self.wakeupBt, enabled) = [wakeupSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @([value integerValue] != 2);
    }];
    
    //水温
    RAC(self.waterTemperatureView, gear) = temperatureSignal;
    //设备状态
    RAC(self.infoIcon, image) = [[RACSignal combineLatest:@[handleStatusSignal, systemStatusSignal]
                                                  reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
                                                      NSInteger handle = [value1 integerValue];
                                                      NSInteger system = [value2 integerValue];
                                                      if (handle == 1) { return @"info_rod.png"; }
                                                      if (system == 1) { return @"info_lack.png"; }
                                                      if (system == 2) { return @"info_temperature.png"; }
                                                      if (system == 3) { return @"info_warm.png"; }
                                                      if (system == 4) { return @"info_wait.png"; }
                                                      if (system == 5) { return @"info_information.png"; }
                                                      return nil;
                                                  }] map:^id _Nullable(id  _Nullable value) {
                                                      return [UIImage imageNamed:value];
                                                  }];
    RAC(self.infoLabel, text) = [RACSignal combineLatest:@[handleStatusSignal, systemStatusSignal]
                                                  reduce:^id _Nullable(NSNumber *value1, NSNumber *value2){
                                                      NSInteger handle = [value1 integerValue];
                                                      NSInteger system = [value2 integerValue];
                                                      if (handle == 1) { return @"拉杆拉起"; }
                                                      if (system == 1) { return @"缺水"; }
                                                      if (system == 2) { return @"预热中..."; }
                                                      if (system == 3) { return @"保温中..."; }
                                                      if (system == 4) { return @"待机中..."; }
                                                      if (system == 5) { return @"NTC 故障状态"; }
                                                      return nil;
                                                  }];
    //启动状态
    [coffeeStatusSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if ([x integerValue] == 1 && self.workingView == nil) {
            LFCoffeeWorkingView *workingView = [LFCoffeeWorkingView coffeeWorkingView];
            workingView.waterAmountLabel.text = [self waterAmountDes];
            workingView.temperatureLabel.text = [self temperatureDes];
            [workingView workInView:self.panelView];
            self.workingView = workingView;
        } else {
            [self.workingView stop];
        }
    }];
}

- (void)bindAction {
    @weakify(self)
    //开始
    [[self.startWorkBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.device.startWorkSetting execute:@(self.currentCup.tag)];
         [self.startWorkBgView showHightLightMessage:@"咖啡机\n已开始" bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
    }];
    
    //停止
    self.stopWorkBt.rac_command = self.device.stopWorkSetting;
    [[self.stopWorkBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
        [self.stopWorkBgView showHightLightMessage:@"咖啡机\n已停止" bgColor:[UIColor colorWithHexString:@"#ef5239"]];
    }];
    
    //唤醒
    self.wakeupBt.rac_command = self.device.wakeupSetting;
    [[self.wakeupBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.wakeupBgView showHightLightMessage:@"咖啡机\n已唤醒" bgColor:[UIColor colorWithHexString:@"#fda215"]];
    }];
}

- (IBAction)selectCup:(UIButton *)sender {
    if (sender.selected) { return; }
    self.currentCup.selected = NO;
    sender.selected = YES;
    self.currentCup = sender;
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
- (NSString *)waterAmountDes {
    return (self.currentCup.tag == 1 ? @"大杯" : @"小杯");
}

- (NSString *)temperatureDes {
    NSString *des = nil;
    switch (self.waterTemperatureView.gear) {
        case 1:
            des = @"高温";
            break;
        case 2:
            des = @"中温";
            break;
        case 3:
            des = @"低温";
            break;
        default:
            break;
    }
    return des;
}

@end

@implementation TBCoffeeViewController (LFWaterTemperatureViewDelegate)

- (void)didChangeTemperatureGear:(NSInteger)tGear {
    [self.device.temperatureSetting execute:@(tGear)];
}

@end
