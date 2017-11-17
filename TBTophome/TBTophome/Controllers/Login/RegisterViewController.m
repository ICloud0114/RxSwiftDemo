//
//  RegisterViewController.m
//  Template
//
//  Created by Topband on 2016/12/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewModel.h"
#import "UIView+Hud.h"
#import "NSString+Regular.h"
#import "UIColor+Ex.h"

@interface RegisterViewController () //<UITextFieldDelegate>

@property (nonatomic, strong) RegisterViewModel *registerViewModel;

@end

@interface RegisterViewController (UI_Config)

- (void)setup_ui;

@end
//
//@interface RegisterViewController (TextFieldDelegate)
//
//@end

@interface RegisterViewController (Register)

- (void)registerWithAccount:(NSString *)account code:(NSString *)code password:(NSString *)password againPassword:(NSString *)againPassword;

@end

@implementation RegisterViewController

- (IBAction)codeAction:(id)sender {
    [self.view endEditing:YES];
    [UIView showHudWithLabel:nil inView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.registerViewModel getCodeWithPhone:self.phoneTextField.text completion:^(NSError *error) {
        [UIView hideHudInView:weakSelf.view];
        if (error) {
            [weakSelf.view showMessage:error.localizedDescription];
        }
    }];
}

- (IBAction)registerAction:(id)sender {
    [self registerWithAccount:self.phoneTextField.text code:self.codeTextField.text password:self.passwordTextField.text againPassword:self.againPasswordTextField.text];
}

