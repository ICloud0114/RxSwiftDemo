//
//  HMLinkageAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseAPI.h"

@interface HMLinkageAPI : HMBaseAPI



/**
 删除联动

 @param linkage 联动实例
 @param completion 服务器返回字典
 */
+ (void)deleteLinkage:(HMLinkage *)linkage completion:(commonBlockWithObject)completion;


/**
 保存联动

 @param linkageName 联动名称
 @param conditionList 联动启动条件
 @param outputList 联动输出
 */
+ (void)createLinkageWithName:(NSString *)linkageName
                conditionList:(NSArray *)conditionList
                   outputList:(NSArray *)outputList
                   completion:(commonBlockWithObject)completion;

@end
