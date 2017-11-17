//
//  TBDeviceViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBDeviceViewController.h"
#import "UIViewController+NavigationItemTitle.h"
#import "LFPopoverView.h"
#import "TBMoreTableViewCell.h"
#import "LFTableViewDataSource.h"
#import "AlertView.h"
#import "UIView+Hud.h"
#import "TBDeviceNavigationBar.h"
#import "TBTophome-Swift.h"

@interface TBDeviceViewController () <TBMoreTableViewCellDelegate, AlertViewDelegate>

@property (nonatomic, strong) LFPopoverView *popoverView;
@property (nonatomic, strong) UITableView *popoverTableView;
@property (nonatomic, strong) LFTableViewDataSource *moreDataSource;

@property (weak, nonatomic) TBDeviceNavigationBar *bar;

@end

@interface TBDeviceViewController (Overlay)

- (void)hideOverlay:(BOOL)flag;

@end

@interface TBDeviceViewController (Setup_UI)

- (void)setupUI;

@end

@interface TBDeviceViewController (TBMoreTableViewCellDelegate)

@end

@interface TBDeviceViewController (AlertViewDelegate)

@end

@implementation TBDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
//    self.bar.title.text = self.device.deviceName;
    self.title = self.device.deviceName;
    self.overlay.hidden = self.hideOverlay;
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

#pragma mark - getter setter
- (void)setHideOverlay:(BOOL)hideOverlay {
    if (_hideOverlay != hideOverlay) {
        _hideOverlay = hideOverlay;
        [self hideOverlay:_hideOverlay];
    }
}

+ (instancetype)deviceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DeviceList" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
@end

#pragma mark - Overlay
@implementation TBDeviceViewController (Overlay)

- (void)hideOverlay:(BOOL)flag {
    self.overlay.hidden = flag;
//    if (!flag) {
//        self.overlay.hidden = NO;
//    }
//    [UIView animateWithDuration:0.2 animations:^{
//        self.overlay.layer.opacity = flag ? 0.0 : 0.6;
//    } completion:^(BOOL finished) {
//        if (flag) {
//            self.overlay.hidden = YES;
//        }
//    }];
}

@end

#pragma mark - Setup_UI
@implementation TBDeviceViewController (Setup_UI)

- (void)more:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    self.moreDataSource = [[LFTableViewDataSource alloc] init];
    self.moreDataSource.dataSource = @[@1];
    self.moreDataSource.cellIndentifier = @"more cell identifier";
    self.moreDataSource.cellConfig = ^(__kindof UITableViewCell *cell, id data, NSIndexPath *indexPath) {
        TBMoreTableViewCell *moreCell = cell;
        moreCell.delegate = weakSelf;
    };

    self.popoverView = [LFPopoverView popoverView];
    self.popoverView.arrowSize = CGSizeMake(10, 5);
    self.popoverView.roundCorner = YES;
    self.popoverView.backgroundColor = [UIColor whiteColor];
    self.popoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 124, 44*2) style:UITableViewStylePlain];
    self.popoverTableView.scrollEnabled = NO;
    self.popoverTableView.rowHeight = 88.f;
    self.popoverTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.popoverTableView.backgroundColor = [UIColor clearColor];
    self.popoverTableView.dataSource = self.moreDataSource;
    
    UINib *nib = [UINib nibWithNibName:@"TBMoreTableViewCell" bundle:nil];
    [self.popoverTableView registerNib:nib forCellReuseIdentifier:@"more cell identifier"];
    UIView *view = sender;
    CGRect frame = [self.view convertRect:view.frame fromView:self.navigationController.navigationBar];
    CGPoint point = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));

    [self.popoverView showPopoverViewAtPoint:point withContentView:self.popoverTableView inView:self.navigationController.view];
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    UIButton *moreBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBt setImage:UIImage.moreIconImage forState:UIControlStateNormal];
    [moreBt sizeToFit];
    [moreBt addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreBt];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem, moreItem];
#if 0
    TBDeviceNavigationBar *bar = [TBDeviceNavigationBar deviceNavigationBar];
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bar];
    self.bar = bar;
    [bar addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:64]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bar)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [bar.more addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    [bar.back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
#endif
}

@end

@implementation TBDeviceViewController (TBMoreTableViewCellDelegate)

- (void)didModifyName {
    [self.popoverView dismiss];
    __weak typeof(self) weakSelf = self;
    self.popoverView.dismissHandle = ^{
        AlertView *alert = [AlertView alertView:TextFieldStyle];
        alert.title.text = LFLocalizableString(@"Setting Device Name", nil);
        alert.textField.placeholder = LFLocalizableString(@"Enter device name", nil);
        [alert.actions[0] setTitle:LFLocalizableString(@"Cancel", nil) forState:UIControlStateNormal];
        [alert.actions[1] setTitle:LFLocalizableString(@"Done", nil) forState:UIControlStateNormal];
        alert.delegate = weakSelf;
        [alert showInView:weakSelf.navigationController.view];
    };
}

- (void)didUpgrade {
    [self.popoverView dismiss];
}

@end

@implementation TBDeviceViewController (AlertViewDelegate)

- (void)alertView:(AlertView *)alert didClicked:(NSInteger)index {
    if (index == 1) {
        if (!(StringIsNotEmpty()(alert.textField.text))) {
            [self.view showMessage:@"名字不能为空!"];
            return;
        }
        __weak typeof(self) weakSelf = self;
        [[self.device modifyDeviceName:alert.textField.text] subscribeNext:^(id  _Nullable x) {
            [weakSelf.navigationController.view showMessage:@"修改成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } error:^(NSError * _Nullable error) {
            [weakSelf.navigationController.view showMessage:@"修改失败"];
        }];
    }
}

@end
