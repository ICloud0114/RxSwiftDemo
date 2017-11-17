//
//  UserBindCmd.h
//  CloudPlatform
//
//  Created by orvibo on 15/6/16.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface UserBindCmd : BaseCmd

/**
 *  0：手机号注册的用户，绑定邮箱
 *  1：邮箱注册的用户，绑定手机号
 */
@property (nonatomic, assign) int Type;

/**
 *  手机号
 */
@property (nonatomic, copy) NSString *Mobile;

/**
 *  用户邮箱
 */
@property (nonatomic, copy) NSString *Email;


@end
