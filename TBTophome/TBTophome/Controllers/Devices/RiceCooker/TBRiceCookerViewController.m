//
//  TBRiceCookerViewController.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBRiceCookerViewController.h"
#import "ICRiceModeSelectView.h"
#import "ICRiceControlView.h"
#import "ICRiceTimeProgresssView.h"

#import "UIView+HighlightedMessage.h"
#import "UIColor+Ex.h"


@interface TBRiceCookerViewController (){
    NSInteger counter;
}

@property (weak, nonatomic) IBOutlet ICRiceModeSelectView *modeSelectView;
@property (weak, nonatomic) IBOutlet ICRiceControlView *controlView;
@property (weak, nonatomic) IBOutlet ICRiceTimeProgresssView *timeProgressView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeReduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeIncreBtn;

@property (weak, nonatomic) IBOutlet UIImageView *tipIcon;
@property (weak, nonatomic) IBOutlet UILabel *tipTitle;


@property (weak, nonatomic) IBOutlet UIButton *gruelBtn;//煮粥
@property (weak, nonatomic) IBOutlet UIButton *porridgeBtn;//稀饭
@property (weak, nonatomic) IBOutlet UIButton *firewoodBtn;//柴火饭
@property (weak, nonatomic) IBOutlet UIButton *smallBtn;//少量煮
@property (weak, nonatomic) IBOutlet UIButton *soupBtn;//汤
@property (weak, nonatomic) IBOutlet UIButton *steamBtn;//蒸煮
@property (weak, nonatomic) IBOutlet UIButton *cakeBtn;//蛋糕

@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *warmBtn;
@property (weak, nonatomic) IBOutlet UIButton *reservationBtn;
@property (weak, nonatomic) IBOutlet UIButton *timingBtn;

@property (weak, nonatomic) IBOutlet UIButton *startIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *warmIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *reservationIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *timingIconBtn;

@property (weak, nonatomic) IBOutlet UIButton *startLabelBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopLabelBtn;
@property (weak, nonatomic) IBOutlet UIButton *warmLabelBtn;
@property (weak, nonatomic) IBOutlet UIButton *reservationLabelBtn;
@property (weak, nonatomic) IBOutlet UIButton *timingLabelBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showViewConstraint;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TBRiceCookerViewController

