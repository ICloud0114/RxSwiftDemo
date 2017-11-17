//
//  TBBaseViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBBaseViewController.h"

@interface TBBaseViewController ()

@end

@implementation TBBaseViewController

- (BOOL)isInteractivePop {
    return YES;
}

- (NSString *)backTitle {
    return nil;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter setter
- (TBNavigationController *)tbNavigationController {
    if ([self.navigationController isKindOfClass:[TBNavigationController class]]) {
        return (TBNavigationController *)self.navigationController;
    }
    return nil;
}
@end
