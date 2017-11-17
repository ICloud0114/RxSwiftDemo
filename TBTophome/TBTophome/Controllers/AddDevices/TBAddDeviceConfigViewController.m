//
//  TBAddDeviceConfigViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/5.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddDeviceConfigViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

#import "UIViewController+NavigationItemTitle.h"
#import "TBTophome-Swift.h"

@interface TBAddDeviceConfigViewController () <VhAPConfigDelegate>

@property (weak, nonatomic) IBOutlet UIButton *nextBt;
@property (weak, nonatomic) IBOutlet UIImageView *realImageView;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@end

@interface TBAddDeviceConfigViewController (VhAPConfigDelegate)

@end

@implementation TBAddDeviceConfigViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)checkAppWiFi {
    self.nextBt.enabled = [[[HMDeviceConfig defaultConfig] currentConnectSSID] isEqualToString:@"HomeMate_AP"];
}

- (void)loadDeviceImage {
    self.realImageView.image = [UIImage imageNamed:self.deviceRealImage];
    self.stateImageView.animationImages = @[
                                            [UIImage imageNamed:self.deviceOnImage],
                                            [UIImage imageNamed:self.deviceOffImage]
                                            ];
    self.stateImageView.animationDuration = 0.5;
    self.stateImageView.animationRepeatCount = NSIntegerMax;
    [self.stateImageView startAnimating];
}

- (void)bindAction {
    @weakify(self)
    [[self.nextBt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [[HMDeviceConfig defaultConfig] connetToHost];
    }];
}

- (void)didBecomeActiveNotification:(NSNotification *)notification {
    [self checkAppWiFi];
    [self loadDeviceImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HMDeviceConfig defaultConfig].delegate = self;
    [HMDeviceConfig defaultConfig].autoRequestWifiList = NO;
    [self setTitle:[NSString stringWithFormat:@"添加%@", self.deviceName]];
    [self bindAction];
    [self checkAppWiFi];
    [self loadDeviceImage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    self.navBarBGAlpha = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.stateImageView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overwrite
- (BOOL)isInteractivePop {
    return NO;
}

- (NSString *)backTitle {
    return @"取消";
}

+ (instancetype)instanceAddDeviceConfigViewController:(NSDictionary *)param {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddDevices" bundle:nil];
    TBAddDeviceConfigViewController *config = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    config.deviceName = [param objectForKey:@"kDeviceName"];
    config.deviceRealImage = [param objectForKey:@"kDeviceRealImage"];
    config.deviceOnImage = [param objectForKey:@"kDeviceOnImage"];
    config.deviceOffImage = [param objectForKey:@"kDeviceOffImage"];
    return config;
}
@end

@implementation TBAddDeviceConfigViewController (VhAPConfigDelegate)

- (void)vhApConfigResult:(VhAPConfigResult)result {
    if (result == VhAPConfigResult_getDeviceInfoFinish) { //设备连接成功
        Class cl = NSClassFromString(@"TBAddDeviceWiFiViewController");
        UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceAddDeviceWiFiViewController")
                                        withObject: nil];
        [self showViewController:vc sender:nil];
    }
}

@end