- (void)dealloc{
    
    [self.timer invalidate];
    self.timer = nil;
    TBLog(@"销毁了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindState];
    [self bindAction];
    [self.device.deviceState execute:nil];
}
- (void)bindState {
    @weakify(self)
    
    RACSignal *showTime = RACObserve(self.device, showTime);
    
    RACSignal *cookerWorkStatus = RACObserve(self.device, workStatus);
    
    RACSignal *cookerWorkMode = RACObserve(self.device, workMode);
    
    RAC(self.timeLabel,text) = [showTime map:^id _Nullable(NSNumber *_Nullable time) {
        @strongify(self)
        if (![time integerValue]) {
            
            if (self.device.workStatus == 1 || self.device.workStatus == 4) {
                [self startTimeAnimation];
            }else{
                [self.timer invalidate];
            }
            return @"--:--";
        }
        return [NSString stringWithFormat:@"%02ld:%02ld",[time integerValue] / 60, [time integerValue] % 60];
    }];
    
    //时间调节
    

    RAC(self.timeReduceBtn, enabled) = [RACObserve(self.device, timeSetting) map:^id _Nullable(NSNumber *  _Nullable state) {
        return @([state integerValue]);
    }];
    RAC(self.timeIncreBtn, enabled) = [RACObserve(self.device, timeSetting) map:^id _Nullable(NSNumber *  _Nullable state) {
        return @([state integerValue]);
    }];
    
    //提示
    
    RAC(self.tipIcon, image) =
    [[RACObserve(self.device, timeSetting) map:^id _Nullable(NSNumber *  _Nullable state) {
        @strongify(self)
        if (self.device.workStatus == 4) {

            self.tipTitle.text = @"预约中...";
            return  @"info_wait";
            
        }else{
            if ([state integerValue] == 2 ) {
                self.tipTitle.text = @"定时中...";
                return @"info_timing.png";
            }else if([state integerValue] == 1){
                self.tipTitle.text = @"预约中...";
                return @"info_wait.png";
            }else{
                self.tipTitle.text = @"";
                return @"";
            }
        }

        
    }] map:^id _Nullable(NSString *  _Nullable icon) {
        return [UIImage imageNamed:icon];
    }];
   
    RAC(self.tipTitle,text) = [cookerWorkStatus map:^id _Nullable(NSNumber *_Nullable status) {
        @strongify(self)
        if ([status integerValue] == 4) {
            self.tipIcon.image = [UIImage imageNamed:@"info_wait"];
            return  @"预约中...";
            
        }else{
            self.tipIcon.image = [UIImage imageNamed:@""];
            return @"";
        }
        
    }];
    
    //判断是否已经运行
    [self rac_liftSelector:@selector(deviceRunning: workMode:time:)
                  withSignalOfArguments:[RACObserve(self.device, workStatus)
                                         map:^id _Nullable(NSNumber *_Nullable status) {
                                             @strongify(self)
                                             if ([status integerValue] == 1 ) {
                                                return [RACTuple tupleWithObjects:@YES,@(self.device.workMode),@(self.device.workTime), nil];
                                             }else if([status integerValue] == 4){
                                                return [RACTuple tupleWithObjects:@YES,@(self.device.workMode),@(self.device.reservationTime), nil];
                                             }
                                             else
                                             {
                                                return [RACTuple tupleWithObjects:@NO,@0,@0, nil];
                                             }
//                                             return [RACTuple tupleWithObjects:setHygrometer, nil];
                                         }]];
    
    //选择模式
   
    RAC(self.smallBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 1);
    }];
    RAC(self.soupBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 2);
    }];
    RAC(self.steamBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 3);
    }];
    RAC(self.cakeBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 4);
    }];
    RAC(self.firewoodBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 5);
    }];
    RAC(self.gruelBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 6);
    }];
    RAC(self.porridgeBtn, selected) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 7);
    }];
    
    //预约按键
    RAC(self.reservationIconBtn, enabled) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if (self.device.workStatus == 1 || self.device.workStatus == 4) {
            return @NO;
        }else if([state integerValue] == 1 || [state integerValue] ==2 || [state integerValue] ==3 || [state integerValue] ==5 || [state integerValue] ==6 ||[state integerValue] == 7){
            return @YES;
        }else{
            return @NO;
        }
        
    }];
    
    RAC(self.reservationIconBtn, enabled) = [RACObserve(self.device, isReservation) map:^id _Nullable (NSNumber *_Nullable state){
        @strongify(self)
        if (self.device.workStatus == 1 || self.device.workStatus == 4) {
            return @NO;
        }else if(self.device.workMode == 1 || self.device.workMode ==2 || self.device.workMode ==3 || self.device.workMode ==5 || self.device.workMode ==6 ||self.device.workMode == 7){
            return @YES;
        }else
            return @([state boolValue]);
    }];
    RAC(self.reservationIconBtn, selected) = [RACObserve(self.device, isReservation) map:^id _Nullable (NSNumber *_Nullable state){
        return @([state boolValue]);
    }];
    
     RACChannelTo(self.reservationBtn, userInteractionEnabled) = RACChannelTo(self.reservationIconBtn, enabled);
    
    //定时按键
    RAC(self.timingIconBtn, enabled) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if (self.device.workStatus == 1 || self.device.workStatus == 4) {
            return @NO;
        }else if([state integerValue] == 2 || [state integerValue] ==3  || [state integerValue] ==6 ||[state integerValue] == 7){
            return @YES;
        }else{
            return @NO;
        }
    }];
    
    RAC(self.timingIconBtn, enabled) = [RACObserve(self.device, isCookTiming) map:^id _Nullable (NSNumber *_Nullable state){
        @strongify(self)
        if (self.device.workStatus == 1 || self.device.workStatus == 4) {
            return @NO;
        }else if(self.device.workMode == 2 || self.device.workMode ==3  || self.device.workMode ==6 ||self.device.workMode == 7){
            return @YES;
        }else
            return @([state boolValue]);
    }];
    
    RAC(self.timingIconBtn, selected) = [RACObserve(self.device, isCookTiming) map:^id _Nullable (NSNumber *_Nullable state){
        return @([state boolValue]);
    }];
    
     RACChannelTo(self.timingBtn, userInteractionEnabled) = RACChannelTo(self.timingIconBtn, enabled);
    
    //开始按键
    RAC(self.startIconBtn, enabled) =
    [cookerWorkStatus map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if ([state integerValue] == 1 || [state integerValue] == 4 || self.device.workMode == 0) {
            return @NO;
            
        }else if(self.device.workMode){
            return @YES;
        }else
            return @NO;
    }];
    
    RAC(self.startIconBtn, enabled) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if (self.device.workStatus == 2 && [state integerValue]) {
            return @YES;
        }else
            return @NO;
    
    }];
    
    RACChannelTo(self.startBtn, userInteractionEnabled) = RACChannelTo(self.startIconBtn, enabled);
    
    //停止按键
    
    RAC(self.stopIconBtn, enabled) =
    [cookerWorkStatus map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if ([state integerValue] != 2 || self.device.workMode) {
            self.stopBtn.userInteractionEnabled = YES;
            return @YES;
        }else{
            self.stopBtn.userInteractionEnabled = NO;
            return @NO;
        }
    }];
    RAC(self.stopIconBtn, enabled) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        
        @strongify(self)
        if ([state integerValue] || self.device.workStatus != 2) {
            self.stopBtn.userInteractionEnabled = YES;
            return @YES;
        }else
        {
            self.stopBtn.userInteractionEnabled = NO;
            return @NO;
        }
    }];
    
    //保温按键
    
    RAC(self.warmIconBtn, enabled) =
    [cookerWorkStatus map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if (([state integerValue] ==2 && (!self.device.workMode) || [state integerValue] == 3)) {
            return @YES;
        }
        return @NO;
    }];
    RAC(self.warmIconBtn, enabled) =
    [cookerWorkMode map:^id _Nullable(NSNumber *_Nullable state) {
        @strongify(self)
        if ((![state integerValue]  && (self.device.workStatus ==2) || self.device.workStatus  == 3)) {
            return @YES;
        }
        return @NO;
    }];

    RAC(self.warmIconBtn, selected) =
    [cookerWorkStatus map:^id _Nullable(NSNumber *_Nullable state) {
        return @([state integerValue] == 3);
    }];
    
     RACChannelTo(self.warmBtn, userInteractionEnabled) = RACChannelTo(self.warmIconBtn, enabled);
    
    //保温状态下
    
    RAC(self, hideOverlay) =
    [RACObserve(self.warmIconBtn, selected) map:^id _Nullable (NSNumber *_Nullable state){
        return @(![state boolValue]);
    }];

}

