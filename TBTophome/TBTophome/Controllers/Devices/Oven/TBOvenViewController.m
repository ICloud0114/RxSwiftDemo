//
//  TBOvenViewController.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBOvenViewController.h"
#import "ICRecipeViewController.h"
#import "ICOvenCustomViewController.h"
#import "ICOvenSetWarmUpController.h"

#import "UIView+HighlightedMessage.h"

#import "UIColor+Ex.h"

#import "ICShowOvenProgressView.h"
#import "ICWarmProgressView.h"

@interface TBOvenViewController (){

}
@property (nonatomic, assign) BOOL isWork;
@property (nonatomic, assign) BOOL isWarm;
@property (nonatomic, assign) BOOL isChangeTime;
@property (nonatomic, copy) NSString *storeMode;
@property (nonatomic, assign)BOOL timeKeep;
@property (nonatomic, copy) NSString *storeTemp;
@property (weak, nonatomic) IBOutlet UIView *functionView;
@property (weak, nonatomic) IBOutlet UIView *operationView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *lightIconButton;
@property (weak, nonatomic) IBOutlet UIButton *lockIconButton;

@property (weak, nonatomic) IBOutlet UIButton *powerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *onoffImage;

@property (weak, nonatomic) IBOutlet UIButton *lightButton;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;

@property (weak, nonatomic) IBOutlet UIView *normalView;
@property (weak, nonatomic) IBOutlet UIView *workView;
@property (weak, nonatomic) IBOutlet UIView *heatView;
@property (weak, nonatomic) IBOutlet ICWarmProgressView *warmView;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *lightBtn;
@property (weak, nonatomic) IBOutlet UIButton *lockBtn;

@property (weak, nonatomic) IBOutlet UIButton *startIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *lightIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *lockIconBtn;

@property (weak, nonatomic) IBOutlet UIButton *changeTimeBtn;
@property (nonatomic, weak) IBOutlet UILabel *foodTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempLabel;

@property (nonatomic, weak) IBOutlet UILabel *warmTempLabel;
@property (weak, nonatomic) IBOutlet ICShowOvenProgressView *progressView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pop1BottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pop2BottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pop3BottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pop4BottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *pop1View;
@property (weak, nonatomic) IBOutlet UIView *pop2View;

@property (weak, nonatomic) IBOutlet UIView *pop3View;

@property (weak, nonatomic) IBOutlet UIView *pop4View;

@property (strong, nonatomic) UIView *coverView;

@property (weak, nonatomic) IBOutlet UIView *workCoverView;
@property (weak, nonatomic) IBOutlet UIView *normalCoverView;


@property (weak, nonatomic) IBOutlet UILabel *timeChangeTitle;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *fixPickerView;


@property (nonatomic, strong) NSMutableArray *hoursArr;
@property (nonatomic, strong) NSMutableArray *minutesArr;
@property (nonatomic, strong) NSMutableArray *fixMinutesArr;

@property (weak, nonatomic) IBOutlet UIButton *confirmChangeBtn;

@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger min;

@property (nonatomic, assign) NSInteger timeFlag;


@end

@implementation TBOvenViewController


