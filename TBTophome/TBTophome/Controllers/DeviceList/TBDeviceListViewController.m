//
//  TBDeviceListViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBDeviceListViewController.h"
#import "DeviceListViewModel.h"
#import "LFTableViewDataSource.h"
#import "TBDeviceListTableViewCell.h"
#import "UIViewController+NavigationItemTitle.h"
#import "TBDeviceViewController.h"
#import "AlertView.h"
#import "UIView+Hud.h"

@interface TBDeviceListViewController () <UITableViewDelegate, AlertViewDelegate>

@property (nonatomic, strong) DeviceListViewModel *deviceListViewModel;
@property (nonatomic, strong) LFTableViewDataSource<TBDeviceViewModel *> *dataSource;
@property (nonatomic, weak) IBOutlet UITableView *deviceList;

@end

@interface TBDeviceListViewController (UI_Config)
- (void)setup_ui;
@end

@interface TBDeviceListViewController (AlertViewDelegate)

@end

@interface TBDeviceListViewController (TableViewDelegate)

@end

@interface TBDeviceListViewController (AddDevice)

- (void)addDevice;

@end

@implementation TBDeviceListViewController
- (void)bind {
    @weakify(self)
    [[[RACObserve(self.deviceListViewModel, deviceList) filter:ArrayIsNotEmpty()]
     deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray<HMDevice *> * _Nullable deviceList) {
        @strongify(self)
        self.dataSource.dataSource = deviceList;
        [self.deviceList reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    [self bind];
    self.title = LFLocalizableString(@"Devices", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:UIImage.navigationBarImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.deviceListViewModel.deviceListCommand execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DeviceList" bundle:nil];
    return [sb instantiateInitialViewController];
}

#pragma mark - getter setter
- (DeviceListViewModel *)deviceListViewModel {
    if (!_deviceListViewModel) {
        _deviceListViewModel = [[DeviceListViewModel alloc] init];
    }
    return _deviceListViewModel;
}

- (LFTableViewDataSource<TBDeviceViewModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[LFTableViewDataSource<TBDeviceViewModel *> alloc] init];
    }
    return _dataSource;
}
@end

#pragma mark - UI_Config
@implementation TBDeviceListViewController (UI_Config)
- (void)setup_ui {
    self.dataSource.cellIndentifier = @"device list cell identifier";
    self.deviceList.dataSource = self.dataSource;
    self.dataSource.cellConfig = ^(__kindof UITableViewCell *cell, TBDeviceViewModel *device, NSIndexPath *indexPath) {
        TBDeviceListTableViewCell *deviceListCell = cell;
        deviceListCell.name.text = device.deviceName;
        deviceListCell.deviceIcon.image =  device.online ? device.deviceIcon : device.deviceOffIcon;
    };
    self.dataSource.canEditRow = ^BOOL(NSIndexPath *indexPath) {
        return YES;
    };
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]
                                initWithImage:UIImage.navigationAddNormalImage
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(addDevice)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem, addItem];
}
@end

#pragma mark - AlertViewDelegate
@implementation TBDeviceListViewController (AlertViewDelegate)
- (void)alertView:(AlertView *)alert didClicked:(NSInteger)index {
    [self.deviceList setEditing:NO animated:YES];
    if (index == 1) {
        @weakify(self)
        [[self.deviceListViewModel unbindDeviceAtIndex:alert.tag - 1]
         subscribeNext:^(id  _Nullable x) {
            TBLog(@"%@", x)
             @strongify(self)
             [self.deviceListViewModel.deviceListCommand execute:nil];
        }];
    }
}
@end

#pragma mark - TableViewDelegate
@implementation TBDeviceListViewController (TableViewDelegate)
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        AlertView *alert = [AlertView alertView:MessageStyle];
        alert.title.text = @"删除设备";
        alert.message.text = @"删除设备后将无法用手机控制，确定删除吗？";
        alert.delegate = self;
        alert.tag = indexPath.row + 1;
        [alert showInView:self.tabBarController.view];
    }];
    return @[action];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TBDeviceViewModel *deviceViewModel = [self.dataSource dataForIndexPath:indexPath];
    if (!deviceViewModel.online) {
        [self.view showMessage:LFLocalizableString(@"Device offline", nil)];
        return;
    }
    TBDeviceViewController *vc = [[deviceViewModel viewControllerClass] performSelector:NSSelectorFromString(@"deviceViewController") withObject: nil];
    vc.device = deviceViewModel;
    [self showViewController:vc sender:nil];
}

@end

#pragma mark - AddDevice
@implementation TBDeviceListViewController (AddDevice)
- (void)addDevice {
    Class cl = NSClassFromString(@"TBAddDeviceViewController");
    UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceViewController") withObject: nil];
    [self showViewController:vc sender:nil];
}

@end
