//
//  TBAddRemoteViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddRemoteViewController.h"
#import "TBDeviceNavigationBar.h"
#import "UIImage+color.h"
#import "TBTophome-Swift.h"

NSString *const TBAddRemoteViewClassKey = @"_TBAddRemoteViewClassKey";
NSString *const TBAddRemotePanelTypeKey = @"_TBAddRemotePanelTypeKey";
NSString *const TBAddRemotePanelTitleKey = @"_TBAddRemotePanelTitleKey";

@interface TBAddRemoteViewController () <TBRemoteToolBarView>
@property (weak, nonatomic) TBDeviceNavigationBar *bar;
@end

@interface TBAddRemoteViewController (Setup_UI)
- (void)setup_ui;
@end

@interface TBAddRemoteViewController (TBRemoteToolBarView)
- (void)didShow;
@end

@implementation TBAddRemoteViewController

- (NSInteger)ridCount { return 0; }
- (NSInteger)currentRidIndex { return 0; }
- (void)getAricModeWithRidIndex:(NSInteger)index {}
- (void)saveRemote {}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
//    self.bar.title.text = self.remoteTitle;
    self.title = self.remoteTitle;
    self.navBarBGAlpha = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overwrite
- (NSString *)backTitle {
    return @"取消";
}
//
//+ (instancetype)instanceRemoteViewControllerWithViewClass:(Class)viewClass remoteTitle:(nonnull NSString *)title {
//    TBAddRemoteViewController *remoteViewController = [[[self class] alloc] init];
//    remoteViewController.viewClass = viewClass;
//    remoteViewController.remoteTitle = title;
//    return remoteViewController;
//}

+ (instancetype)instanceRemoteViewControllerWithInfo:(NSDictionary *)info {
    TBAddRemoteViewController *remoteViewController = [[[self class] alloc] init];
    remoteViewController.viewClass = NSClassFromString([info objectForKey:TBAddRemoteViewClassKey]);
    remoteViewController.type = [[info objectForKey:TBAddRemotePanelTypeKey] integerValue];
    remoteViewController.remoteTitle = [info objectForKey:TBAddRemotePanelTitleKey];
    return remoteViewController;
}

@end

@implementation TBAddRemoteViewController (Setup_UI)
- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftAction {
    UIImage *image = [UIImage imageFromView:self.remoteView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view insertSubview:imageView belowSubview:self.bar];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(self.view.bounds), 0);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [self getAricModeWithRidIndex:[self currentRidIndex] - 1];
        [self didShow];
    }];
}

- (void)rightAction {
    UIImage *image = [UIImage imageFromView:self.remoteView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view insertSubview:imageView belowSubview:self.bar];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds), 0);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [self getAricModeWithRidIndex:[self currentRidIndex] + 1];
        [self didShow];
    }];
}

- (void)okAction {
    [self saveRemote];
}

- (void)setup_ui {
    UIView *remoteView = [self.viewClass RemoteViewPanelType:self.type];
    remoteView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:remoteView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[remoteView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(remoteView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[remoteView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(remoteView)]];
    self.remoteView = remoteView;
    self.remoteView.toolBarDelegate = self;
    [self.remoteView.leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.remoteView.okBt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];

//    TBDeviceNavigationBar *bar = [TBDeviceNavigationBar deviceNavigationBar];
//    bar.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:bar];
//    self.bar = bar;
    
    TBAddRemotesTipView *tipView = [TBAddRemotesTipView instanceAddRemotesTipView];
    tipView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tipView];
    self.tipView = tipView;
    
    [tipView addConstraint:[NSLayoutConstraint constraintWithItem:tipView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
//    [bar addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:64]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tipView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tipView)]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tipView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
    
//    [bar.back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [bar.back setImage:nil forState:UIControlStateNormal];
//    [bar.back setTitle:@"取消" forState:UIControlStateNormal];
//    [bar.more removeFromSuperview];
}
@end

@implementation TBAddRemoteViewController (TBRemoteToolBarView)

- (void)didShow {
    if ([self currentRidIndex] == 0) {
        self.remoteView.leftTitle.text = nil;
        self.remoteView.leftBt.hidden = YES;
    }
    if ([self currentRidIndex] == [self ridCount] - 1) {
        self.remoteView.rightTitle.text = nil;
        self.remoteView.rightBt.hidden = YES;
    }
    if ([self currentRidIndex] > 0) {
        self.remoteView.leftTitle.text = [NSString stringWithFormat:@"第%@个", @([self currentRidIndex])];
        self.remoteView.leftBt.hidden = NO;
    }
    
    if ([self currentRidIndex] < ([self ridCount] - 1)) {
        self.remoteView.rightTitle.text = [NSString stringWithFormat:@"第%@个", @([self currentRidIndex] + 2)];
        self.remoteView.rightBt.hidden = NO;
    }
}

@end
