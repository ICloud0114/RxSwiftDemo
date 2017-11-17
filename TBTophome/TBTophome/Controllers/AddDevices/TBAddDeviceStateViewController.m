//
//  TBAddDeviceStateViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/9.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddDeviceStateViewController.h"
#import "TBConfigDeviceProgressView.h"
#import "UIViewController+NavigationItemTitle.h"
#import "AlertView.h"
#import "TBTophome-Swift.h"

#define kApConfigTimeSecond (100)

@interface TBAddDeviceStateViewController () <AlertViewDelegate, VhAPConfigDelegate>

@property (weak, nonatomic) IBOutlet TBConfigDeviceProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UILabel *loading;
@property (weak, nonatomic) IBOutlet UIImageView *failedIcon;
@property (weak, nonatomic) IBOutlet UIButton *finishBt;
@property (weak, nonatomic) IBOutlet UILabel *warningInfo1;
@property (weak, nonatomic) IBOutlet UILabel *warningInfo2;

@property (atomic, assign) NSInteger configSecond;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isStartBind; //标识是否开始绑定

@end

@interface TBAddDeviceStateViewController (AlertViewDelegate)

- (void)alertView:(AlertView *)alert didClicked:(NSInteger)index;

@end

@interface TBAddDeviceStateViewController (VhAPConfigDelegate)

@end

@implementation TBAddDeviceStateViewController

- (void)configSuccess {
    [[HMDeviceConfig defaultConfig] stopBindDevice];
    [self.timer invalidate];
    [self.progressView setProgress:1 animated:YES];
    [self.finishBt setTitle:@"完成" forState:UIControlStateNormal];
    Self_Property_Assign(progress.text, @"100%")
    Self_Property_Assign(loading.text, @"配置成功")
    Self_Property_Assign(finishBt.hidden, NO)
    Self_Property_Assign(finishBt.tag, 1)
}

- (void)configFailed {
    [[HMDeviceConfig defaultConfig] stopBindDevice];
    [self.timer invalidate];
    [self.progressView setProgress:0 animated:NO];
    [self.finishBt setTitle:@"确定" forState:UIControlStateNormal];
    Self_Property_Assign(timer, nil)
    Self_Property_Assign(loading.text, @"配置失败...")
    Self_Property_Assign(finishBt.tag, 2)
    Self_Property_Assign(finishBt.hidden, NO)
    Self_Property_Assign(progress.text, @"")
    Self_Property_Assign(progressView.hidden, YES)
    Self_Property_Assign(failedIcon.hidden, NO)
    Self_Property_Assign(warningInfo1.hidden, NO)
    Self_Property_Assign(warningInfo2.hidden, NO)
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HMDeviceConfig defaultConfig].delegate = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self setTitle:@"建立连接"];
    Self_Property_Assign(loading.text, @"正在连接,请稍后...")
    Self_Property_Assign(finishBt.hidden, YES)
    Self_Property_Assign(failedIcon.hidden, YES)
    Self_Property_Assign(warningInfo1.hidden, YES)
    Self_Property_Assign(warningInfo2.hidden, YES)
    
    self.navBarBGAlpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)finishAction:(UIButton *)sender {
    if (sender.tag == 1) {
        AlertView *alert = [AlertView alertView:TextFieldStyle];
        alert.delegate = self;
        [alert showInView:self.navigationController.view];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - timer
- (void)timerAction:(NSTimer *)timer {
    if (self.configSecond > kApConfigTimeSecond) { //结束
        [timer invalidate];
        [self configFailed];
        return;
    }
    CGFloat progress = (CGFloat)(self.configSecond) / kApConfigTimeSecond;
    self.progress.text = [NSString stringWithFormat:@"%02d%%", (int)(progress * 100)];
    [self.progressView setProgress:progress animated:YES];
    self.configSecond += 1;
    
    //只有当前有网路的时候，才可以去绑定账号
    if (self.isStartBind && isNetworkAvailable()) {
        self.isStartBind = NO;
        [[HMDeviceConfig defaultConfig] startBindDevice];
        self.loading.text = @"正在绑定账号,请稍后...";
    }
}

#pragma mark - overwrite
- (BOOL)isInteractivePop {
    return NO;
}

- (NSString *)backTitle {
    return @"取消";
}

- (void)backAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"确定退出配置?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[HMDeviceConfig defaultConfig] stopBindDevice];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


+ (instancetype)instanceDeviceStateViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddDevices" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end

@implementation TBAddDeviceStateViewController (AlertViewDelegate)
- (void)alertView:(AlertView *)alert didClicked:(NSInteger)index {
    if (index == 1) {
        TBLog(@"修改设备名字: %@", alert.textField.text)
        [HMDeviceConfig defaultConfig].vhDevice.deviceName = alert.textField.text;
        [[HMDeviceConfig defaultConfig] modifyDeviceName:alert.textField.text];
    }
}
@end

@implementation TBAddDeviceStateViewController (VhAPConfigDelegate)

- (void)vhApConfigResult:(VhAPConfigResult)result {
    if (result == VhAPConfigResult_bindDeviceOffLine) { //设备配置成功
        self.isStartBind = YES;
    } else if (result == VhAPConfigResult_setDeviceFinish) {
        self.isStartBind = NO;
    } else if (result == VhAPConfigResult_bindSuccess) { //绑定成功
        [self configSuccess];
    } else if (result == VhAPConfigResult_bindFail) {
        [self configFailed];
    } else if (result == VhAPConfigResult_disconnectSocket) {
        self.isStartBind = YES;
    } else if (result == VhAPConfigResult_modifyNameSuccess) { //修改名字成功
        TBLog(@"修改名称成功")
        //更新数据库
        [[HMDeviceConfig defaultConfig].vhDevice insertObject];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
