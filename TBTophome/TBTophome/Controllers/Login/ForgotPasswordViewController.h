//
//  ForgotPasswordViewController.h
//  Template
//
//  Created by Topband on 2016/12/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"

@interface ForgotPasswordViewController : UIViewController

+ (instancetype)forgotPasswordViewConttroller;

@property (weak, nonatomic) IBOutlet TextField *accountTextField;
@property (weak, nonatomic) IBOutlet TextField *codeTextField;
@property (weak, nonatomic) IBOutlet TextField *newestPasswordTextField;
@property (weak, nonatomic) IBOutlet TextField *againNewestPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (weak, nonatomic) IBOutlet UIImageView *accountLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *codeLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *newestPasswordLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *againNewestPasswordLeftView;
@property (weak, nonatomic) IBOutlet UIButton *passwordSecureButton;
@property (weak, nonatomic) IBOutlet UIButton *againPasswordSecureButton;

- (IBAction)codeAction:(id)sender;
- (IBAction)finishAction:(id)sender;
@end