- (void)bindAction {
    @weakify(self)
    //时间减
    [[self.timeReduceBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.device.timeAdjust execute:@NO];
         
     }];
    //时间加
    [[self.timeIncreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.device.timeAdjust execute:@YES];
         
     }];
    //开始
    self.startBtn.rac_command = self.device.startCook;
    [[self.startBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         if (self.device.reservationTime) {
             [self deviceRunning:YES workMode:self.device.workMode time:self.device.reservationTime];
         }else{
             [self deviceRunning:YES workMode:self.device.workMode time:self.device.workTime];
         }
        [self.startBtn showHightLightMessage:@"开启\n模式" bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
     }];
    //停止
    self.stopBtn.rac_command = self.device.stopCook;
    [[self.stopBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self deviceRunning:NO workMode:0 time:0];
         [self.stopBtn showHightLightMessage:@"停止" bgColor:[UIColor colorWithHexString:@"#ef5239"]];
     }];
    //保温
    self.warmBtn.rac_command = self.device.warm;
    [[self.warmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.warmBtn showHightLightMessage:@"开启保温" bgColor:[UIColor colorWithHexString:@"#fda215"]];
     }];
    //预约
    self.reservationBtn.rac_command = self.device.reservation;
    [[self.reservationBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.reservationBtn showHightLightMessage:@"开始预约" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
     }];
    //定时
    self.timingBtn.rac_command = self.device.cookTiming;
    [[self.timingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.timingBtn showHightLightMessage:@"开始定时" bgColor:[UIColor colorWithHexString:@"#6666ff"]];
     }];
    
    self.gruelBtn.rac_command = self.device.cookMode;
    self.porridgeBtn.rac_command = self.device.cookMode;
    self.firewoodBtn.rac_command = self.device.cookMode;
    self.smallBtn.rac_command = self.device.cookMode;
    self.soupBtn.rac_command = self.device.cookMode;
    self.steamBtn.rac_command = self.device.cookMode;
    self.cakeBtn.rac_command = self.device.cookMode;
//    [[self.gearSetting rac_signalForControlEvents:UIControlEventTouchUpInside]
//     subscribeNext:^(__kindof UIControl * _Nullable x) {
//         @strongify(self)
//         
//     }];
}


- (void)deviceRunning:(BOOL)isRunning workMode:(NSInteger)mode time:(NSInteger)time{
    if (isRunning) {
        self.showViewConstraint.constant = -TBScreenWidth;
        self.modeSelectView.hidden = YES;
        [self.view layoutIfNeeded];
        self.timeProgressView.cookMin = time;
        self.timeProgressView.cookMode = mode;
        [self.timeProgressView startLoading];
    }
    else{
        self.modeSelectView.hidden = NO;
        self.showViewConstraint.constant = 0;
        
        [self.timeProgressView endLoading];
        [self.view layoutIfNeeded];
    }
    
}


- (void)startTimeAnimation
{
    counter = 0;
    [self.timer invalidate];
    self.timer = nil;
    [self.timer fire];
}

- (void)startLighting{
    
    ++ counter;
    if (counter >4) {
        counter = 1;
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"--:--"];
    TBLog(@"--->%ld",counter);
    switch (counter) {
        case 1:
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, 1)];
            break;
        case 2:
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(1, 1)];
            break;
        case 3:
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(3, 1)];
            break;
        case 4:
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(4, 1)];
            break;
            
        default:
            break;
    }
    self.timeLabel.attributedText = attrStr;
    
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startLighting) userInfo:nil repeats:YES];
    }
    return _timer;
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
