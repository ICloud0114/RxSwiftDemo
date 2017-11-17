//
//  LoginViewModel.m
//  Template
//
//  Created by Topband on 2016/12/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LoginViewModel.h"


@implementation LoginViewModel

- (void)loginWithAccount:(NSString *)account password:(NSString *)password completion:(LoginCompletionHandle)handle {
    [HMSDK loginWithUserName:account password:password completion:^(KReturnValue value) {
        NSError *error = nil;
        if (value != KReturnValueSuccess) {
            error = [self errorCode:value toMap:^NSString *(KReturnValue value) {
                return value == KReturnValueAccountOrPWDERR ? @"用户名或密码错误" : @"登录失败";
            }];
        }
        handle(error);
    }];
}

@end
