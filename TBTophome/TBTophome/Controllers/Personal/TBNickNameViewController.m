//
//  TBNickNameViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBNickNameViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TBSettingAccountViewModel.h"
#import "UIView+Hud.h"

@interface TBNickNameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (nonatomic, weak) UIButton *save;

@property (nonatomic, strong) TBSettingAccountViewModel *settingAccount;
@end

@interface TBNickNameViewController (Setup_UI)

- (void)setup_ui;

@end

@implementation TBNickNameViewController

- (void)bindState {
    RAC(self.save, enabled) = [[self.nickname.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(StringIsNotEmpty()(value) && value.length <= 16);
    }] takeUntil:[self rac_willDeallocSignal]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    [self bindState];
    self.nickname.text = self.curNickname;
    self.title = LFLocalizableString(@"Modify Nickname", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.nickname becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewControllerWithNickName:(NSString *)nickname {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
    TBNickNameViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    vc.curNickname = nickname;
    return vc;
}

#pragma mark - getter setter
- (TBSettingAccountViewModel *)settingAccount {
    if (!_settingAccount) {
        _settingAccount = [[TBSettingAccountViewModel alloc] init];
    }
    return _settingAccount;
}

@end

@implementation TBNickNameViewController (Setup_UI)

- (void)save:(UIButton *)sender {
    [self.view endEditing:YES];
    @weakify(self)
    [UIView showHudWithLabel:nil inView:self.navigationController.view];
    [[self.settingAccount modifyNickname:self.nickname.text] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UIView hideHudInView:self.navigationController.view];
        [self.navigationController.view showMessage:@"设置成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError * _Nullable error) {
        @strongify(self)
        [UIView hideHudInView:self.navigationController.view];
        [self.navigationController.view showMessage:@"设置失败!"];
    }];
}

- (void)setup_ui {
    UIButton *saveBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBt setTitle:LFLocalizableString(@"Done", nil) forState:UIControlStateNormal];
    [saveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBt setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    [saveBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [saveBt sizeToFit];
    [saveBt addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveBt];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem, save];
    self.save = save;
}

@end
