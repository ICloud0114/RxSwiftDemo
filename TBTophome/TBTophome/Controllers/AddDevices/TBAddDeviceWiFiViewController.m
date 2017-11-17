//
//  TBAddDeviceWiFiViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/5.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddDeviceWiFiViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

#import "UIViewController+NavigationItemTitle.h"

#import "TBTophome-Swift.h"
@interface TBAddDeviceWiFiViewController () <VhAPConfigDelegate>

@property (nonatomic, weak) IBOutlet UIButton *ssidBt;
@property (nonatomic, weak) IBOutlet UILabel *ssid;
@property (nonatomic, weak) IBOutlet UIImageView *ssidRow;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *searchWiFiIndicator;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *passwordSecureBt;
@property (nonatomic, weak) IBOutlet UIButton *config;

@property (nonatomic, strong) HMAPWifiInfo *currentWifi;
@end

@interface TBAddDeviceWiFiViewController (UI_Config)
- (void)passwordSecureAction:(UIButton *)sender;
- (void)setup_ui;
@end

@interface TBAddDeviceWiFiViewController (WifiSelected)
- (void)didSelectedWiFi:(HMAPWifiInfo *)wifi;
@end

@interface TBAddDeviceWiFiViewController (VhAPConfigDelegate)

@end

@implementation TBAddDeviceWiFiViewController

- (void)bindAction {
    @weakify(self)
    [[self.config rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [[HMDeviceConfig defaultConfig] settingDevice:self.ssid.text pwd:self.password.text timeOut:10];
        Class cl = NSClassFromString(@"TBAddDeviceStateViewController");
        UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceDeviceStateViewController") withObject: self];
        [self showViewController:vc sender:nil];
    }];
    
    [[self.ssidBt rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        Class cl = NSClassFromString(@"TBWiFiListViewController");
        UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceWiFiListViewController:selectedSSID:") withObject: self withObject:self.currentWifi.ssid];
        [self showViewController:vc sender:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"选择设备工作WiFi"];
    [self setup_ui];
    [self bindAction];
    
    self.currentWifi = nil;
    
    self.ssidRow.hidden = YES;
    [self.searchWiFiIndicator startAnimating];
    self.ssidBt.enabled = NO;
    [[HMDeviceConfig defaultConfig] requestWifiListTimeOut:10];
    [HMDeviceConfig defaultConfig].delegate = self;
    
    self.navBarBGAlpha = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)didEndEdit:(UITextField *)sender {
    [self.view endEditing:YES];
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
        [[HMDeviceConfig defaultConfig] disConnect];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - getter setter
- (void)setCurrentWifi:(HMAPWifiInfo *)currentWifi {
    _currentWifi = currentWifi;
    if (_currentWifi) {
        self.ssid.text = currentWifi.ssid;
    }
    self.config.enabled = currentWifi != nil;
}

+ (instancetype)instanceAddDeviceWiFiViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddDevices" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end

#pragma mark - WifiSelected
@implementation TBAddDeviceWiFiViewController (WifiSelected)
- (void)didSelectedWiFi:(HMAPWifiInfo *)wifi {
    self.currentWifi = wifi;
}
@end

#pragma mark - UI_Config
@implementation TBAddDeviceWiFiViewController (UI_Config)
- (void)passwordSecureAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !sender.selected;
}

- (void)setup_ui {
    [self.passwordSecureBt addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.password.rightView = self.passwordSecureBt;
    self.password.rightViewMode = UITextFieldViewModeAlways;
}
@end

#pragma mark - VhAPConfigDelegate
@implementation TBAddDeviceWiFiViewController (VhAPConfigDelegate)

- (void)vhApConfigResult:(VhAPConfigResult)result {
    if (result == VhAPConfigResult_getWifiListFinish) {
        [self.searchWiFiIndicator stopAnimating];
        self.ssidRow.hidden = NO;
        self.ssidBt.enabled = YES;
        NSArray *wifiList = [[HMDeviceConfig defaultConfig] getOrderWifiList];
        HMAPWifiInfo *wifi = [wifiList firstObject];
        self.currentWifi = wifi;
    }
}

@end
