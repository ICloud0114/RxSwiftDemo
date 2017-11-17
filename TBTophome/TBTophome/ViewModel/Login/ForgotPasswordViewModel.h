//
//  ForgotPasswordViewModel.h
//  Template
//
//  Created by Topband on 2016/12/14.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"

@interface ForgotPasswordViewModel : ViewModel

- (void)getCodeWithPhone:(NSString *)phone
        completionHandle:(void (^)(NSError *))handle;

/**
 重置密码

 @param phone  手机号
 @param code   验证码
 @param pwd    密码
 @param handle 完成回调
 */
- (void)resetPasswordWithPhone:(NSString *)phone
                          code:(NSString *)code
                      password:(NSString *)pwd
              completionHandle:(void (^)(NSError *))handle;
@end
