//
//  VihomeBindGatewayList.h
//  Vihome
//
//  Created by Air on 15-2-5.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"
#import "Gateway.h"

@interface HMDevicesBind : HMBaseModel

@property (nonatomic, strong)NSString *         userId;
@property (nonatomic, strong)NSString *         model;
//@property (nonatomic, strong)NSString *         uid; // 父类已经有了
@property (nonatomic, strong)NSString *         isOnline;
@property (nonatomic, strong)NSString *         isLocal;
@property (nonatomic, strong)NSString *         localIP;

@property (nonatomic, assign)int                localPort;

@property (nonatomic, assign)int                versionID;

@property (nonatomic, assign,readonly) BOOL     isVicenter; // 判断当前设备是否是主机

@property (nonatomic, strong)NSNumber *         lastUpdateTime; // 对应的uid 上次更新时间

/**
 *  当前帐号所有绑定的网关，包括主机，S20，COCO
 *
 *  @return
 */
+(NSArray *)bindArray;

/**
 *  当前帐号是否绑定主机
 *
 *  @return
 */
+(BOOL)existsVihomePro;

/**
 *  get 一个设备绑定信息
 *
 *  @param gateway 指定的设备
 *
 *  @return
 */
+(HMDevicesBind *)bindWithGateway:(Gateway *)gateway;

+(HMDevicesBind *)bindWithHmGateway:(HMGateway *)gateway;

/**
 *  get 一个设备绑定信息
 *
 *  @param uid 指定设备的uid
 *
 *  @return
 */

+(HMDevicesBind *)bindWithUid:(NSString *)uid;


/**
 判断某UId是否有绑定关系
 */
+ (BOOL)isHasBindWithUid:(NSString *)uid;

/**
 删除旧的绑定信息
 */
+ (BOOL)deleteOldBindInfo;

/**
 *  根据userId 返回对应的绑定关系
 *
 *  @param userId
 *
 *  @return
 */
+(NSArray *)bindArrayWithUserId:(NSString *)userId familyId:(NSString *)familyId;

/**
 *  判断指定的uid是否是WIFI设备
 *
 *  @param uid
 *
 *  @return
 */
+(BOOL)isWifiDeviceWithUid:(NSString *)uid;

/**
 *  判断指定的uid是否是主机
 *
 *  @param uid
 *
 *  @return
 */
+(BOOL)isHostWithUid:(NSString *)uid;

/**
 *  查找指定uid的model
 *
 *  @param uid
 *
 *  @return 如果查到返回真实值，查不到返回nil
 */
+(NSString *)modelWithUid:(NSString *)uid;


/**
 *  返回widget需要的绑定关系字典
 */

-(NSDictionary *)widgetBindInfo;

@end
