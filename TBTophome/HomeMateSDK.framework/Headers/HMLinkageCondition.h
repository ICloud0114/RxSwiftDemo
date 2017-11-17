//
//  VihmeLinkageCondition.h
//  HomeMate
//
//  Created by Air on 15/8/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMLinkageCondition : HMBaseModel

/**
 *  主键 UUID
 */
@property (nonatomic, retain)NSString *          linkageConditionId;

/**
 *  外键
 */
@property (nonatomic, retain)NSString *          linkageId;

/**
 *  触发联动的类型
 0：按照设备状态来触发
 1：按照时间条件触发
 2：按照星期来触发
 */
@property (nonatomic, assign)int                linkageType;

/**
 *  0：表示等于
 1：表示大于
 2：表示小于
 3：表示大于或者等于
 4：表示小于或者等于
 */
@property (nonatomic, assign)int                condition;


/**
 *  当linkageType为0的时候填写设备编号
 当linkageType为1、2的时候填空值
 */
@property (nonatomic, retain)NSString *        deviceId;



/**
 *  当linkageType为0的时候有效
 表示由哪个value来触发联动
 1：value1
 2：value2
 3：value3
 4：value4
 当linkageType为1、2的时候填0
 */
@property (nonatomic, assign)int                statusType;


/**
 *  授权id之间以逗号分隔，如：
 “1,2,3,5,6,-1”
 
 如下为特殊情况下的id:
 -1 所有用户
 -2 机械开锁
 -3 门未锁好报警
 -4 解除门未锁好的报警
 -5 劫持报警
 -6 解除劫持报警
 -7 门锁被撬开报警
 -8 接触门锁被撬开报警
 */
@property (nonatomic, copy)NSString *        authorizedId;


/**
 *  按键编号
 *  Allone2的按键编号只有1
 *  当linkageType为3的时候有效
 */
@property (nonatomic, assign) int keyNo;

/**
 *  Allone2的按键动作目前只有0
 */
@property (nonatomic, assign) int keyAction;

/**
 *  当linkageType为0的时候value填写的是触发联动的状态值；
 当linkageType为1的时候value填写的是设置的时分秒转化为秒数的值，例如时间为12:09:50的话，这里填写12*3600+9*60+50；
 当linkageType为2的时候value填写的是星期有效位，这个value的最低那个字节的8位，最高位为0的时候表示执行周期为单次；最高位为1的时候，从低位到高位的前7位分别表示星期一到星期天的有效位。1表示有效、0表示无效；
 */
@property (nonatomic, assign)int                value;


/**
 查找包含设备的联动条件（一般的联动条件有四个，选出设备的那个）
 */
+(HMLinkageCondition *)linkageDeviceWithlinkageId:(NSString *)linkageId;

/**
 获取光照联动条件
 */
+(HMLinkageCondition *)getLightLinkageConditonWithlinkageId:(NSString *)linkageId;

+ (NSArray *)securityDeviceArrayWithSecurityId:(NSString *)securityId;

+ (NSArray *)deviceIdArrayWithSecurityId:(NSString *)securityId;

/**
 *  判断是否为光照联动
 */
+ (BOOL)isLightSensorLinkageWithLinkageId:(NSString *)linkageId;

+ (NSString *)getOtherConditionWithLinakgeId:(NSString *)linkageId;

+ (NSString *)getLightSensorLinkageLightConditionWithLinkageId:(NSString *)linkageId;

+ (NSString *)getLightSensorLinakgeHumanConditionWithLinakgeId:(NSString *)linkageId;

+ (void)deleteConditionWithConditionId:(NSString *)conditionId;

+ (NSString *)getLightSensorLinkageLightDeviceIdWithLinkageId:(NSString *)linkageId;

+ (NSString *)getLightSensorLinakgeHumanDeviceIdWithLinakgeId:(NSString *)linkageId;

@end
