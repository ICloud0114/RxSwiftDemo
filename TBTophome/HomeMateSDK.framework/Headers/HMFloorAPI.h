//
//  HMFloorAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseAPI.h"

@interface HMFloorAPI : HMBaseAPI


/**
 创建楼层

 @param floorName  楼层的名称
 @param familyId   家庭id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)createFloor:(NSString *)floorName familyId:(NSString *)familyId completion:(commonBlockWithObject)completion;


/**
 修改楼层名称

 @param floorName 修改后的楼层的名称
 @param floorId 该楼层的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)modifyFloorName:(NSString *)floorName floorId:(NSString *)floorId completion:(commonBlockWithObject)completion;

/**
 删除楼层

 @param floorId 该楼层的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)deleteFloor:(NSString *)floorId completion:(commonBlockWithObject)completion;

/**
 创建房间

 @param roomName 房间的名称
 @param floorId 要创建的房间所在的楼层id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)createRoom:(NSString *)roomName floorId:(NSString *)floorId completion:(commonBlockWithObject)completion;

/**
 修改房间名称

 @param roomName 房间的名称
 @param roomId 该房间的id
 @param completion 回调方法使用服务器返回数据
 */
+ (void)modifyRoom:(NSString *)roomName roomId:(NSString *)roomId completion:(commonBlockWithObject)completion;

/**
 删除房间

 @param roomId 该房间的id
 @param loading 是否要正在加载控件
 @param completion 回调方法使用服务器返回数据
 */
+ (void)deleteRoom:(NSString *)roomId loading:(BOOL)loading completion:(commonBlockWithObject)completion;

@end