- (void)dealloc{
    TBLog(@"销毁毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindState];
    [self bindAction];
    [self.device.ovenState execute:nil];
    
}

#pragma mark -function

- (void)bindState{
    @weakify(self)
    
    RAC(self.powerBtn, selected) = [RACObserve(self.device, lightStatus) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        light_status_t lightStatus;
        int status = [value intValue];
        memcpy(&lightStatus, &status, sizeof(light_status_t));
        
        if (lightStatus.oven_lamp == 1 || lightStatus.oven_lamp == 2) {
            self.lightIconButton.selected = YES;
            self.lightIconBtn.selected = YES;
        }else if(lightStatus.oven_lamp == 0 || lightStatus.oven_lamp == 3){
            self.lightIconButton.selected = NO;
            self.lightIconBtn.selected = NO;
        }
        self.lightButton.selected = self.lightIconButton.selected;
        self.lightBtn.selected = self.lightIconBtn.selected;
        
        if (lightStatus.screen_lock == 1 ||lightStatus.screen_lock == 2) {
            self.lockIconButton.selected = YES;
            self.lockIconBtn.selected = YES;
            [self screenLock:YES];
            
        }else if(lightStatus.screen_lock == 0 || lightStatus.screen_lock == 3){
            self.lockIconButton.selected = NO;
            self.lockIconBtn.selected = NO;
            [self screenLock:NO];
        }
        self.lockButton.selected = self.lockIconButton.selected;
        self.lockBtn.selected = self.lockIconBtn.selected;
        
        if (lightStatus.power == 1 || lightStatus.power == 2) {
            self.onoffImage.image = [UIImage imageNamed:@"oven_on"];
            return @YES;
        }else{
            self.onoffImage.image = [UIImage imageNamed:@"oven_off"];
            self.isWarm = NO;
            self.isWork = NO;
            return @NO;
        }
        
    }];
    
    
    //开始、暂停
    
    RAC(self.startBtn, selected) = [RACObserve(self.device, pauseFlag) map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 0 || [value integerValue] == 3) {
            self.startIconBtn.selected = YES;
            if (self.device.preheatingFlag) {
                [self.warmView startLoading];
            }else if(self.device.startWorkFlag){
                [self.progressView startLoading];
            }
            return @YES;
        }else{
            self.startIconBtn.selected = NO;
            if (self.device.preheatingFlag) {
                [self.warmView endLoading];
            }else if(self.device.startWorkFlag){
                [self.progressView endLoading];
            }
            return @NO;
        }
    }];
//
    RAC(self.overlay,hidden) = [RACObserve(self.device, lightStatus)map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        light_status_t lightStatus;
        int status = [value intValue];
        memcpy(&lightStatus, &status, sizeof(light_status_t));
        if (lightStatus.power == 1) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.workView, hidden) = [RACObserve(self.device, preheatingFlag) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1 ) {
            self.isWarm = YES;
        }else if([value integerValue] == 2){
            self.isWarm = YES;
        }
        else{
            
            if (self.isWarm && self.device.stopFlag != 2&& self.timeFlag == 1) {
                [self addCoverView];
                self.pop3BottomConstraint.constant = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
            self.isWarm = NO;
        }
        if ([value integerValue] == 1 || [value integerValue] == 2) {
            self.normalView.hidden = YES;
            self.heatView.hidden = YES;
            self.warmView.hidden = NO;
             [self.progressView endLoading];
            [self.warmView startLoading];
            return @NO;
        }else if(self.device.startWorkFlag){
            
            self.normalView.hidden = YES;
            self.warmView.hidden = YES;
            self.heatView.hidden = NO;
            [self.progressView startLoading];
            [self.warmView endLoading];
            self.progressView.circleImageView.image = [UIImage imageNamed:@"oven_slide_bg"];
            return @NO;
        }
        else{
            if (!self.timeKeep) {
                self.normalView.hidden = NO;
                [self.progressView endLoading];
                [self.warmView endLoading];
                return @YES;
            }
            else{
                self.progressView.circleImageView.image = [UIImage imageNamed:@"oven_slide_circle"];
                [self.progressView endLoading];
                return @NO;
            }
            
        }
    }];
    RAC(self.workView, hidden) = [RACObserve(self.device, startWorkFlag) map:^id _Nullable(NSNumber * _Nullable value) {
        @strongify(self)
        if ([value integerValue] == 1 ||[value integerValue] == 2) {
            self.isWork = YES;
            self.timeKeep = NO;
            [self dismissCoverView];
            self.progressView.circleImageView.image = [UIImage imageNamed:@"oven_slide_bg"];
            
        }else{
            if (self.isWork && self.device.stopFlag != 2 && self.timeFlag == 1) {
                [self addCoverView];
                self.pop1BottomConstraint.constant = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
                self.timeKeep = YES;
            }
            if (!self.timeKeep) {
                self.isWork = NO;
            }
            
        }
        
        if ([value integerValue] == 1 || [value integerValue] == 2 ) {
            self.normalView.hidden = YES;
            self.warmView.hidden = YES;
            self.heatView.hidden = NO;
             [self.progressView startLoading];
            [self.warmView endLoading];
            return @NO;
        }else if(self.device.preheatingFlag){
            self.normalView.hidden = YES;
            self.heatView.hidden = YES;
            self.warmView.hidden = NO;
             [self.progressView endLoading];
            [self.warmView startLoading];
            return @NO;
        }else{
            if (!self.timeKeep) {
                self.normalView.hidden = NO;
                [self.progressView endLoading];
                [self.warmView endLoading];
                return @YES;
            }
            else{
                self.progressView.circleImageView.image = [UIImage imageNamed:@"oven_slide_circle"];
                [self.progressView endLoading];
                return @NO;
            }
            
        }
    }];
