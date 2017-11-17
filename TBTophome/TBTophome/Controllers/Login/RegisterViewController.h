//
//  RegisterViewController.h
//  Template
//
//  Created by Topband on 2016/12/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"

@interface RegisterViewController : UIViewController

+ (instancetype)registerViewController;

@property (weak, nonatomic) IBOutlet TextField *phoneTextField;
@property (weak, nonatomic) IBOutlet TextField *codeTextField;
@property (weak, nonatomic) IBOutlet TextField *passwordTextField;
@property (weak, nonatomic) IBOutlet TextField *againPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIImageView *phoneLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *codeLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *againPasswordLeftView;
@property (weak, nonatomic) IBOutlet UIButton *passwordSecureButton;
@property (weak, nonatomic) IBOutlet UIButton *againPasswordSecureButton;

- (IBAction)codeAction:(id)sender;
- (IBAction)registerAction:(id)sender;

@end
