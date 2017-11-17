//
//  HMSceneAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseAPI.h"

@interface HMSceneAPI : HMBaseAPI

/**
 创建情景 create a scene
 
 @param sceneName 情景模式名称
 @param pic 情景图标编号
 @param completion 回调方法返回已经创建成功的 HMScene 对象的实例 return HMScene instance
 */
+ (void)createSceneWithName:(NSString *)sceneName pic:(int)pic completion:(commonBlockWithObject)completion;

/**
 修改情景 modify the scene

 @param sceneNo 情景No
 @param sceneName 情景名称
 @param pic 情景图标编号
 @param completion 回调方法返回修改成功后的 HMScene 对象的实例 return HMScene instance
 */
+ (void)modifySceneWithNo:(NSString *)sceneNo sceneName:(NSString *)sceneName pic:(int)pic completion:(commonBlockWithObject)completion;


/**
 删除情景绑定 delete scene bind

 @param sceneBindArray 要删除的情景绑定列表
 @param sceneNo 情景No
 @param completion 服务器返回数据
 */
+ (void)deleteSceneBinds:(NSArray *)sceneBindArray sceneNo:(NSString *)sceneNo completion:(commonBlockWithObject)completion;


/**
 添加情景绑定 add scene bind

 @param sceneBindArray 要添加的情景绑定列表
 @param sceneNo 情景 No
 @param completion 服务器返回数据
 */
+ (void)addSceneBinds:(NSArray *)sceneBindArray sceneNo:(NSString *)sceneNo completion:(commonBlockWithObject)completion;

/**
 修改情景绑定

 @param sceneBindArray 要修改的情景绑定
 @param sceneNo 情景 No
 @param completion 服务器返回数据
 */
+ (void)modifySceneBinds:(NSArray *)sceneBindArray sceneNo:(NSString *)sceneNo completion:(commonBlockWithObject)completion;

/**
 删除情景

 @param scene 情景实例对象
 @param completion 服务器返回数据
 */
+ (void)deleteScene:(HMScene *)scene completion:(commonBlockWithObject)completion;


/**
 触发情景

 @param sceneNo 情景No
 @param completion 服务器返回数据
 */
+ (void)triggleSceneWithSceneNo:(NSString *)sceneNo completion:(commonBlockWithObject)completion;

@end





