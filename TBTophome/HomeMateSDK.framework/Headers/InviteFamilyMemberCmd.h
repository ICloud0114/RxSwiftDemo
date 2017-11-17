//
//  InviteFamilyMemberCmd.h
//  HomeMate
//
//  Created by Air on 15/9/9.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface InviteFamilyMemberCmd : BaseCmd
/**
 *  被邀请用户用户的userName（手机号或邮箱）
 */
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,assign)NSInteger inviteType;

@end
