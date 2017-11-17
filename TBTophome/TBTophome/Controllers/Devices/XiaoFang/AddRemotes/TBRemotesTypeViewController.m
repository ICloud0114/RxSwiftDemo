//
//  TBRemotesTypeViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBRemotesTypeViewController.h"
#import "LFTableViewDataSource.h"
#import "TBRemoteTypeTableViewCell.h"

@interface TBRemotesTypeViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LFTableViewDataSource<NSDictionary *> *dataSource;

@end

@interface TBRemotesTypeViewController (Setup_UI)

- (void)setup_ui;

@end

@interface TBRemotesTypeViewController (UITableViewDelegate)

@end

@implementation TBRemotesTypeViewController

- (void)bindData {
    NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"RemoteType" ofType:@"plist"];
    NSArray *deviceTypeList = [[NSArray alloc] initWithContentsOfFile:dataSourcePath];
    self.dataSource.dataSource = deviceTypeList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindData];
    [self setup_ui];
    self.title = @"添加遥控器";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceRemotesTypeViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddRemotes" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
#pragma mark - getter setter
- (LFTableViewDataSource<NSDictionary *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[LFTableViewDataSource<NSDictionary *> alloc] init];
    }
    return _dataSource;
}

@end

@implementation TBRemotesTypeViewController (Setup_UI)

- (void)setup_ui {
    self.dataSource.cellIndentifier = @"add remote type cell identifier";
    self.tableView.dataSource = self.dataSource;
    self.dataSource.cellConfig = ^(__kindof UITableViewCell *cell, NSDictionary *dic, NSIndexPath *indexPath) {
        TBRemoteTypeTableViewCell *listCell = cell;
        listCell.typeName.text = [dic objectForKey:@"reomte_name"];
        listCell.typeIcon.image = [UIImage imageNamed:[dic objectForKey:@"remote_icon"]];
    };
}

@end

@implementation TBRemotesTypeViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.dataSource dataForIndexPath:indexPath];
    Class controllerClass = NSClassFromString([dic objectForKey:@"remote_controller"]);
    UIViewController *vc = [controllerClass performSelector:NSSelectorFromString(@"instanceRemoteViewControllerWithInfo:")
                                                 withObject:@{@"_TBAddRemoteViewClassKey": [dic objectForKey:@"remote_view"],
                                                              @"_TBAddRemotePanelTypeKey": [dic objectForKey:@"remote_type"],
                                                              @"_TBAddRemotePanelTitleKey": [dic objectForKey:@"reomte_name"]}];
    [self showViewController:vc sender:nil];
}

@end
