//
//  TBNavigationController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBNavigationController.h"
#import "TBTophome-Swift.h"

@interface TBNavigationController ()

@end


@implementation TBNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:UIImage.navigationBarImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pop {
    [self popViewControllerAnimated:YES];
}

- (void)loadViewControllerBackItem:(UIViewController *)viewController {
    UIBarButtonItem *backItem = nil;
    if ([viewController isKindOfClass:NSClassFromString(@"TBBaseViewController")] && [viewController performSelector:NSSelectorFromString(@"backTitle")] != nil) {
        backItem = [[UIBarButtonItem alloc] initWithTitle:[viewController performSelector:NSSelectorFromString(@"backTitle")]
                                                    style:UIBarButtonItemStylePlain
                                                   target:viewController
                                                   action:NSSelectorFromString(@"backAction")];
        [backItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    } else {
        backItem = [[UIBarButtonItem alloc]
                    initWithImage:UIImage.navigationBackNormalImage
                    style:UIBarButtonItemStylePlain
                    target:self
                    action:@selector(pop)];
    }
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -7;
    viewController.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.firstObject != viewController) {
        [self loadViewControllerBackItem:viewController];
        
        id<UIGestureRecognizerDelegate> target = navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:target
                                       action:NSSelectorFromString(@"handleNavigationTransition:")];
        if ([viewController isKindOfClass:NSClassFromString(@"TBBaseViewController")]) {
            NSMethodSignature *signature = [[viewController class] instanceMethodSignatureForSelector:NSSelectorFromString(@"isInteractivePop")];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = viewController;
            invocation.selector = NSSelectorFromString(@"isInteractivePop");
            [invocation invoke];
            BOOL isEnable = NO;
            [invocation getReturnValue:&isEnable];
            pan.enabled = isEnable;
        }
        [viewController.view addGestureRecognizer:pan];
    }
    if ([self.navigationDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.navigationDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.navigationDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.navigationDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}
@end
