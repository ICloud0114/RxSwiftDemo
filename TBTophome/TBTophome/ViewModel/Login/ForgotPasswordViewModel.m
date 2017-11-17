//
//  ForgotPasswordViewModel.m
//  Template
//
//  Created by Topband on 2016/12/14.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ForgotPasswordViewModel.h"

@implementation ForgotPasswordViewModel

- (void)getCodeWithPhone:(NSString *)phone completionHandle:(void (^)(NSError *))handle {
    GetSmsCmd *smsCmd = [GetSmsCmd object];
    smsCmd.phoneNumber = phone;
    smsCmd.type = 1;
    smsCmd.sendToServer = YES;
    sendCmd(smsCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        NSError *error = nil;
        if (returnValue != KReturnValueSuccess) {
            error = [self errorCode:returnValue toMap:^NSString *(KReturnValue value) {
                return value == KRegisterUserExist ? @"该用户不存在" : @"获取失败";
            }];
        }
        handle(error);
    });
}

- (void)resetPasswordWithPhone:(NSString *)phone
                          code:(NSString *)code
                      password:(NSString *)pwd
              completionHandle:(void (^)(NSError *))handle {
    NSLog(@"-----%@", phone);
    NSLog(@"-----%@", code);
    CheckSmsCmd *checksmscmd = [CheckSmsCmd object];
    checksmscmd.authCode = code;
    checksmscmd.phoneNumber = phone;
    checksmscmd.sendToServer = YES;
    sendCmd(checksmscmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        if (returnValue == KReturnValueSuccess) {
            NSLog(@"-----%@", pwd);
            ResetPasswordCmd *cmd = [ResetPasswordCmd object];
            cmd.password = md5WithStr(pwd);
            cmd.sendToServer = YES;
            sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
                NSError *error = nil;
                if (returnValue != KReturnValueSuccess) {
                    error = [self errorCode:returnValue toMap:^NSString *(KReturnValue value) {
                        return @"重置失败";
                    }];
                }
                handle(error);
            });
        } else {
            NSError *error = [self errorCode:returnValue toMap:^NSString *(KReturnValue value) {
                if (value == KReturnValueCodeOutOfDate) {
                    return @"验证码过期";
                } else if (value == KReturnValueCodeNotFitWithPhoneNum) {
                    return @"验证码与手机号不一致";
                } else if (value == KReturnValueCodeERR) {
                    return @"验证码错误";
                } else {
                    return @"验证码校验失败";
                }
            }];
            handle(error);
        }
    });
}

@end