//
    RAC(self.warmTempLabel, text) = [RACObserve(self.device, setTemp)map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        if ([value integerValue]) {
            self.tempLabel.text = [NSString stringWithFormat:@"%ld",[value integerValue]];
            self.storeTemp = self.tempLabel.text;
            return [NSString stringWithFormat:@"%ld",[value integerValue]];
        }else{
            if (self.timeKeep) {
                self.tempLabel.text = self.storeTemp;
                return self.storeTemp;
            }else{
                self.tempLabel.text = @"--";
                return @"";
            }
        }
        
        
        
    }];
    
    RAC(self.foodTypeLabel, text) = [RACObserve(self.device, displayMode)map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        if ([value integerValue]) {
            NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"OvenDisplayMode" ofType:@"plist"];
            NSDictionary *displayMode = [[NSDictionary alloc] initWithContentsOfFile:dataSourcePath];
            self.storeMode = [displayMode objectForKey:[NSString stringWithFormat:@"%ld",[value integerValue]]][0];
            return self.storeMode;
        }else{
            if (self.timeKeep) {
                return self.storeMode;
            }
            return @"";
        }
    }];
    
    RAC(self.progressView.timeLabel, text) = [RACObserve(self.device, remainingWorkTime)map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        if ([value integerValue]) {
            NSInteger time = [value integerValue];
            self.timeFlag = time;
            return [NSString stringWithFormat:@"%02zd:%02zd", time/60, time%60];
        }
        else{
            return @"00:00";
        }
    }];
    
}

- (void)bindAction{
     @weakify(self)
    self.powerBtn.rac_command = self.device.powerControl;
    [[self.powerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.isWork = NO;
        self.isWarm = NO;
        self.device.startWorkFlag = NO;
        
    }];
    //照明
    self.lightButton.rac_command = self.device.lightControl;
    
    [[self.lightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.lightIconButton.selected) {
            [self.lightButton showHightLightMessage:@"照明模式已开启" bgColor:[UIColor colorWithHexString:@"fda215"]];
        }
        else
        {
            [self.lightButton showHightLightMessage:@"照明模式已关闭" bgColor:[UIColor colorWithHexString:@"fda215"]];
        }

    }];
    
    self.lightBtn.rac_command = self.device.lightControl;
    
    [[self.lightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.lightIconBtn.selected) {
            [self.lightBtn showHightLightMessage:@"照明模式已开启" bgColor:[UIColor colorWithHexString:@"fda215"]];
        }
        else
        {
            [self.lightBtn showHightLightMessage:@"照明模式已关闭" bgColor:[UIColor colorWithHexString:@"fda215"]];
        }
        
    }];
    
    //锁屏
    self.lockButton.rac_command = self.device.screenLock;
    
    [[self.lockButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.lockIconButton.selected) {
            [self.lockButton showHightLightMessage:@"锁屏模式已开启" bgColor:[UIColor colorWithHexString:@"61c23e"]];
        }
        else
        {
            [self.lockButton showHightLightMessage:@"锁屏模式已关闭" bgColor:[UIColor colorWithHexString:@"61c23e"]];
        }
    }];
    self.lockBtn.rac_command = self.device.screenLock;
    
    [[self.lockBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.lockIconBtn.selected) {
            [self.lockBtn showHightLightMessage:@"锁屏模式已开启" bgColor:[UIColor colorWithHexString:@"61c23e"]];
        }
        else
        {
            [self.lockBtn showHightLightMessage:@"锁屏模式已关闭" bgColor:[UIColor colorWithHexString:@"61c23e"]];
        }
    }];
    
    //暂停、继续
    
    self.startBtn.rac_command = self.device.pauseHeating;
    [[self.startBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (!self.startBtn.selected) {
            [self.startBtn showHightLightMessage:@"暂停模式已开启" bgColor:[UIColor colorWithHexString:@"12a2eb"]];
        }
        else
        {
            [self.startBtn showHightLightMessage:@"继续模式已关闭" bgColor:[UIColor colorWithHexString:@"12a2eb"]];
        }
    }];
    
    //停止
    self.stopBtn.rac_command = self.device.stopHeating;
    [[self.stopBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.isWork = NO;
        self.isWarm = NO;
        
        if (self.device.preheatingFlag) {
            self.device.preheatingFlag = 0;
        }
        if (self.device.startWorkFlag) {
            self.device.startWorkFlag = 0;
        }
        
         [self.stopBtn showHightLightMessage:@"停止模式已开启" bgColor:[UIColor colorWithHexString:@"ef5239"]];
    }];

    
}


