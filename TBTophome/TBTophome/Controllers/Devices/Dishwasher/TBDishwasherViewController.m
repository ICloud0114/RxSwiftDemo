//
//  TBDishwasherViewController.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/23.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDishwasherViewController.h"
#import "LFDishwasherReservationView.h"
#import "UIView+Ex.h"
#import "UIView+HighlightedMessage.h"
#import "UIColor+Ex.h"
@interface TBDishwasherViewController ()<LFDishwasherReservationViewDelegate>

@property (nonatomic, strong)LFDishwasherReservationView *reservationView;
@property (weak, nonatomic) IBOutlet UIButton *power;
@property (weak, nonatomic) UIButton *pMode;

@property (weak, nonatomic) IBOutlet UIButton *status0;//预约中
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *status0LeadingConstraint;

@property (weak, nonatomic) IBOutlet UIButton *status1; //缺盐
@property (weak, nonatomic) IBOutlet UIButton *status2; //缺光亮剂

@property (weak, nonatomic) IBOutlet UILabel *currentModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;


@property (weak, nonatomic) IBOutlet UIView *panel;
@property (weak, nonatomic) IBOutlet UIView *controlPanel;
@property (weak, nonatomic) IBOutlet UIView *statusPanel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *lockCoverView;

@property (weak, nonatomic) IBOutlet UIButton *cleanMode1;
@property (weak, nonatomic) IBOutlet UIButton *cleanMode2;
@property (weak, nonatomic) IBOutlet UIButton *cleanMode3;
@property (weak, nonatomic) IBOutlet UIButton *cleanMode4;
@property (weak, nonatomic) IBOutlet UIButton *cleanMode5;
@property (weak, nonatomic) IBOutlet UIButton *cleanMode6;


@property (weak, nonatomic) IBOutlet UIButton *workBtn;
@property (weak, nonatomic) IBOutlet UIButton *mixBtn;
@property (weak, nonatomic) IBOutlet UIButton *reservationBtn;
@property (weak, nonatomic) IBOutlet UIButton *lockBtn;

@property (weak, nonatomic) IBOutlet UIButton *icon1;
@property (weak, nonatomic) IBOutlet UIButton *icon2;
@property (weak, nonatomic) IBOutlet UIButton *icon3;
@property (weak, nonatomic) IBOutlet UIButton *icon4;
@property (weak, nonatomic) IBOutlet UIButton *lockTitleBtn;

@end


@interface TBDishwasherViewController (LFDishwasherReservationViewDelegate)

@end

