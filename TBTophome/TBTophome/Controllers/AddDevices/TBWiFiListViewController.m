//
//  TBWiFiListViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/6.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBWiFiListViewController.h"
#import "LFTableViewDataSource.h"
#import "TBWiFiListTableViewCell.h"
#import "UIView+Hud.h"

@interface TBWiFiListViewController () <UITableViewDelegate, VhAPConfigDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LFTableViewDataSource<HMAPWifiInfo *> *dataSource;
@property (weak, nonatomic) NSIndexPath *selectedIndexPath;

@end

@interface TBWiFiListViewController (SetUp_UI)
- (void)setup_ui;
@end

@interface TBWiFiListViewController (TableViewDelegate)

@end

@interface TBWiFiListViewController (VhAPConfigDelegate)

@end

@implementation TBWiFiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    self.title = @"请选择WiFi";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:UIImage.navigationBarImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceWiFiListViewController:(id)delegate selectedSSID:(nullable NSString *)ssid{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddDevices" bundle:nil];
    TBWiFiListViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    vc.delegate = delegate;
    vc.selectedSSID = ssid;
    return vc;
}

#pragma mark - getter setter
- (LFTableViewDataSource<HMAPWifiInfo *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[LFTableViewDataSource<HMAPWifiInfo *> alloc] init];
    }
    return _dataSource;
}
@end

#pragma mark - SetUp_UI
@implementation TBWiFiListViewController (SetUp_UI)
- (void)refresh {
    [[HMDeviceConfig defaultConfig] requestWifiListTimeOut:10];
    [HMDeviceConfig defaultConfig].delegate = self;
    [UIView showHudWithLabel:@"刷新WiFi..." inView:self.navigationController.view];
}

- (void)setup_ui {
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"刷新"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(refresh)];
    [refresh setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem, refresh];
    
    __weak typeof(self) weakSelf = self;
    self.dataSource.cellIndentifier = @"wifi list cell identifier";
    self.dataSource.dataSource = [[HMDeviceConfig defaultConfig] getOrderWifiList];
    self.tableView.dataSource = self.dataSource;
    self.dataSource.cellConfig = ^(__kindof UITableViewCell *cell, HMAPWifiInfo *data, NSIndexPath *indexPath) {
        TBWiFiListTableViewCell *wifiListCell = cell;
        wifiListCell.ssid.text = data.ssid;
        BOOL isEnc = !([data.auth isEqualToString:@"OPEN"] && [data.enc isEqualToString:@"NONE"]);
        wifiListCell.enc.hidden = !isEnc;
        if (data.rssi < 30) {
            wifiListCell.rssi.image = [UIImage imageNamed:@"wifi_1.png"];
        } else if (data.rssi >=30 && data.rssi < 60) {
            wifiListCell.rssi.image = [UIImage imageNamed:@"wifi_2.png"];
        } else {
            wifiListCell.rssi.image = [UIImage imageNamed:@"wifi_3.png"];
        }
        
        wifiListCell.selectedIcon.hidden = ![data.ssid isEqualToString:weakSelf.selectedSSID];
        if (!wifiListCell.selectedIcon.hidden) {
            self.selectedIndexPath = indexPath;
        }
    };
}
@end

#pragma mark - TableViewDelegate
@implementation TBWiFiListViewController (TableViewDelegate)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TBWiFiListTableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
    cell.selectedIcon.hidden = YES;
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedIcon.hidden = NO;
    self.selectedIndexPath = indexPath;
    if ([self.delegate respondsToSelector:@selector(didSelectedWiFi:)]) {
        [self.delegate didSelectedWiFi:[self.dataSource dataForIndexPath:indexPath]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end

#pragma mark - VhAPConfigDelegate
@implementation TBWiFiListViewController (VhAPConfigDelegate)

- (void)vhApConfigResult:(VhAPConfigResult)result {
    if (result == VhAPConfigResult_getWifiListFinish) {
        [UIView hideHudInView:self.navigationController.view];
        NSArray *wifiList = [[HMDeviceConfig defaultConfig] getOrderWifiList];
        self.dataSource.dataSource = wifiList;
        [self.tableView reloadData];
    }
}

@end
