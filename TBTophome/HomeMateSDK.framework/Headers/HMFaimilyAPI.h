//
//  HMFaimilyAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseAPI.h"

@interface HMFaimilyAPI : HMBaseAPI


/**
 查询当前用户的家庭列表（查询成功会写入到本地数据库，使用 [HMFamily selectAllFamilyObject] 可返回家庭列表）

 @param completion 回调方法使用服务器返回数据
 */
+ (void)queryFamilyListWithCompletion:(commonBlockWithObject)completion;

/**
 切换家庭

 @param familyId 目标家庭的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)swithToFamily:(NSString *)familyId completion:(commonBlock)completion;

/**
 创建家庭

 @param familyName 家庭的名称
 @param completion 回调方法使用服务器返回数据
 */
+ (void)createFamilyWithName:(NSString *)familyName completion:(commonBlockWithObject)completion;
+ (void)createFamilyWithName:(NSString *)familyName loading:(BOOL)loading completion:(commonBlockWithObject)completion;
+ (void)createFamilyWithName:(NSString *)familyName loading:(BOOL)loading insert:(BOOL)insert completion:(commonBlockWithObject)completion;

/**
 修改家庭名称

 @param familyName 家庭的名称
 @param familyId 该家庭的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)modifyFamilyWithName:(NSString *)familyName familyId:(NSString *)familyId completion:(commonBlockWithObject)completion;

/**
 查询家庭成员（向服务器请求）

 @param familyId 该家庭的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)queryFamilyUsersList:(NSString *)familyId completion:(commonBlockWithObject)completion;

/**
 邀请家庭成员

 @param userName 手机或邮箱
 @param familyId 该家庭的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)inviteFamily:(NSString *)userName familyId:(NSString *)familyId completion:(commonBlockWithObject)completion;

/**
 删除家庭成员

 @param familyUser 要删除的家庭成员 HMFamilyUsers 实例
 @param completion 回调方法使用服务器返回数据
 */
+ (void)deleteFamilyUsers:(HMFamilyUsers *)familyUser completion:(commonBlockWithObject)completion;
+ (void)deleteFamilyUsers:(HMFamilyUsers *)familyUser deleteLocal:(BOOL)deleteLocal completion:(commonBlockWithObject)completion;

/**
 删除家庭（必须是管理员用户/家庭的创建者）

 @param familyId 该家庭的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)deleteFamily:(NSString *)familyId completion:(commonBlockWithObject)completion;

/**
 家庭成员退出家庭（该用户不是家庭的管理员/家庭的创建者）

 @param familyId 该家庭的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)exitFamily:(NSString *)familyId completion:(commonBlockWithObject)completion;

@end
