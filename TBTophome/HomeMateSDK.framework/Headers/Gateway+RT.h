//
//  Gateway+RT.h
//  Vihome
//
//  Created by Air on 15-1-27.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "Gateway.h"

@interface Gateway (RT)

/**
   读取所有表
 */

-(void)readTableWithUid:(NSString *)uid remote:(BOOL)isRemote completion:(commonBlock)completion;


/**
  读取其它指定名称的表
 */
-(void)readTableWithName:(NSString *)name dic:(NSDictionary *)dic uid:(NSString *)uid remote:(BOOL)isRemote completion:(commonBlock)completion;

-(void)readTableWithName:(NSString *)name dic:(NSDictionary *)dic uid:(NSString *)uid remote:(BOOL)isRemote specific:(BOOL) specific completion:(commonBlock)completion;
// 接收到表数据
-(void)didReceiveTableData:(NSDictionary *)dic;

// 只要接收到表数据就立即插入数据库，不做校验
-(void)saveTableAnyway:(NSDictionary *)dic;
@end
