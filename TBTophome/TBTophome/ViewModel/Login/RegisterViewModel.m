//
//  RegisterViewModel.m
//  Template
//
//  Created by Topband on 2016/12/14.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

- (void)getCodeWithPhone:(NSString *)phone
              completion:(GetCodeCompletionHandle)handle {
    // 手机号注册
    GetSmsCmd *cmd = [GetSmsCmd object];
    cmd.phoneNumber = phone;
    cmd.type = 0;
    cmd.sendToServer = YES;
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        NSError *error = nil;
        if (returnValue != KReturnValueSuccess) {
            error = [self errorCode:returnValue toMap:^NSString *(KReturnValue value) {
                return value == KRegisterUserExist ? @"该手机号已注册" : @"获取失败";
            }];
        }
        handle(error);
    });
}

- (void)registerWithPhone:(NSString *)phone
                     code:(NSString *)code
                 password:(NSString *)password
               completion:(RegisterCompletionHandle)handle {
    //检查验证码
    CheckSmsCmd *cmd = [CheckSmsCmd object];
    cmd.authCode = code;
    cmd.phoneNumber = phone;
    cmd.sendToServer = YES;
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        if (returnValue == KReturnValueSuccess) {
            //完成注册
            RegisterCmd *cmd = [RegisterCmd object];
            cmd.phone = phone;
            cmd.email = @"";
            cmd.password = md5WithStr(password);
            cmd.sendToServer = YES;
            sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
                NSError *error = nil;
                if (returnValue != KReturnValueSuccess) {
                    error = [self errorCode:returnValue toMap:^NSString *(KReturnValue value) {
                        return value == KRegisterUserExist ? @"用户已注册" : @"注册失败";
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
