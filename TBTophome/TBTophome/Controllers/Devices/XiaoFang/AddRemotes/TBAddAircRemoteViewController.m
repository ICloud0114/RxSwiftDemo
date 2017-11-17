//
//  TBAddAircRemoteViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddAircRemoteViewController.h"
#import "TBAircDeviceViewModel.h"
#import "UIView+Hud.h"
#import "AlertView.h"

@interface TBAddAircRemoteViewController () <AlertViewDelegate>

@property (nonatomic, strong) TBAircDeviceViewModel *aircViewModel;

@property (nonatomic, strong) NSMutableArray<UIButton *> *tapBts; //记录按下的按钮，当首次3次提示是否使用当前遥控器
@end

@interface TBAddAircRemoteViewController (AlertViewDelegate)

@end

@implementation TBAddAircRemoteViewController

- (void)bindState {
    @weakify(self)
    [[RACObserve(self.aircViewModel, currentMode) takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(TBAircModeModel * _Nullable x) {
        @strongify(self)
         self.remoteView.modeBt.enabled = ArrayIsNotEmpty()(x.modes);
         self.remoteView.refBt.enabled = [x.modes containsObject:@0];
         self.remoteView.heaBt.enabled = [x.modes containsObject:@1];
         self.remoteView.fiwBt.enabled = [x.direct containsObject:@1];
         self.remoteView.swwBt.enabled = [x.direct containsObject:@0];
         
         //每次切换遥控器后就需要重置状态
         self.aircViewModel.modeIndex = 0;
         self.aircViewModel.power = NO;
    }];
    
    //空调开关状态
    RACSignal<NSNumber *> *powerStateSignal = [RACObserve(self.aircViewModel, power) takeUntil:[self rac_willDeallocSignal]];
    //空调温度
    RACSignal<NSNumber *> *tempValueSignal = [RACObserve(self.aircViewModel, currentTemp) takeUntil:[self rac_willDeallocSignal]];
    //空调模式
    RACSignal<NSNumber *> *modeSignal = [RACObserve(self.aircViewModel, currentModeValue) takeUntil:[self rac_willDeallocSignal]];
    //当前风速
    RACSignal<NSNumber *> *speedValueSignal = [RACObserve(self.aircViewModel, currentSpeed)
                                               takeUntil:[self rac_willDeallocSignal]];
    //当前风向
    RACSignal<NSNumber *> *directValueSignal = [RACObserve(self.aircViewModel, currentDirect) takeUntil:[self rac_willDeallocSignal]];
    
    RAC(self.remoteView, power) = powerStateSignal;
    //是否显示控件信号
    RACSignal<NSNumber *> *isShowControlSignal = [powerStateSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return @(![value boolValue]);
    }];
    RAC(self.remoteView.tempLabel, hidden) = isShowControlSignal;
    RAC(self.remoteView.modeState, hidden) = isShowControlSignal;
    RAC(self.remoteView.speedState, hidden) = isShowControlSignal;
    RAC(self.remoteView.swwState, hidden) = isShowControlSignal;
    RAC(self.remoteView.directState, hidden) = isShowControlSignal;
    
    //温度
    RAC(self.remoteView.tempLabel, text) = [tempValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        if ([value integerValue] == -1) {
            return @"NA";
        }
        return [NSString stringWithFormat:@"%@℃", value];
    }];
    //模式
    RAC(self.remoteView.modeState, image) = [modeSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"conditioner_mode_%@", value]];
    }];
    //风速
    RAC(self.remoteView.speedState, image) = [speedValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"info_speed_%@.png", value]];
    }];
    //扫风
    RAC(self.remoteView.swwState, image) = [directValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [value integerValue] == 0 ? [UIImage imageNamed:@"info_sweep_1.png"] : [UIImage imageNamed:@"info_sweep_2.png"];
    }];
    //风向
    RAC(self.remoteView.directState, image) = [directValueSignal map:^id _Nullable(NSNumber * _Nullable value) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"info_direction_%@.png", value]];
    }];
}

- (void)controlAric:(UIButton *)sender {
    @weakify(self)
    if (![self.tapBts containsObject:sender]) {
        [self.tapBts addObject:sender];
    }
    
    if (self.tapBts.count == 3) {
        //当首次按键达到3次，进行提升
        AlertView *alert = [AlertView alertView:MessageStyle];
        alert.delegate = self;
        alert.title.text = @"提升";
        alert.message.text = @"您按的这几个按钮能正确控制空调吗?";
        [alert.actions[0] setTitle:@"不正确，换一个试试" forState:UIControlStateNormal];
        [alert.actions[1] setTitle:@"正确，就用它了" forState:UIControlStateNormal];
        [alert showInView:self.view];
    } else if (self.tapBts.count == 1) { //显示提示
        [self.tipView show];
    }
    
    [[self.aircViewModel controlWithCmdIndex:sender.tag] subscribeError:^(NSError * _Nullable error) {
        @strongify(self)
        if (error.code == -1001) {
            [self.view showMessage:error.localizedDescription];
        }
    }];
//    
//    [[self.aircViewModel controlWithCmdIndex:sender.tag] subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
////        [self.view showMessage:@"控制成功"];
//        if (self.tapBts.count == 3) {
//            //当首次按键达到3次，进行提升
//            AlertView *alert = [AlertView alertView:MessageStyle];
//            alert.delegate = self;
//            alert.title.text = @"提升";
//            alert.message.text = @"您按的这几个按钮能正确控制空调吗?";
//            [alert.actions[0] setTitle:@"不正确，换一个试试" forState:UIControlStateNormal];
//            [alert.actions[1] setTitle:@"正确，就用它了" forState:UIControlStateNormal];
//            [alert showInView:self.view];
//        } else if (self.tapBts.count == 1) { //显示提示
//            [self.tipView show];
//        }
//    } error:^(NSError * _Nullable error) {
//        
//    }];
}


