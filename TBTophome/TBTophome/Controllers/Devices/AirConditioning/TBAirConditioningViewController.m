//
//  TBAirConditioningViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/14.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAirConditioningViewController.h"
#import "TBAircView.h"
#import "TBCAircView.h"
#import "UIView+Hud.h"

@interface TBAirConditioningViewController ()

@property (weak, nonatomic) TBAircView *aircView;

@end

@interface TBAirConditioningViewController (Setup_UI)

- (void)setup_ui;

@end

@implementation TBAirConditioningViewController

- (void)bindState {
    @weakify(self)
    [[[RACObserve(self.device, currentMode)
       deliverOn:[RACScheduler mainThreadScheduler]]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(TBAircModeModel * _Nullable x) {
         @strongify(self)
         self.aircView.modeBt.enabled = ArrayIsNotEmpty()(x.modes);
         self.aircView.refBt.enabled = [x.modes containsObject:@0];
         self.aircView.heaBt.enabled = [x.modes containsObject:@1];
         
         //每次切换遥控器后就需要重置状态
         self.device.modeIndex = 0;
         self.device.power = NO;
     }];
    
    //空调开关状态
    RACSignal<NSNumber *> *powerStateSignal = [RACObserve(self.device, power) takeUntil:[self rac_willDeallocSignal]];
    //空调温度
    RACSignal<NSNumber *> *tempValueSignal = [RACObserve(self.device, currentTemp) takeUntil:[self rac_willDeallocSignal]];
    //空调模式
    RACSignal<NSNumber *> *modeSignal = [RACObserve(self.device, currentModeValue) takeUntil:[self rac_willDeallocSignal]];
    //当前风速
    RACSignal<NSNumber *> *speedValueSignal = [RACObserve(self.device, currentSpeed)
                                               takeUntil:[self rac_willDeallocSignal]];
    //当前风向
    RACSignal<NSNumber *> *directValueSignal = [RACObserve(self.device, currentDirect) takeUntil:[self rac_willDeallocSignal]];
    
    RAC(self.aircView, power) = powerStateSignal;
    //是否显示控件信号
    RACSignal<NSNumber *> *isShowControlSignal = [powerStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    RAC(self.aircView.tempLabel, hidden) = isShowControlSignal;
    RAC(self.aircView.modeState, hidden) = isShowControlSignal;
    RAC(self.aircView.speedState, hidden) = isShowControlSignal;
    RAC(self.aircView.swwState, hidden) = isShowControlSignal;
    RAC(self.aircView.directState, hidden) = isShowControlSignal;
    
    //温度
    RAC(self.aircView.tempLabel, text) = [tempValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        if ([value integerValue] == -1) {
            return @"NA";
        }
        return [NSString stringWithFormat:@"%@℃", value];
    }];
    //模式
    RAC(self.aircView.modeState, image) = [modeSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"conditioner_mode_%@", value]];
    }];
    //风速
    RAC(self.aircView.speedState, image) = [speedValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"info_speed_%@.png", value]];
    }];
    //扫风
    RAC(self.aircView.swwState, image) = [directValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value integerValue] == 0 ? [UIImage imageNamed:@"info_sweep_1.png"] : [UIImage imageNamed:@"info_sweep_2.png"];
    }];
    //风向
    RAC(self.aircView.directState, image) = [directValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"info_direction_%@.png", value]];
    }];
}

- (void)controlAric:(UIButton *)sender {
    @weakify(self)
    [[self.device controlWithCmdIndex:sender.tag] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
//        [self.view showMessage:@"控制成功"];
    } error:^(NSError * _Nullable error) {
        @strongify(self)
        if (error.code == -1001)
            [self.view showMessage:error.localizedDescription];
    }];
}


- (void)bindAction {
    [self.aircView.modeBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.powerBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.speedBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.refBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.addTempBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.redTempBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.swwBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.heaBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.aircView.fiwBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initData {
    @weakify(self)
    [UIView showHudWithLabel:@"" inView:self.view];
    self.device.rids = @[@([self.device.device.irDeviceId integerValue])];
    [[[self.device getAirModeWithRid:[self.device.rids[0] integerValue]]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(TBAircModeModel * _Nullable x) {
        @strongify(self)
         self.device.currentMode = x;
         [UIView hideHudInView:self.view];
    } error:^(NSError * _Nullable error) {
        @strongify(self)
        [UIView hideHudInView:self.view];
        [self.view showMessage:error.localizedDescription];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    [self bindAction];
    [self bindState];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation TBAirConditioningViewController (Setup_UI)

- (void)setup_ui {
    UIView *remoteView = nil;
    if ([[self.device.device.company pathExtension] integerValue] == 0) { //壁式
        remoteView = [TBAircView RemoteViewPanelType:RemoteWallAirType];
    } else {
        remoteView = [TBAircView RemoteViewPanelType:RemoteCabinetAirType];
    }
    remoteView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:remoteView atIndex:0];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[remoteView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(remoteView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[remoteView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(remoteView)]];
    self.aircView = remoteView;
}

@end