@implementation TBDishwasherViewController
- (void)dealloc{
    TBLog(@"销毁毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindState];
    [self bindAction];
    [self.device.deviceState execute:nil];
}

- (void)bindState{
     @weakify(self)
    RAC(self.status1,hidden) = [RACObserve(self.device, faultCode) map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1) {
            self.status2.hidden = YES;
            if (!self.device.appointmentHour) {
                self.status0LeadingConstraint.constant = -103;
            }else{
                self.status0LeadingConstraint.constant = 20;
            }
            return @NO;
        }else if([value integerValue] == 2){
            self.status2.hidden = NO;
            if (!self.device.appointmentHour) {
                self.status0LeadingConstraint.constant = -180;
            }else{
                self.status0LeadingConstraint.constant = 20;
            }
            return @YES;
        }else if([value integerValue] == 3){
            self.status2.hidden = NO;
            if (!self.device.appointmentHour) {
                self.status0LeadingConstraint.constant = -103;
            }else{
                self.status0LeadingConstraint.constant = 20;
            }
            
            return @NO;
        }else{
            self.status2.hidden = YES;
            return @YES;
        }
        
    }];
    RAC(self.cleanMode1, selected) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.cleanMode2, selected) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 2) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.cleanMode3, selected) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 3) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.cleanMode4, selected) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 4) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.cleanMode5, selected) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 5) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.cleanMode6, selected) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 6) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.currentModeLabel, text) = [RACObserve(self.device, cleanMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue]) {
            NSArray *mode = @[@"强力洗",@"经济洗",@"标准洗",@"1小时洗",@"快速洗",@"预冲洗"];
            return mode[[value integerValue] - 1];
        }else{
            return @"";
        }
    }];
    
    
    RAC(self.timeLabel, text) = [RACObserve(self.device, remainingMinute)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if (!self.device.appointmentHour) {
            self.loadingTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",self.device.remainingMinute / 60, self.device.remainingMinute % 60];
        }else{
            self.loadingTimeLabel.text = [NSString stringWithFormat:@"%02zd H",self.device.remainingMinute];
        }
        
        return self.loadingTimeLabel.text;
    }];
    
    RAC(self.overlay, hidden) = [RACObserve(self.device, status)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1) {//关机
            self.statusPanel.hidden = YES;
            self.controlPanel.hidden = NO;
            self.power.selected = NO;
            self.workBtn.userInteractionEnabled = YES;
            self.workBtn.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.f];
            return @NO;
        }else{
            if([value integerValue] == 2){//待机
                self.icon1.selected = NO;
                self.statusPanel.hidden = YES;
                self.controlPanel.hidden = NO;
                
            }else if([value integerValue] == 3){//启动
                
                self.icon1.selected = YES;
                if (self.device.appointmentHour) {
                    self.workBtn.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.6f];
                    self.workBtn.userInteractionEnabled = NO;
                }else{
                    self.workBtn.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.f];
                    self.workBtn.userInteractionEnabled = YES;
                }
                self.statusPanel.hidden = NO;
                self.controlPanel.hidden = YES;
                
                [self.loadingImageView startRepeatRotate];
            }else if([value integerValue] == 4){//暂停
                self.icon1.selected = NO;
                self.statusPanel.hidden = NO;
                self.controlPanel.hidden = YES;

                [self.loadingImageView endRepeatRotate];
            }
            self.power.selected = YES;
            return @YES;
        }
            
            
    }];
    
    RACChannelTo(self.workBtn, selected) = RACChannelTo(self.icon1, selected);
    
//3合一
    
    RAC(self.icon2, selected) = [RACObserve(self.device, mixMode)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1) {
            return @NO;
        }else{
            
            return @YES;
        }
    }];
    RAC(self.mixBtn,backgroundColor) = [RACObserve(self.device, status)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 3 || [value integerValue] == 4) {
            self.mixBtn.userInteractionEnabled = NO;
            return [UIColor colorWithWhite:1.f alpha:0.6f];
        }else{
            if (self.device.cleanMode == 1 || self.device.cleanMode == 2 || self.device.cleanMode == 3) {
                self.mixBtn.userInteractionEnabled = YES;
                return [UIColor colorWithWhite:1.f alpha:0.0f];
            }
            else{
                self.mixBtn.userInteractionEnabled = NO;
                return [UIColor colorWithWhite:1.f alpha:0.6f];
            }
            
        }
    }];
    
    RACChannelTo(self.mixBtn, selected) = RACChannelTo(self.icon2, selected);

//预约
    RAC(self.icon3, selected) = [RACObserve(self.device, appointmentHour)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if (![value integerValue]) {
            self.status0.hidden = YES;
            self.status0LeadingConstraint.constant = -103;
            return @NO;
        }else{
            self.status0.hidden = NO;
            self.status0LeadingConstraint.constant = 20;
            return @YES;
        }
    }];
    
    RAC(self.reservationBtn,backgroundColor) = [RACObserve(self.device, status)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 3 || [value integerValue] == 4) {
            self.reservationBtn.userInteractionEnabled = NO;
            return [UIColor colorWithWhite:1.f alpha:0.6f];
        }else{
            self.reservationBtn.userInteractionEnabled = YES;
            return [UIColor colorWithWhite:1.f alpha:0.0f];
        }
    }];
    RACChannelTo(self.reservationBtn, selected) = RACChannelTo(self.icon3, selected);

