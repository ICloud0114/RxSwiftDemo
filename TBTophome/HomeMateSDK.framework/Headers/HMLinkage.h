//
//  VihomeLinkage.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMLinkage : HMBaseModel

/**
 *  主键、自增长
 */
@property (nonatomic, retain)NSString *          linkageId;

/**
 *  联动名称，1-16字节
 */
@property (nonatomic, retain)NSString *         linkageName;

/**
 *  0：表示开启联动，如果触发条件满足的话则输出联动动作
 *  1：表示暂停联动，不管如何都不输出联动动作
 */
@property (nonatomic, assign)int                isPause;

// 非协议字段

/**
 *  是否是小方联动
 */
@property (nonatomic, assign,readonly)BOOL     isMagicCubeLinkage;

+(NSArray *)allLinkagesArr;

/**
 *  根据联动输出设备删除相关联动
 *
 *  @param deviceId
 *  @param uid
 */
+ (void)deleteLinkageWithDeviceId:(NSString *)deviceId;

+ (void)deleteLinkageWithLinkageId:(NSString *)linkageId;

+ (void)deleteSecurityWithDeviceId:(NSString *)deviceId;

+ (NSInteger)getLinageConditionCountWithLinakgeId:(NSString *)linkageId;

+ (BOOL)isAlloneLinkage:(NSString *)linkageId;

@end
