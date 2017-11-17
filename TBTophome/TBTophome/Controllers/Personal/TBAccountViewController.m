//
//  TBAccountViewController.m
//  TBTophome
//
//  Created by Topband on 2017/1/21.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAccountViewController.h"
#import "UIViewController+NavigationItemTitle.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIImage+color.h"

@interface TBAccountViewController ()

@property (weak, nonatomic) IBOutlet UIButton *logout;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *nickname;

@property (weak, nonatomic) IBOutlet UIButton *nicknameBt;
@property (weak, nonatomic) IBOutlet UIButton *passwordBt;

@end

@interface TBAccountViewController (Setup_UI)

- (void)setup_ui;

@end

@implementation TBAccountViewController

- (void)bindAction {
    @weakify(self)
    [[[self.logout rac_signalForControlEvents:UIControlEventTouchUpInside]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        [userAccout() logoutAccount];
    }];
    
    [[[self.nicknameBt rac_signalForControlEvents:UIControlEventTouchUpInside]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         Class cl = NSClassFromString(@"TBNickNameViewController");
         UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceViewControllerWithNickName:")
                                         withObject:self.nickname.text];
         [self showViewController:vc sender:nil];
     }];
    
    [[[self.passwordBt rac_signalForControlEvents:UIControlEventTouchUpInside]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         Class cl = NSClassFromString(@"TBModifyPasswordViewController");
         UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceViewController")];
         [self showViewController:vc sender:nil];
     }];
}

- (void)loadAccountInfo {
    self.phone.text = userAccout().phone;
    self.nickname.text = userAccout().currentAccount.userName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    self.title = LFLocalizableString(@"My Account", nil);
    [self bindAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadAccountInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end

@implementation TBAccountViewController (Setup_UI)

- (void)setup_ui {
    UIImage *hight = [UIImage imageWithColor:[UIColor lightGrayColor]];
    [self.nicknameBt setBackgroundImage:hight forState:UIControlStateHighlighted];
    [self.passwordBt setBackgroundImage:hight forState:UIControlStateHighlighted];
}

@end
