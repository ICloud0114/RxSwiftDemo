//
//  TBMainViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBMainViewController.h"

@interface TBMainViewController () <TBNavigationControllerDelegate, UITabBarDelegate>

@property (nonatomic, strong) TBTabBar *tbTabbar;

@end

@interface TBMainViewController (NavigationControllerDelegate)
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

@interface TBMainViewController (TabBarDelegate)
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end

@implementation TBMainViewController

- (void)initViewControllers {
    TBDeviceListViewController *deviceList = [TBDeviceListViewController instanceViewController];
//    TBMallViewController *mall = [TBMallViewController instanceViewController];
    TBPersonalCenterViewController *personalCenter = [TBPersonalCenterViewController instanceViewController];
//    TBModule4ViewController *module4 = [TBModule4ViewController instanceViewController];

    TBNavigationController *nc1 = [[TBNavigationController alloc] initWithRootViewController:deviceList];
//    TBNavigationController *nc2 = [[TBNavigationController alloc] initWithRootViewController:mall];
    TBNavigationController *nc3 = [[TBNavigationController alloc] initWithRootViewController:personalCenter];
//    TBNavigationController *nc4 = [[TBNavigationController alloc] initWithRootViewController:module4];
    
    nc1.navigationDelegate = self;
//    nc2.navigationDelegate = self;
    nc3.navigationDelegate = self;
//    nc4.navigationDelegate = self;
    
    self.viewControllers = @[nc1,/* nc2,*/ nc3/*, nc4*/];
}

- (void)initTabbar {
    self.tabBar.hidden = YES;
    
    self.tbTabbar = [TBTabBar tabbar];
    self.tbTabbar.delegate = self;
    self.tbTabbar.frame = self.tabBar.frame;
    self.tbTabbar.selectedItem = self.tbTabbar.items.firstObject;
    [self.view addSubview:_tbTabbar];
    [self.tabBar removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewControllers];
    [self initTabbar];
    Class cls = NSClassFromString(@"BookDetailComponent");
    [cls performSelector:NSSelectorFromString(@"detailViewController:") withObject:@{@"bookId":@1}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

#pragma mark - TBNavigationControllerDelegate
#pragma mark - 此分类用来在二级页面隐藏tabbar
@implementation TBMainViewController (NavigationControllerDelegate)
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *root = navigationController.viewControllers.firstObject;
    if (root != viewController) {
        navigationController.view.frame = self.view.bounds;
        [_tbTabbar removeFromSuperview];
        
        CGRect tabbarFrame = _tbTabbar.frame;
        tabbarFrame.origin.y = CGRectGetHeight(root.view.bounds) - CGRectGetHeight(tabbarFrame);
        _tbTabbar.frame = tabbarFrame;
        [root.view addSubview:_tbTabbar];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *root = navigationController.viewControllers.firstObject;
    if (root == viewController) {
        [_tbTabbar removeFromSuperview];
        _tbTabbar.frame = self.tabBar.frame;
        [self.view addSubview:_tbTabbar];
    }
}
@end

#pragma mark - UITabBarDelegate
#pragma mark - 此分类用来tabbar驱动tabbarController
@implementation TBMainViewController (TabBarDelegate)
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.selectedIndex = [tabBar.items indexOfObject:item];
}
@end
