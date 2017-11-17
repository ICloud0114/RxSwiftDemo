//
//  FamilyMemberResponseCmd.h
//  HomeMate
//
//  Created by Air on 15/9/9.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface FamilyMemberResponseCmd : BaseCmd


/**
 *  邀请请求的id
 */
@property (nonatomic, copy) NSString *inviteId;

/**
 *  0：接受邀请
 *  1：拒绝邀请
 */
@property (nonatomic, assign) int type;



@end
