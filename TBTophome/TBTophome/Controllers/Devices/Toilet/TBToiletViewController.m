//
//  TBToiletViewController.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBToiletViewController.h"
#import "ICToiletControlView.h"
#import "ICNormalCleanView.h"
#import "ICDryView.h"
#import "ICToiletShowView.h"
#import "ICToiletBottomView.h"
#import "UIView+Ex.h"
typedef NS_ENUM(NSInteger, ICOperateType)
{
    kOperateTypeNormal = 0,
    kOperateTypeFemale,
    kOperateTypeDry,
    kOperateTypeDefault
};
@interface TBToiletViewController ()

@property (weak, nonatomic) IBOutlet  ICToiletBottomView *bottomView;
@property (weak, nonatomic) IBOutlet ICToiletControlView *controlView;
@property (weak, nonatomic) IBOutlet ICToiletShowView *showView;
@property (nonatomic, assign) ICOperateType adjustType;

@property (weak, nonatomic) IBOutlet UIButton *buttocksBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleCleanBtn;
@property (weak, nonatomic) IBOutlet UIButton *dryBtn;
@property (weak, nonatomic) IBOutlet UIButton *flushBtn;
@property (weak, nonatomic) IBOutlet UIButton *childBtn;
@property (weak, nonatomic) IBOutlet UIButton *maleAutoBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleAutoBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@property (weak, nonatomic) IBOutlet UIButton *slideButton;
@end

@implementation TBToiletViewController
- (void)dealloc{
    TBLog(@"销毁了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindState];
    [self bindAction];
    [self.device.deviceState execute:nil];
//    [self.showView showProgressView];
}

- (void)bindState{
     @weakify(self)
    //选择模式
    RACSignal *operationMode = RACObserve(self.device, machStatus);
    RAC(self.buttocksBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 1);
    }];
    RAC(self.femaleCleanBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 2);
    }];
    RAC(self.dryBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 3);
    }];
    RAC(self.childBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 4);
    }];
    RAC(self.maleAutoBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 5);
    }];
    RAC(self.femaleAutoBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 6);
    }];
    RAC(self.flushBtn, selected) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 7);
    }];
    
    RAC(self.stopBtn, enabled) =
    [operationMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
//////////////////////////////////////////////////////////////////
    RAC(self.buttocksBtn, enabled) =
    [RACObserve(self.device, peopleStatus) map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
    RAC(self.femaleCleanBtn, enabled) =
    [RACObserve(self.device, peopleStatus) map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
    RAC(self.dryBtn, enabled) =
    [RACObserve(self.device, peopleStatus) map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
    RAC(self.childBtn, enabled) =
    [RACObserve(self.device, peopleStatus) map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
    RAC(self.femaleAutoBtn, enabled) =
    [RACObserve(self.device, peopleStatus) map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
    RAC(self.maleAutoBtn, enabled) =
    [RACObserve(self.device, peopleStatus) map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue]);
    }];
    
    //调节
    
    RAC(self.showView.temperatureLabel, text) = [RACObserve(self.device, s_temperature) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if (self.device.machStatus == 1 || self.device.machStatus == 2 || self.device.machStatus == 4) {
            if ([value integerValue]) {
                NSArray *temperature = @[@"0˚C",@"32˚C",@"34˚C",@"36˚C",@"38˚C",@"40˚C",@"冷热SPA",@"41˚C"];
                return temperature[[value integerValue] -1];
            }
            return @"";
        }else if(self.device.machStatus == 3)
        {
            NSArray *temperature = @[@"常温",@"低",@"中",@"高"];
            return temperature[self.device.s_dryLevel];
        }else if(self.device.machStatus == 5 || self.device.machStatus == 6){
            return @"1 min";
        }else{
            return @"";
        }
    }];
    
    RAC(self.showView.pressureLabel, text) = [RACObserve(self.device, s_pressure) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if (self.device.machStatus == 1 || self.device.machStatus == 2 || self.device.machStatus == 4) {
            if ([value integerValue]) {
                NSArray *temperature = @[@"1 档",@"2 档",@"3 档",@"4 档",@"5 档",@"按摩洗净"];
                return temperature[[value integerValue] -1];
            }
            return @"";
        }else if(self.device.machStatus == 3)
        {
//            return [NSString stringWithFormat:@"%ld min",self.device.s_dryTime  / 60];
            return @"4 min";
        }else if(self.device.machStatus == 5 || self.device.machStatus == 6){
            return @"4 min";
        }else{
            return @"";
        }
    }];
//
    RAC(self.showView.positionLabel, text) = [RACObserve(self.device, s_position) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if (self.device.machStatus == 1 || self.device.machStatus == 2 || self.device.machStatus == 4) {
            if ([value integerValue]) {
                NSArray *temperature = @[@"1 档",@"2 档",@"3 档",@"4 档",@"5 档",@"移动清洗"];
                return temperature[[value integerValue] -1];
            }
            return @"";
        }else{
            return @"";
        }
    }];
