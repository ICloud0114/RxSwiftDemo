//
//  TBSettingAccountViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBSettingAccountViewModel.h"

@implementation TBSettingAccountViewModel

- (RACSignal *)modifyNickname:(NSString *)nickname {
    SetNicknameCmd *cmd = [SetNicknameCmd object];
    cmd.sendToServer = YES;
    cmd.nickname = nickname;
    return [[[self class] sendCmd:cmd] doNext:^(id  _Nullable x) {
        [userAccout() updateNickName:nickname];
    }];
}

- (RACSignal *)modifyPasswordWithOldPwd:(NSString *)oldPwd newPassword:(NSString *)newPwd {
    ModifyPasswordCmd *cmd = [ModifyPasswordCmd object];
    cmd.accountName = userAccout().userName;
    cmd.NewPassword = newPwd;
    cmd.OldPassword = oldPwd;
    cmd.sendToServer = YES;
    return [[self class] sendCmd:cmd];
}
@end