- (void)screenLock:(BOOL)status{
    
    self.bottomView.userInteractionEnabled = status?NO:YES;
    self.bottomView.layer.opacity = status?0.4:1;
    
    if (self.device.preheatingFlag) {
        self.warmView.userInteractionEnabled = status?NO:YES;
        self.warmView.layer.opacity = status?0.4:1;
        self.workCoverView.hidden = status?NO:YES;
        self.normalCoverView.hidden = YES;
    }else if (self.device.startWorkFlag){
        self.heatView.userInteractionEnabled = status?NO:YES;
        self.heatView.layer.opacity = status?0.4:1;
        self.workCoverView.hidden = status?NO:YES;
        self.normalCoverView.hidden = YES;
    }else{
        self.functionView.userInteractionEnabled = status?NO:YES;
        self.functionView.layer.opacity = status?0.4:1;
        self.normalCoverView.hidden = status?NO:YES;
        self.workCoverView.hidden = YES;
    }
}

#pragma mark -Action
- (IBAction)recipeAction:(id)sender {
    
    ICRecipeViewController *xibVC =[[ICRecipeViewController alloc] initWithNibName:@"ICRecipeViewController" bundle:nil];
    xibVC.startHeating = ^(NSDictionary *data, NSString *foodType){
        [self.device.startHeating execute:data];
        self.device.startWorkFlag = YES;
        self.device.displayMode = [data[@"displayMode"] integerValue];
        self.device.setTemp = [data[@"setTemp"] integerValue];
        self.device.remainingWorkTime = [data[@"setWorkTime"] integerValue];
    };
    
    [self.navigationController pushViewController:xibVC animated:YES];
}
- (IBAction)customAction:(id)sender {
    
    ICOvenCustomViewController *xibVC =[[ICOvenCustomViewController alloc] initWithNibName:@"ICOvenCustomViewController" bundle:nil];
    xibVC.startHeating = ^(NSDictionary *data, NSString *foodType){
        [self.device.startHeating execute:data];
        self.device.startWorkFlag = YES;
        
        self.device.displayMode = [data[@"displayMode"] integerValue];
        self.device.setTemp = [data[@"setTemp"] integerValue];
        self.device.remainingWorkTime = [data[@"setWorkTime"] integerValue];
    };
    
    [self.navigationController pushViewController:xibVC animated:YES];
}
- (IBAction)warmAction:(id)sender {
    
    ICOvenSetWarmUpController *xibVC =[[ICOvenSetWarmUpController alloc] initWithNibName:@"ICOvenSetWarmUpController" bundle:nil];
    
    xibVC.startWarm = ^(NSInteger temp){
        [self.device.preHeating execute:@(temp)];
        self.device.preheatingFlag = YES;
        self.device.setTemp = temp;
    };
    
    [self.navigationController pushViewController:xibVC animated:YES];
}



- (IBAction)changeTimeClick:(UIButton *)sender {
    self.timeChangeTitle.text = @"更改时间";
    [self addCoverView];
    self.pop2BottomConstraint.constant = 0;
    [self.pickerView selectRow:self.device.remainingWorkTime / 60 inComponent:0 animated:NO];
    [self.pickerView selectRow:self.device.remainingWorkTime % 60 inComponent:2 animated:NO];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
    self.isChangeTime = !self.isChangeTime;
}
- (IBAction)cancelChangeTime:(id)sender {
    
    [self dismissCoverView];
}

- (IBAction)fixTimeClick:(UIButton *)sender {
    self.timeChangeTitle.text = @"补时";
    self.pop1BottomConstraint.constant = -210;
    self.min = 1;
    [self.view layoutIfNeeded];
    self.pop4BottomConstraint.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)comfirmClick:(UIButton *)sender {

    [self cancleClick:nil];
}

- (void)addCoverView{
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:TBMainScreenBounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.6;
        [self.view insertSubview:_coverView belowSubview:_pop1View];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_coverView addSubview:button];
        button.frame = TBMainScreenBounds;
        [button addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationController.navigationBar.layer.opacity = 0.6;
        self.navigationController.navigationBar.userInteractionEnabled = NO;
    }
    
}