//
    RAC(self.showView.timeLabel, text) = [RACObserve(self.device, s_time) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if (self.device.machStatus == 1 || self.device.machStatus == 2 ||self.device.machStatus == 4) {
            if ([value integerValue]) {
                NSArray *temperature = @[@"1 min",@"2 min",@"3 min",@" 4 min"];
                return temperature[[value integerValue] / 60 - 1];
            }
            else{
                return @"";
            }
            
        }else{
            return @"";
        }
    }];
    
    RAC(self.slideButton, enabled) = [RACObserve(self.device, machStatus)map:^id _Nullable(NSNumber* _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1 || [value integerValue] == 2 || [value integerValue] == 3) {
            self.bottomView.line1.layer.opacity = 0.3;
            self.bottomView.line2.layer.opacity = 0.3;
            return @YES;
        }else{
            self.bottomView.line1.layer.opacity = 0.1f;
            self.bottomView.line2.layer.opacity = 0.1f;
            return @NO;
        }
    }];
    
    [self.showView rac_liftSelector:@selector(showOperationView:)
                  withSignalOfArguments:[RACObserve(self.device, machStatus)
                                         map:^id _Nullable(NSNumber *_Nullable status) {
                                             return [RACTuple tupleWithObjects:status, nil];
                                         }]];
    
    [self.showView rac_liftSelector:@selector(showProgress:)
              withSignalOfArguments:[RACObserve(self.device, remainTime)
                                     map:^id _Nullable(NSNumber *_Nullable status) {
                                         @strongify(self)
                                         CGFloat progress = 0.f;
                                         switch (self.device.machStatus) {
                                             case 1:
                                             case 2:{
                                                 progress = 1 - (self.device.remainTime * 1.0f / self.device.s_time);
                                             }
                                                 break;
                                             case 3:{
                                                 progress = 1 - (self.device.remainTime * 1.0f / self.device.s_dryTime);
                                             
                                             }break;
                                             case 4:
                                             case 5:
                                             case 6:{
                                                 progress = 1 - (self.device.remainTime * 1.0f / (self.device.s_time + self.device.s_dryTime));
                                             }break;
                                                 
                                             default:
                                                 break;
                                         }
                                         
                                         return [RACTuple tupleWithObjects:@(progress), nil];
                                     }]];
    
    

}
- (void)bindAction{
     @weakify(self)
    self.buttocksBtn.rac_command = self.device.operationMode;
    self.femaleCleanBtn.rac_command = self.device.operationMode;
    self.dryBtn.rac_command = self.device.operationMode;
    self.childBtn.rac_command = self.device.operationMode;
    self.maleAutoBtn.rac_command = self.device.operationMode;
    self.femaleAutoBtn.rac_command = self.device.operationMode;
    self.flushBtn.rac_command = self.device.operationMode;
    self.stopBtn.rac_command = self.device.operationMode;
    
    [[self.flushBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.flushBtn startRepeatRotate];
         [self.flushBtn performSelector:@selector(endRepeatRotate) withObject:nil afterDelay:2];
     }];

    
   
    [[self.slideButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         self.bottomView.layer.opacity = 0;
         if (self.device.machStatus == 1) { //冲洗中
             ICNormalCleanView *cleanView = [ICNormalCleanView shareNormalCleanView];
             [cleanView showInView:self.view];
             [cleanView showProgressWithTemperature:self.device.s_temperature - 1 pressure:self.device.s_pressure - 1 position:self.device.s_position - 1 andTime:self.device.s_time / 60 - 1];
             cleanView.dismissComplete = ^()
             {
                 self.bottomView.layer.opacity = 1;
             };
             
             cleanView.changeTemperature = ^(NSInteger index)
             {
                 self.device.c_temperature = index + 1;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };
             
             cleanView.changeSPA = ^(NSInteger temperature, NSInteger presure){
                 
                 self.device.c_temperature = temperature;
                 self.device.c_pressure = presure;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };

             cleanView.changePressure = ^(NSInteger index)
             {
                 self.device.c_pressure = index + 1;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };
             cleanView.changePosition = ^(NSInteger index)
             {
                 self.device.c_position = index + 1;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };
             cleanView.changeTime = ^(NSInteger index)
             {
                 self.device.c_time = (index + 1) * 60;
                 self.device.timeEnable = 1;
                 [self.device.stateChange execute:nil];
             };
            
         } else if(self.device.machStatus == 2){
             ICNormalCleanView *cleanView = [ICNormalCleanView shareFemaleCleanView];
             [cleanView showInView:self.view];
             [cleanView showProgressWithTemperature:self.device.s_temperature - 1 pressure:self.device.s_pressure -1 position:self.device.s_position - 1 andTime:self.device.s_time / 60 - 1];
             cleanView.dismissComplete = ^()
             {
                 self.bottomView.layer.opacity = 1;
             };
             
             cleanView.dismissComplete = ^()
             {
                 self.bottomView.layer.opacity = 1;
             };
             
             cleanView.changeTemperature = ^(NSInteger index)
             {
                 self.device.c_temperature = index + 1;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
                 
             };
             
             cleanView.changePressure = ^(NSInteger index)
             {
                 self.device.c_pressure = index + 1;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };
             cleanView.changePosition = ^(NSInteger index)
             {
                 self.device.c_position = index + 1;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };
             cleanView.changeTime = ^(NSInteger index)
             {
                 self.device.c_time = (index + 1) * 60 ;
                 self.device.timeEnable = 1;
                 [self.device.stateChange execute:nil];
             };
             
         }else if(self.device.machStatus == 3){
             ICDryView *dryView = [ICDryView shareDryView];
             [dryView showInView:self.view];
             [dryView showProgressWithLevel:self.device.s_dryLevel];
             dryView.dismissComplete = ^()
             {
                 self.bottomView.layer.opacity = 1;
             };
             dryView.changeLevel = ^(NSInteger level)
             {
                 self.device.c_dryLevel = level;
                 self.device.timeEnable = 0;
                 [self.device.stateChange execute:nil];
             };
         }
     }];
    
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
