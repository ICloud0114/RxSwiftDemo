//
//  ForgotPasswordViewController.m
//  Template
//
//  Created by Topband on 2016/12/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ForgotPasswordViewModel.h"
#import "UIView+Hud.h"
#import "NSString+Regular.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIColor+Ex.h"

@interface ForgotPasswordViewController () //<UITextFieldDelegate>

@property (nonatomic, strong) ForgotPasswordViewModel *fpViewModel;

@end

@interface ForgotPasswordViewController (UI_Config)

- (void)setup_ui;

@end

//@interface ForgotPasswordViewController (TextFieldDelegate)
//
//@end

@interface ForgotPasswordViewController (Forgot)

- (void)resetPasswordWithPhone:(NSString *)phone code:(NSString *)code password:(NSString *)password againPassword:(NSString *)againPassword;

- (void)codeWithPhone:(NSString *)phone;

@end

@implementation ForgotPasswordViewController

- (IBAction)codeAction:(id)sender {
    [self codeWithPhone:self.accountTextField.text];
}

- (IBAction)finishAction:(id)sender {
    [self resetPasswordWithPhone:self.accountTextField.text code:self.codeTextField.text password:self.newestPasswordTextField.text againPassword:self.againNewestPasswordTextField.text];
}

- (void)bindState {
    RACSignal *phoneTextSignal = [[self.accountTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                  map:^id _Nullable(NSString * _Nullable phone) {
                                      return @([phone isPhoneNumber]);
                                  }];
    RACSignal *codeTextSignal = [[self.codeTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                 map:^id _Nullable(NSString * _Nullable value) {
                                     return @([value isNumber]);
                                 }];
    RACSignal *pwdTextSignal = [[self.newestPasswordTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                map:^id _Nullable(NSString * _Nullable value) {
                                    return @((value.length >= 6 && value.length <= 15));
                                }];
    RACSignal *aPwdTextSignal = [[self.againNewestPasswordTextField.rac_textSignal takeUntil:[self rac_willDeallocSignal]]
                                 map:^id _Nullable(NSString * _Nullable value) {
                                     return @((value.length >= 6 && value.length <= 15));
                                 }];
    
    RAC(self.codeButton, enabled) = phoneTextSignal;
    RAC(self.finishButton, enabled) = [RACSignal combineLatest:@[phoneTextSignal, codeTextSignal, pwdTextSignal, aPwdTextSignal]
                                                        reduce:^id _Nullable(NSNumber *value1, NSNumber *value2, NSNumber *value3, NSNumber *value4){
                                                            return @([value1 boolValue] && [value2 boolValue] && [value3 boolValue] && [value4 boolValue]);
                                                        }];
    
    //next串联
    [self.codeTextField rac_liftSelector:@selector(becomeFirstResponder)
                   withSignalOfArguments:[[[self.accountTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                                                                                takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    [self.newestPasswordTextField rac_liftSelector:@selector(becomeFirstResponder)
                   withSignalOfArguments:[[[self.codeTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                           takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    [self.againNewestPasswordTextField rac_liftSelector:@selector(becomeFirstResponder)
                   withSignalOfArguments:[[[self.newestPasswordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                           takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
    [self.againNewestPasswordTextField rac_liftSelector:@selector(resignFirstResponder)
                                  withSignalOfArguments:[[[self.againNewestPasswordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
                                                          takeUntil:[self rac_willDeallocSignal]] map:^id _Nullable(__kindof UIControl * _Nullable value) {
        return nil;
    }]];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindState];
    self.title = LFLocalizableString(@"Forgot Password", nil);
    [self setup_ui];
//    [self textField:self.accountTextField shouldChangeCharactersInRange:NSMakeRange(self.accountTextField.text.length - 1, 0) replacementString:@""];
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
- (ForgotPasswordViewModel *)fpViewModel {
    if (!_fpViewModel) {
        _fpViewModel = [[ForgotPasswordViewModel alloc] init];
    }
    return _fpViewModel;
}

+ (instancetype)forgotPasswordViewConttroller {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginTemplate" bundle:[NSBundle mainBundle]];
    return [sb instantiateViewControllerWithIdentifier:@"ForgotPassword"];
}

@end

#pragma mark - 
#pragma mark - UI_Config

@implementation ForgotPasswordViewController (UI_Config)

//- (void)didResignFirstResponder {
//    [self.view endEditing:YES];
//    self.accountLeftView.highlighted = NO;
//    self.codeLeftView.highlighted = NO;
//    self.newestPasswordLeftView.highlighted = NO;
//    self.againNewestPasswordLeftView.highlighted = NO;
//}
//
//- (void)didReturn:(UITextField *)textField {
//    if (textField == self.accountTextField) {
//        [self.codeTextField becomeFirstResponder];
//    } else if (textField == self.codeTextField) {
//        [self.newestPasswordTextField becomeFirstResponder];
//    } else if (textField == self.newestPasswordTextField) {
//        [self.againNewestPasswordTextField becomeFirstResponder];
//    } else {
//        [self didResignFirstResponder];
//    }
//}

- (void)passwordSecureAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.passwordSecureButton == sender) {
        self.newestPasswordTextField.secureTextEntry = !sender.selected;
    } else {
        self.againNewestPasswordTextField.secureTextEntry = !sender.selected;
    }
}

- (void)setup_ui {
//    self.accountTextField.delegate = self;
//    self.codeTextField.delegate = self;
//    self.newestPasswordTextField.delegate = self;
//    self.againNewestPasswordTextField.delegate = self;
    
//    [self.accountTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.codeTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.newestPasswordTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.againNewestPasswordTextField addTarget:self action:@selector(didReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];

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
    
    if (self.accountLeftView != nil) {
        self.accountTextField.leftView = self.accountLeftView;
        self.accountTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.codeLeftView != nil) {
        self.codeTextField.leftView = self.codeLeftView;
        self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.newestPasswordLeftView != nil) {
        self.newestPasswordTextField.leftView = self.newestPasswordLeftView;
        self.newestPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.againNewestPasswordLeftView != nil) {
        self.againNewestPasswordTextField.leftView = self.againNewestPasswordLeftView;
        self.againNewestPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.passwordSecureButton != nil) {
        self.newestPasswordTextField.rightView = self.passwordSecureButton;
        self.newestPasswordTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if (self.againPasswordSecureButton != nil) {
        self.againNewestPasswordTextField.rightView = self.againPasswordSecureButton;
        self.againNewestPasswordTextField.rightViewMode = UITextFieldViewModeAlways;
    }
}

@end

//#pragma mark - 
//#pragma mark - TextFieldDelegate
//@implementation ForgotPasswordViewController (TextFieldDelegate)
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.accountLeftView.highlighted = textField == self.accountTextField;
//    self.codeLeftView.highlighted = textField == self.codeTextField;
//    self.newestPasswordLeftView.highlighted = textField == self.newestPasswordTextField;
//    self.againNewestPasswordLeftView.highlighted = textField == self.againNewestPasswordTextField;
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
//    NSString *phoneString = (textField == self.accountTextField) ? text(textField.text, range, string) : self.accountTextField.text;
//    NSString *codeString = (textField == self.codeTextField) ? text(textField.text, range, string) : self.codeTextField.text;
//    NSString *newestPasswordString = (textField == self.newestPasswordTextField) ? text(textField.text, range, string) : self.newestPasswordTextField.text;
//    NSString *againPasswordString = (textField == self.againNewestPasswordTextField) ? text(textField.text, range, string) : self.againNewestPasswordTextField.text;
//    
//    BOOL phoneValid = [phoneString isPhoneNumber];
//    BOOL codeValid = [codeString isNumber];
//    BOOL pwdValid = newestPasswordString.length >= 6 && newestPasswordString.length <= 15;
//    BOOL againValid = againPasswordString.length >= 6 && againPasswordString.length <= 15;
//    self.finishButton.enabled = phoneValid && codeValid && pwdValid && againValid;
//    self.codeButton.enabled = phoneValid;
//    return YES;
//}
//@end

@implementation ForgotPasswordViewController (Forgot)

- (void)resetPasswordWithPhone:(NSString *)phone code:(NSString *)code password:(NSString *)password againPassword:(NSString *)againPassword {
    [self.view endEditing:YES];
    
    if (![password isEqualToString:againPassword]) {
        [self.view showMessage:@"密码不一致"];
        return;
    }
    
    [UIView showHudWithLabel:nil inView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.fpViewModel resetPasswordWithPhone:phone
                                        code:code
                                    password:password
                            completionHandle:^(NSError *error) {
                                [UIView hideHudInView:weakSelf.view];
                                if (error) {
                                    [weakSelf.view showMessage:error.localizedDescription];
                                } else {
                                    [weakSelf.navigationController.view showMessage:@"重置成功!"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }];
}

- (void)codeWithPhone:(NSString *)phone {
    [self.view endEditing:YES];
    [UIView showHudWithLabel:nil inView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.fpViewModel getCodeWithPhone:phone completionHandle:^(NSError *error) {
        [UIView hideHudInView:weakSelf.view];
        if (error) {
            [weakSelf.view showMessage:error.localizedDescription];
        } else {
            [weakSelf.view showMessage:@"验证码发送成功,请查看手机!"];
        }
    }];
}


@end
