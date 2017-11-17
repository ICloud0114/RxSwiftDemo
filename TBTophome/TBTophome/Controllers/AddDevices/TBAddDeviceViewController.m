//
//  TBAddDeviceViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/5.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddDeviceViewController.h"
#import "LFTableViewDataSource.h"
#import "UIViewController+NavigationItemTitle.h"
#import "TBAddDeviceListTableViewCell.h"

@interface TBAddDeviceViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LFTableViewDataSource<NSDictionary *> *dataSource;

@end

@interface TBAddDeviceViewController (Setup_UI)
- (void)setup_ui;
@end

@interface TBAddDeviceViewController (TableViewDelegate)

@end

@implementation TBAddDeviceViewController

- (void)bindData {
    NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"DeviceType" ofType:@"plist"];
    NSArray *deviceTypeList = [[NSArray alloc] initWithContentsOfFile:dataSourcePath];
    self.dataSource.dataSource = deviceTypeList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = LFLocalizableString(@"Add Device", nil);
    [self bindData];
    [self setup_ui];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:UIImage.navigationBarImage forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddDevices" bundle:nil];
    return [sb instantiateInitialViewController];
}

#pragma mark - getter setter
- (LFTableViewDataSource<NSDictionary *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[LFTableViewDataSource<NSDictionary *> alloc] init];
    }
    return _dataSource;
}

@end

@implementation TBAddDeviceViewController (Setup_UI)

- (void)setup_ui {
    self.dataSource.cellIndentifier = @"add device list cell identifier";
    self.tableView.dataSource = self.dataSource;
    self.dataSource.cellConfig = ^(__kindof UITableViewCell *cell, NSDictionary *dic, NSIndexPath *indexPath) {
        TBAddDeviceListTableViewCell *listCell = cell;
        listCell.name.text = [dic objectForKey:@"DeviceName"];
        listCell.deviceIcon.image = [UIImage imageNamed:[dic objectForKey:@"DeviceIcon"]];
    };
}


@end

@implementation TBAddDeviceViewController (TableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.dataSource dataForIndexPath:indexPath];
    Class cl = NSClassFromString(@"TBAddDeviceConfigViewController");
    UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceAddDeviceConfigViewController:")
                                    withObject: @{
                                                    @"kDeviceName": [dic objectForKey:@"DeviceName"],
                                                    @"kDeviceRealImage": [dic objectForKey:@"DeviceRealImage"],
                                                    @"kDeviceOnImage": [dic objectForKey:@"DeviceOnIcon"],
                                                    @"kDeviceOffImage": [dic objectForKey:@"DeviceOffIcon"]
                                                  }];
    [self showViewController:vc sender:nil];
}

@end
