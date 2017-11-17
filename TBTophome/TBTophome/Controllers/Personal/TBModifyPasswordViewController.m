//
//  TBModifyPasswordViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBModifyPasswordViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIView+Hud.h"
#import "TBSettingAccountViewModel.h"
@interface TBModifyPasswordViewController ()

@property (weak, nonatomic) UIButton *save;
@property (nonatomic, strong) TBSettingAccountViewModel *settingAccount;

@end

@interface TBModifyPasswordViewController (Setup_UI)
- (void)setup_ui;
@end

@implementation TBModifyPasswordViewController

- (void)bindState {
    RACSignal *oldPwdTextSignal = [[self.oldPassword.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                map:^id _Nullable(NSString * _Nullable value) {
                                    return @((value.length >= 6 && value.length <= 15));
                                }];
    RACSignal *nPwdTextSignal = [[self.nPassword.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                 map:^id _Nullable(NSString * _Nullable value) {
                                     return @((value.length >= 6 && value.length <= 15));
                                 }];
    RACSignal *againNewPwdTextSignal = [[self.againNewPassword.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                 map:^id _Nullable(NSString * _Nullable value) {
                                     return @((value.length >= 6 && value.length <= 15));
                                 }];
    RAC(self.save, enabled) = [[RACSignal combineLatest:@[oldPwdTextSignal, nPwdTextSignal, againNewPwdTextSignal]
                                                        reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3){
                                                            return @([value1 boolValue] && [value2 boolValue] && [value3 boolValue]);
                                                        }] takeUntil:[self rac_willDeallocSignal]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    [self bindState];
    self.title = LFLocalizableString(@"Modify Password", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

#pragma mark - getter setter
- (TBSettingAccountViewModel *)settingAccount {
    if (!_settingAccount) {
        _settingAccount = [[TBSettingAccountViewModel alloc] init];
    }
    return _settingAccount;
}

@end

@implementation TBModifyPasswordViewController (Setup_UI)

- (void)save:(id)sender {
    [self.view endEditing:YES];
    if (![self.nPassword.text isEqualToString:self.againNewPassword.text]) {
        [self.view showMessage:@"两次输入的新密码不一致"];
        return;
    }
    [[self.settingAccount modifyPasswordWithOldPwd:self.oldPassword.text newPassword:self.nPassword.text]
     subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    }];
}

- (void)passwordSecureAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.oldPasswordSecBt == sender) {
        self.oldPassword.secureTextEntry = !sender.selected;
    } else if (self.nPasswordSecBt == sender) {
        self.nPassword.secureTextEntry = !sender.selected;
    } else {
        self.againNewPassword.secureTextEntry = !sender.selected;
    }
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
    
    [self.oldPasswordSecBt addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nPasswordSecBt addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.againNewPasswordSecBt addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];

    if (self.oldPasswordSecBt != nil) {
        self.oldPassword.rightView = self.oldPasswordSecBt;
        self.oldPassword.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.nPasswordSecBt != nil) {
        self.nPassword.rightView = self.nPasswordSecBt;
        self.nPassword.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.againNewPasswordSecBt != nil) {
        self.againNewPassword.rightView = self.againNewPasswordSecBt;
        self.againNewPassword.rightViewMode = UITextFieldViewModeAlways;
    }
}

@end
