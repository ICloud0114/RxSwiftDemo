//
//  TBModule4ViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBModule4ViewController.h"
#import "UIViewController+NavigationItemTitle.h"

@interface TBModule4ViewController ()

@end

@implementation TBModule4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"个人中心"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Module4" bundle:nil];
    return [sb instantiateInitialViewController];
}

@end
