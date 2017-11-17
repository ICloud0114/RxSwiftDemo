//
//  TBRootViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBRootViewController.h"

@interface TBRootViewController () <LoginViewControllerDelegate, AccountProtocol> {
    __weak TBMainViewController *_main;
}

@end

@implementation TBRootViewController

- (void)transitionFromViewController:(UIViewController * __nullable)fViewController
                    toViewController:(UIViewController *__nonnull)tViewController {
    UIView *view = tViewController.view;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:tViewController];
    [self.view addSubview:view];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(view)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(view)]];
    [view layoutIfNeeded];
    if (fViewController == nil) {
        [tViewController didMoveToParentViewController:self];
    } else {
        [fViewController willMoveToParentViewController:nil];
        view.transform = CGAffineTransformMakeTranslation(self.view.width, 0);
        [UIView animateWithDuration:0.25f animations:^{
            view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [tViewController didMoveToParentViewController:self];
            [fViewController.view removeFromSuperview];
            [fViewController removeFromParentViewController];
        }];
    }
}


- (void)setup {
    LoginViewController *login = [LoginViewController loginViewController];
    login.delegate = self;
    TBNavigationController *nc = [[TBNavigationController alloc] initWithRootViewController:login];
//    nc.navigationBar.translucent = YES;
//    nc.navigationBar.barTintColor = [UIColor colorWithRed:15.f / 255.f green:211.f / 255.f blue:172.f / 255.f alpha:1.f];
    [self transitionFromViewController:nil toViewController:nc];
    
    userAccout().delegate = self;
}

- (void)bindAction {
    //退出信号
//    [[userAccout() logoutSignal] subscribeNext:^(id  _Nullable x) {
//        LoginViewController *login = [LoginViewController loginViewController];
//        login.delegate = self;
//        TBNavigationController *nc = [[TBNavigationController alloc] initWithRootViewController:login];
//        [self transitionFromViewController:_main toViewController:nc];
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
//    [self bindAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutAccount {
    LoginViewController *login = [LoginViewController loginViewController];
    login.delegate = self;
    TBNavigationController *nc = [[TBNavigationController alloc] initWithRootViewController:login];
    [self transitionFromViewController:_main toViewController:nc];
}

#pragma mark - LoginViewControllerDelegate
- (void)didLoginSuccessInLoginViewController:(LoginViewController *)loginViewController {
    dispatch_main_delay(1, ^{
        TBMainViewController *main = [[TBMainViewController alloc] init];
        _main = main;
        [self transitionFromViewController:loginViewController.navigationController toViewController:main];
    });
}

@end