//童锁
    RAC(self.icon4, selected) = [RACObserve(self.device, childLock)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1) {
            self.bottomView.layer.opacity = 1;
            self.bottomView.userInteractionEnabled = YES;
            self.panel.layer.opacity = 1;
            self.panel.userInteractionEnabled = YES;
            self.lockCoverView.hidden = YES;
            self.lockTitleBtn.selected = NO;
            return @NO;
        }else{
            self.bottomView.layer.opacity = 0.4;
            self.bottomView.userInteractionEnabled = NO;
            self.panel.layer.opacity = 0.4;
            self.panel.userInteractionEnabled = YES;
            self.lockCoverView.hidden = NO;
            self.lockTitleBtn.selected = YES;
            return @YES;
        }
    }];

    RAC(self.lockBtn,backgroundColor) = [RACObserve(self.device, status)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 3 || [value integerValue] == 1) {
            self.lockBtn.userInteractionEnabled = YES;
            return [UIColor colorWithWhite:1.f alpha:0.0f];
        }else{
            self.lockBtn.userInteractionEnabled = NO;
            return [UIColor colorWithWhite:1.f alpha:0.6f];
        }
    }];
    RACChannelTo(self.lockBtn, selected) = RACChannelTo(self.icon4, selected);
    
}

- (void)bindAction{
     @weakify(self)
    
    [[RACSignal merge:@[
                        [self.cleanMode1 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.cleanMode2 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.cleanMode3 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.cleanMode4 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.cleanMode5 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [self.cleanMode6 rac_signalForControlEvents:UIControlEventTouchUpInside]
                        ]] subscribeNext:^(UIButton * _Nullable x) {
        @strongify(self)
        self.device.cleanMode = x.tag;
        [self.device.selectCleanMode execute:nil];
    }];
    
    self.workBtn.rac_command = self.device.startWork;
    [[self.workBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (!self.workBtn.selected) {
            [self.workBtn showHightLightMessage:@"暂停" bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
        }else{
            [self.workBtn showHightLightMessage:@"开始" bgColor:[UIColor colorWithHexString:@"#12a2eb"]];
        }
    }];
    
    
    self.power.rac_command = self.device.power;
    self.mixBtn.rac_command = self.device.mix3IN1;
    
    [[self.mixBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (!self.mixBtn.selected) {
            [self.mixBtn showHightLightMessage:@"3IN1模式关闭" bgColor:[UIColor colorWithHexString:@"#ef5239"]];
        }else{
            [self.mixBtn showHightLightMessage:@"3IN1模式开启" bgColor:[UIColor colorWithHexString:@"#ef5239"]];
        }
    }];
    self.lockBtn.rac_command = self.device.lockCommand;
    [[self.lockBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         if (!self.lockBtn.selected) {
             [self.lockBtn showHightLightMessage:@"锁屏模式关闭" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
         }else{
             [self.lockBtn showHightLightMessage:@"锁屏模式开启" bgColor:[UIColor colorWithHexString:@"#61c23e"]];
         }
         
     }];
    

    [self.reservationView rac_liftSelector:@selector(showInView:)
                   withSignalOfArguments:[[self.reservationBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                                          map:^id _Nullable(__kindof UIControl * _Nullable value) {
                                              @strongify(self)
                                              return [RACTuple tupleWithObjects:self.navigationController.view, nil];
                                          }]];
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
#pragma mark - getter setter
- (LFDishwasherReservationView *)reservationView {
    if (!_reservationView) {
        _reservationView = [LFDishwasherReservationView dishwasherReservationView];
        _reservationView.delegate = self;
    }
    return _reservationView;
}
@end

@implementation TBDishwasherViewController(LFDishwasherReservationViewDelegate)

- (void)didSelectedReservationTime:(NSUInteger)hour{
    

    TBLog(@"appointment hour----->%ld",hour);
    [self.device.reservationCommand execute:@(hour)];
}

@end
