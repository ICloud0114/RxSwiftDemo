//
//  LoginViewController.h
//  Template
//
//  Created by Topband on 2016/12/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"

NS_ASSUME_NONNULL_BEGIN
@protocol LoginViewControllerDelegate;
@interface LoginViewController : UIViewController <UITextFieldDelegate>

+ (instancetype)loginViewController;

@property (nullable, nonatomic, weak) id<LoginViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet TextField *accountTextField;
@property (weak, nonatomic) IBOutlet TextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotButton;

@property (weak, nonatomic) IBOutlet UIImageView *accountLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordLeftView;
@property (weak, nonatomic) IBOutlet UIButton *passwordSecureButton;

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)registerAction:(UIButton *)sender;
- (IBAction)forgotAction:(UIButton *)sender;
@end

@protocol LoginViewControllerDelegate <NSObject>

- (void)didLoginSuccessInLoginViewController:(LoginViewController *)loginViewController;

@end
NS_ASSUME_NONNULL_END