- (void)bindState {
    RACSignal *phoneTextSignal = [[self.phoneTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                  map:^id _Nullable(NSString * _Nullable phone) {
                                      return @([phone isPhoneNumber]);
                                  }];
    RACSignal *codeTextSignal = [[self.codeTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                 map:^id _Nullable(NSString * _Nullable value) {
                                     return @([value isNumber]);
                                 }];
    RACSignal *pwdTextSignal = [[self.passwordTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                map:^id _Nullable(NSString * _Nullable value) {
                                    return @((value.length >= 6 && value.length <= 15));
                                }];
    RACSignal *aPwdTextSignal = [[self.againPasswordTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                 map:^id _Nullable(NSString * _Nullable value) {
                                     return @((value.length >= 6 && value.length <= 15));
                                 }];
    
    RAC(self.codeButton, enabled) = phoneTextSignal;
    RAC(self.registerButton, enabled) = [RACSignal combineLatest:@[phoneTextSignal, codeTextSignal, pwdTextSignal, aPwdTextSignal]
                                                        reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3, NSNumber *value4){
                                                            return @([value1 boolValue] && [value2 boolValue] && [value3 boolValue] && [value4 boolValue]);
                                                        }];
    
    //next串联
    [self.codeTextField rac_liftSelector:@selector(becomeFirstResponder)
                   withSignalOfArguments:[[[self.phoneTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                           takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    [self.passwordTextField rac_liftSelector:@selector(becomeFirstResponder)
                             withSignalOfArguments:[[[self.codeTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                                     takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    [self.againPasswordTextField rac_liftSelector:@selector(becomeFirstResponder)
                                  withSignalOfArguments:[[[self.passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                                          takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    [self.againPasswordTextField rac_liftSelector:@selector(resignFirstResponder)
                                  withSignalOfArguments:[[[self.againPasswordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                                          takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindState];
    self.title = LFLocalizableString(@"Register", nil);
    [self setup_ui];
//    [self textField:self.phoneTextField shouldChangeCharactersInRange:NSMakeRange(self.phoneTextField.text.length - 1, 0) replacementString:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
- (RegisterViewModel *)registerViewModel {
    if (!_registerViewModel) {
        _registerViewModel = [[RegisterViewModel alloc] init];
    }
    return _registerViewModel;
}

+ (instancetype)registerViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginTemplate" bundle:[NSBundle mainBundle]];
    return [sb instantiateViewControllerWithIdentifier:@"Register"];
}

@end

#pragma mark -
#pragma mark - UI_Config

@implementation RegisterViewController (UI_Config)

- (void)didResignFirstResponder {
    [self.view endEditing:YES];
    self.phoneLeftView.highlighted = NO;
    self.codeLeftView.highlighted = NO;
    self.passwordLeftView.highlighted = NO;
    self.againPasswordLeftView.highlighted = NO;
}

- (void)didReturn:(UITextField *)textField {
    if (textField == self.phoneTextField) {
        [self.codeTextField becomeFirstResponder];
    } else if (textField == self.codeTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.againPasswordTextField becomeFirstResponder];
    } else {
        [self didResignFirstResponder];
    }
}

- (void)passwordSecureAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.passwordSecureButton == sender) {
        self.passwordTextField.secureTextEntry = !sender.selected;
    } else {
        self.againPasswordTextField.secureTextEntry = !sender.selected;
    }
}

- (void)setup_ui {
//    self.phoneTextField.delegate = self;
//    self.codeTextField.delegate = self;
//    self.passwordTextField.delegate = self;
//    self.againPasswordTextField.delegate = self;
//    
//    [self.phoneTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.codeTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.passwordTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.againPasswordTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.codeButton setAttributedTitle:[[NSAttributedString alloc]
                                         initWithString:LFLocalizableString(@"Get verification code", nil)
                                         attributes:@{
                                                      NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#0095f3"],
                                                      NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                      NSFontAttributeName: [UIFont systemFontOfSize:12]
                                                      }]
                               forState:UIControlStateNormal];
    [self.codeButton setAttributedTitle:[[NSAttributedString alloc]
                                         initWithString:LFLocalizableString(@"Get verification code", nil)
                                         attributes:@{
                                                      NSForegroundColorAttributeName: [[UIColor colorWithHexString:@"#0095f3"] colorWithAlphaComponent:0.5],
                                                      NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                      NSFontAttributeName: [UIFont systemFontOfSize:12]
                                                      }]
                               forState:UIControlStateDisabled];
    
    [self.passwordSecureButton addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.againPasswordSecureButton addTarget:self action:@selector(passwordSecureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.phoneLeftView != nil) {
        self.phoneTextField.leftView = self.phoneLeftView;
        self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.codeLeftView != nil) {
        self.codeTextField.leftView = self.codeLeftView;
        self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.passwordLeftView != nil) {
        self.passwordTextField.leftView = self.passwordLeftView;
        self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.againPasswordLeftView != nil) {
        self.againPasswordTextField.leftView = self.againPasswordLeftView;
        self.againPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.passwordSecureButton != nil) {
        self.passwordTextField.rightView = self.passwordSecureButton;
        self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.againPasswordSecureButton != nil) {
        self.againPasswordTextField.rightView = self.againPasswordSecureButton;
        self.againPasswordTextField.rightViewMode = UITextFieldViewModeAlways;
    }
}

@end
//
//#pragma mark -
//#pragma mark - TextFieldDelegate
//@implementation RegisterViewController (TextFieldDelegate)
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.phoneLeftView.highlighted = textField == self.phoneTextField;
//    self.codeLeftView.highlighted = textField == self.codeTextField;
//    self.passwordLeftView.highlighted = textField == self.passwordTextField;
//    self.againPasswordLeftView.highlighted = textField == self.againPasswordTextField;
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString * (^text)(NSString *, NSRange, NSString *) =
//    ^NSString *(NSString *orgString, NSRange range, NSString *replacementString) {
//        NSString *result = nil;
//        if (range.length > 0) { //删除
//            result = [orgString substringToIndex:range.location];
//        } else { //输入
//            result = [orgString stringByAppendingString:string];
//        }
//        return [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    };
//    
//    NSString *phoneString = (textField == self.phoneTextField) ? text(textField.text, range, string) : self.phoneTextField.text;
//    NSString *codeString = (textField == self.codeTextField) ? text(textField.text, range, string) : self.codeTextField.text;
//    NSString *passwordString = (textField == self.passwordTextField) ? text(textField.text, range, string) : self.passwordTextField.text;
//    NSString *againPasswordString = (textField == self.againPasswordTextField) ? text(textField.text, range, string) : self.againPasswordTextField.text;
//    
//    BOOL phoneValid = [phoneString isPhoneNumber];
//    BOOL codeValid = [codeString isNumber];
//    BOOL pwdValid = passwordString.length >= 6 && passwordString.length <= 15;
//    BOOL againValid = againPasswordString.length >= 6 && againPasswordString.length <= 15;
//    self.registerButton.enabled = phoneValid && codeValid && pwdValid && againValid;
//    self.codeButton.enabled = phoneValid;
//    return YES;
//}
//@end

#pragma mark - 
#pragma mark - Register
@implementation RegisterViewController (Register)

- (void)registerWithAccount:(NSString *)account code:(NSString *)code password:(NSString *)password againPassword:(NSString *)againPassword {
    [self.view endEditing:YES];
    if (![password isEqualToString:againPassword]) {
        [self.view showMessage:@"密码不一致"];
        return;
    }
    [UIView showHudWithLabel:@"注册中..." inView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.registerViewModel registerWithPhone:self.phoneTextField.text
                                         code:self.codeTextField.text
                                     password:self.passwordTextField.text
                                   completion:^(NSError *error) {
                                       [UIView hideHudInView:weakSelf.view];
                                       if (error) {
                                           [weakSelf.view showMessage:error.localizedDescription];
                                       } else {
                                           [weakSelf.navigationController.view showMessage:@"注册成功"];
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }
                                   }];
}

@end
