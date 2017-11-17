//
//  TBModifyPasswordViewController.h
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBModifyPasswordViewController : TBBaseViewController

+ (instancetype)instanceViewController;

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *nPassword;
@property (weak, nonatomic) IBOutlet UITextField *againNewPassword;

@property (weak, nonatomic) IBOutlet UIButton *oldPasswordSecBt;
@property (weak, nonatomic) IBOutlet UIButton *nPasswordSecBt;
@property (weak, nonatomic) IBOutlet UIButton *againNewPasswordSecBt;

@end
NS_ASSUME_NONNULL_END