- (void)bindAction {
    @weakify(self)
    [self.remoteView.modeBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.powerBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.speedBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.refBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.addTempBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.redTempBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.swwBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.heaBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.fiwBt addTarget:self action:@selector(controlAric:) forControlEvents:UIControlEventTouchUpInside];

//    NSArray *cmds = @[
//                      [self.remoteView.modeBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.powerBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.speedBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.refBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.addTempBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.redTempBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.swwBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.heaBt rac_signalForControlEvents:UIControlEventTouchUpInside],
//                      [self.remoteView.fiwBt rac_signalForControlEvents:UIControlEventTouchUpInside]
//                      ];
//    [[[RACSignal merge:cmds] flattenMap:^__kindof RACSignal * _Nullable(UIButton * _Nullable value) {
//       @strongify(self)
//        if (![self.tapBts containsObject:value]) {
//            [self.tapBts addObject:value];
//        }
//        return [self.aircViewModel controlWithCmdIndex:value.tag];
//    }] subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//        [self.view showMessage:@"控制成功"];
//        if (self.tapBts.count == 3) {
//            //当首次按键达到3次，进行提升
//            AlertView *alert = [AlertView alertView:MessageStyle];
//            alert.delegate = self;
//            alert.title.text = @"提升";
//            alert.message.text = @"您按的这几个按钮能正确控制空调吗?";
//            [alert.actions[0] setTitle:@"不正确，换一个试试" forState:UIControlStateNormal];
//            [alert.actions[1] setTitle:@"正确，就用它了" forState:UIControlStateNormal];
//            [alert showInView:self.view];
//        }
//    } error:^(NSError * _Nullable error) {
//        [self.view showMessage:error.localizedDescription];
//    }];
}

- (void)initData {
    @weakify(self)
    [UIView showHudWithLabel:@"" inView:self.view];
    [[[[self.aircViewModel getInfraredCodes] flattenMap:^__kindof RACSignal<TBAircModeModel *> * _Nullable(NSArray<NSNumber *> * _Nullable value) {
        @strongify(self)
        self.aircViewModel.rids = value;
        return [self.aircViewModel getAirModeWithRid:[value[0] integerValue]];
    }] deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(TBAircModeModel * _Nullable x) {
        @strongify(self)
        self.aircViewModel.currentMode = x;
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
    self.tapBts = [NSMutableArray array];
    
    [self bindState];
    [self bindAction];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overwrite
- (void)getAricModeWithRidIndex:(NSInteger)index {
    @weakify(self)
    self.aircViewModel.ridIndex = index;
    [UIView showHudWithLabel:@"" inView:self.view];
    [[[self.aircViewModel getAirModeWithRid:[self.aircViewModel.rids[index] integerValue]]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(TBAircModeModel * _Nullable x) {
        @strongify(self)
         [UIView hideHudInView:self.view];
         self.aircViewModel.currentMode = x;
    } error:^(NSError * _Nullable error) {
        @strongify(self)
        [UIView hideHudInView:self.view];
        [self.view showMessage:error.localizedDescription];
    }];
}

- (NSInteger)ridCount {
    return self.aircViewModel.rids.count;
}

- (NSInteger)currentRidIndex {
    return self.aircViewModel.ridIndex;
}

- (void)saveRemote {
    @weakify(self)
    NSInteger style = 0;
    if ([self.remoteView isKindOfClass:NSClassFromString(@"TBCAircView")]) {
        style = 1;
    }
    [UIView showHudWithLabel:@"" inView:self.view];
    [[self.aircViewModel save:style] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UIView hideHudInView:self.view];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } error:^(NSError * _Nullable error) {
        @strongify(self)
        [UIView hideHudInView:self.view];
        [self.view showMessage:error.localizedDescription];
    }];
}

#pragma mark - getter setter
- (TBAircDeviceViewModel *)aircViewModel {
    if (!_aircViewModel) {
        _aircViewModel = [[TBAircDeviceViewModel alloc] initWithBrandId:97];
    }
    return _aircViewModel;
}

@end

@implementation TBAddAircRemoteViewController (AlertViewDelegate)

- (void)alertView:(AlertView *)alert didClicked:(NSInteger)index {
    self.tapBts = nil;
    if (index == 1) {
        [self saveRemote];
    } else {
        [self.remoteView showToolBar];
    }
}

@end