- (IBAction)cancleClick:(UIButton *)sender {
    
    if (!self.isChangeTime) {
        self.timeKeep = NO;
        self.isWork = NO;
        self.isWarm = NO;
        [self dismissCoverView];
        self.device.startWorkFlag = NO;
    }else{
        self.isChangeTime = NO;
        [self dismissCoverView];
    }
}

- (void)dismissCoverView{
    self.pop1BottomConstraint.constant = -210;
    self.pop2BottomConstraint.constant = -315;
    self.pop3BottomConstraint.constant = -210;
    self.pop4BottomConstraint.constant = -315;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        [_coverView removeFromSuperview];
        
    }];
    _coverView = nil;
    
    self.navigationController.navigationBar.layer.opacity = 1;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (IBAction)comfirmChangeTimeClick:(UIButton *)sender {
    NSInteger newTime = self.hour * 60 + self.min;

    self.progressView.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", newTime/60, newTime%60];
    if ([self.timeChangeTitle.text isEqualToString:@"更改时间"]) {
        
        //改时
        [self.device.changeTime execute:@(newTime)];
        self.isChangeTime = NO;
    }
    else
    {
        //补时
        [self.device.timekeeping execute:@(newTime)];
        
    }
    _timeKeep = YES;
    [self dismissCoverView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.fixPickerView) {
        return 2;
    }
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.fixPickerView) {
        if (!component) {
           return self.fixMinutesArr.count;
        }else{
            return 1;
        }
        
    }else{
        if (component  == 0) {
            return self.hoursArr.count;
        }
        else if(component == 2)
        {
            return self.minutesArr.count;
        }
        return 1;
    }
    
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView == self.fixPickerView) {
        
        if (!component) {
            return self.fixMinutesArr[row];
        }else{
            return @"分";
        }
    }else{
        if (component  == 0) {
            return self.hoursArr[row];
        }
        else if(component == 2)
        {
            return self.minutesArr[row];
        }
        if (component == 1) {
            return @"时";
        }
        if (component == 3) {
            return @"分";
        }
        return nil;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (pickerView == self.fixPickerView) {
        if (!component) {
            return 40;
        }else{
            return 40;
        }
    }else{
        if (component == 0 || component == 2) {
            return 40;
        }else{
            return 40;
        }
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSString *hour = @"0";
    NSString *minutes = @"0";
    
    if (pickerView == self.fixPickerView) {
        
        if (!component) {
            self.min = row + 1;
            minutes = [NSString stringWithFormat:@"%@",self.fixMinutesArr[row] ];

        }
        
    }else{
        if (component == 0) {
            self.hour = row;
            hour = [NSString stringWithFormat:@"%@",self.hoursArr[row] ];
        }
        else if(component == 2)
        {
            self.min = row;
            minutes = [NSString stringWithFormat:@"%@",self.minutesArr[row] ];
        }
        if (self.min || self.hour) {
            self.confirmChangeBtn.enabled = YES;
        }else{
           self.confirmChangeBtn.enabled = NO;
        }
    }
}

- (NSMutableArray *)hoursArr
{
    if (!_hoursArr) {
        _hoursArr = @[].mutableCopy;
        
        for (NSInteger hour = 0;  hour < 24; ++ hour) {
            NSString *str = [NSString stringWithFormat:@"%ld",hour];
            [_hoursArr addObject:str];
        }
    }
    return _hoursArr;
}

- (NSMutableArray *)minutesArr
{
    if (!_minutesArr) {
        _minutesArr = @[].mutableCopy;
        
        for (NSInteger minutes = 0;  minutes < 60; ++ minutes) {
            NSString *str = [NSString stringWithFormat:@"%ld",minutes];
            [_minutesArr addObject:str];
        }
    }
    return _minutesArr;
}

- (NSMutableArray *)fixMinutesArr
{
    if (!_fixMinutesArr) {
        _fixMinutesArr = @[].mutableCopy;
        
        for (NSInteger minutes = 1;  minutes <= 30; ++ minutes) {
            NSString *str = [NSString stringWithFormat:@"%ld",minutes];
            [_fixMinutesArr addObject:str];
        }
    }
    return _fixMinutesArr;
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
