//
//  TBSettingAccountViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "ViewModel.h"

@interface TBSettingAccountViewModel : ViewModel

- (RACSignal *)modifyNickname:(NSString *)nickname;

- (RACSignal *)modifyPasswordWithOldPwd:(NSString *)oldPwd newPassword:(NSString *)newPwd;
@end
