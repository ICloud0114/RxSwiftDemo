//
//  GetSmsCmd.h
//  Vihome
//
//  Created by Air on 15-1-29.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface GetSmsCmd : BaseCmd

@property (nonatomic, retain)NSString * phoneNumber;

/**
 0 注册
 1 修改密码
 */
@property (nonatomic, assign)int type;
@end
