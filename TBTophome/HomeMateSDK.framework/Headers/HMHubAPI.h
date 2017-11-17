//
//  HMHubAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseAPI.h"

@interface HMHubAPI : HMBaseAPI

/**
 添加网关
 @param gateway Gateway对象
 @param valueBlock 添加结果
 */
+ (void)addGateway:(Gateway *)gateway result:(KReturnValueBlock)valueBlock;


/**
 开启搜索ZigBee设备
 @param valueBlock 0：成功  其他：失败
 */
+ (void)openSearchZigBeeDevice:(KReturnValueBlock)valueBlock;


/**
 停止搜索ZigBee设备
 @param valueBlock  0：成功  其他：失败
 */
+ (void)closeSearchZigBeeDevice:(KReturnValueBlock)valueBlock;


/**
 获取已经被当前家庭添加的网关
 @param gatewaysBlock 回调已添加网关数组 （数组对象为 Gateway）
 */
+ (void)getGatewaysAdded:(void(^)(NSArray *gateways))gatewaysBlock;

/**
 搜索当前wifi下的网关
 @param gatewayBlock 回调网关数组
 */
+ (void)searchCurrentWifiGateways:(void(^)(NSArray *gateways))gatewaysBlock;

/**
 查询网关状态
 @param gateway Gateway对象
 @param result 网关状态
 */
+ (void)queryGateway:(Gateway *)gateway status:(void(^)(HMGatewayStatus status))resultBlock;

/**
 获取网关的名字
 
 @param gateway Gateway 对象
 @return 名字
 */
+ (NSString *)nameWithGateway:(Gateway *)gateway;

@end
