//
//  Gateway+Login.h
//  Vihome
//
//  Created by Air on 15/5/25.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "Gateway.h"

@interface Gateway (Login)
/**
 *  只做本地登录操作
 *
 *  @param completion 回调block
 */
-(void)localLoginWithUserName:(NSString *)name password:(NSString *)password completion:(SocketCompletionBlock)completion;

/**
 *  先本地登录，登录完成本地读取表数据
 *
 *  @param completion 回调block
 */
-(void)localLoginToReadData:(commonBlock)completion;

/**
 *  只做读表操作，先尝试本地登录，失败则远程登录
 *
 *  @param completion 回调block
 */
-(void)readTableData:(commonBlock)completion;

@end
