//
//  LoginViewController.m
//  Template
//
//  Created by Topband on 2016/12/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import "UIView+Hud.h"
#import "NSString+Regular.h"
#import "UIColor+Ex.h"

@interface LoginViewController ()

@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@interface LoginViewController (UI_Config)

- (void)setup_ui;

@end

@interface LoginViewController (TextFieldDelegate)

@end

@interface LoginViewController (Login)

- (void)loginWithAccount:(NSString *)account password:(NSString *)password;

@end

@implementation LoginViewController
- (void)dealloc {
    NSLog(@"登录销毁");
}
#pragma mark - action
- (IBAction)loginAction:(UIButton *)sender {
    [self loginWithAccount:self.accountTextField.text password:self.passwordTextField.text];
}

- (IBAction)registerAction:(UIButton *)sender {
    RegisterViewController *reg = [RegisterViewController registerViewController];
    [self.navigationController showViewController:reg sender:nil];
}

- (IBAction)forgotAction:(UIButton *)sender {
    ForgotPasswordViewController *forgot = [ForgotPasswordViewController forgotPasswordViewConttroller];
    [self.navigationController showViewController:forgot sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_ui];
    self.loginButton.enabled = NO;
    [self textField:self.accountTextField shouldChangeCharactersInRange:NSMakeRange(self.accountTextField.text.length - 1, 0) replacementString:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter setter
- (LoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

+ (instancetype)loginViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginTemplate" bundle:[NSBundle mainBundle]];
    return [sb instantiateViewControllerWithIdentifier:@"Login"];
}

@end
#pragma mark - 
#pragma mark - ui 配置
@implementation LoginViewController (UI_Config)

- (void)didResignFirstResponder {
    [self.view endEditing:YES];
    self.accountLeftView.highlighted = NO;
    self.passwordLeftView.highlighted = NO;
}

- (void)didReturn:(UITextField *)textField {
    if (textField == self.accountTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self didResignFirstResponder];
    }
}

- (void)passwordSecureAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTextField.secureTextEntry = !sender.selected;
}

- (void)touchSelf {
    [self.view endEditing:YES];
}

- (void)setup_ui {
    
    NSAttributedString *attr = [[NSAttributedString alloc]
                                initWithString:LFLocalizableString(@"Sign Up", nil)
                                attributes:@{
                                             NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#61c23e"],
                                             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                             NSFontAttributeName: [UIFont systemFontOfSize:14]
                                             }];
    [self.registerButton setAttributedTitle:attr forState:UIControlStateNormal];
    
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [self.accountTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.passwordTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.passwordSecureButton addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.accountLeftView != nil) {
        self.accountTextField.leftView = self.accountLeftView;
        self.accountTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.passwordLeftView != nil) {
        self.passwordTextField.leftView = self.passwordLeftView;
        self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.passwordSecureButton != nil) {
        self.passwordTextField.rightView = self.passwordSecureButton;
        self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSelf)];
    [self.view addGestureRecognizer:tap];
}

@end
#pragma mark - 
#pragma mark - text field deleate
@implementation LoginViewController (TextFieldDelegate)
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.accountLeftView.highlighted = textField == self.accountTextField;
    self.passwordLeftView.highlighted = textField == self.passwordTextField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL phone = [self.accountTextField.text isPhoneNumber];
    BOOL password = (self.passwordTextField.text.length >= 6 && self.passwordTextField.text.length <= 15);
    self.loginButton.enabled = (phone && password);
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *phoneString = nil;
    NSString *passwordString = nil;
    
    NSString * (^text)(NSString *, NSRange, NSString *) =
    ^NSString *(NSString *orgString, NSRange range, NSString *replacementString) {
        NSString *result = nil;
        if (range.length > 0) { //删除
            result = [orgString substringToIndex:range.location];
        } else { //输入
            result = [orgString stringByAppendingString:string];
        }
        return result;
    };
    
    if (textField == self.accountTextField) {
        phoneString = text(textField.text, range, string);
        passwordString = self.passwordTextField.text;
    } else {
        phoneString = self.accountTextField.text;
        passwordString = text(textField.text, range, string);
    }
    self.loginButton.enabled = [phoneString isPhoneNumber] && passwordString.length >= 6 && passwordString.length <= 15;
    return YES;
}

@end
#pragma mark - 
#pragma mark - 登录调用
@implementation LoginViewController (Login)
- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
    [self.view endEditing:YES];
    [UIView showHudWithLabel:LFLocalizableString(@"Login...", nil) inView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.loginViewModel loginWithAccount:account
                                 password:password
                               completion:^(NSError *error) {
                                   [UIView hideHudInView:weakSelf.view];
                                   if (error == nil) {
                                       [weakSelf.view showMessage:LFLocalizableString(@"Login success", nil)];
                                       if ([weakSelf.delegate respondsToSelector:@selector(didLoginSuccessInLoginViewController:)]) {
                                           [weakSelf.delegate didLoginSuccessInLoginViewController:weakSelf];
                                       }
                                   } else {
                                       [weakSelf.view showMessage:error.localizedDescription];
                                   }
                               }];
}
@end
