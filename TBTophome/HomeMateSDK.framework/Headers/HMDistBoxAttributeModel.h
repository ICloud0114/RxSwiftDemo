//
//  HMDistBoxAttributeModel.h
//  HomeMateSDK
//
//  Created by liuzhicai on 16/10/17.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMDistBoxAttributeModel : HMBaseModel

@property (nonatomic, retain)NSString *   deviceId;

/**
 *  属性标识
 */
@property (nonatomic, assign)int   attributeId;

/**
 *  实时属性值
 */
@property (nonatomic, assign)int   attrValue;


// ************* 非表结构字段 ****************
/**
 *  电压
 */
@property (nonatomic, assign)CGFloat voltage;

/**
 *  电流
 */
@property (nonatomic, assign)CGFloat current;


/**
 *  功率
 */
@property (nonatomic, assign)CGFloat power;

/**
 *  功率因数
 */
@property (nonatomic, assign)CGFloat powerFactor;

/**
 *  过载电压
 */
@property (nonatomic, assign)CGFloat overVoltage;

/**
 *  过载电流
 */
@property (nonatomic, assign)CGFloat overCurrent;

+ (CGFloat)voltageWithDeviceId:(NSString *)deviceId; // 电压
+ (CGFloat)currentWithDeviceId:(NSString *)deviceId; // 电流
+ (CGFloat)powerWithDeviceId:(NSString *)deviceId; // 功率
+ (CGFloat)powerFactorWithDeviceId:(NSString *)deviceId; // 功率因素
+ (CGFloat)overVoltageWithDeviceId:(NSString *)deviceId; // 过载电压
+ (CGFloat)overCurrentWithDeviceId:(NSString *)deviceId; // 过载电流

+ (int)abnormalValueWithDeviceId:(NSString *)deviceId; // 异常属性值
+ (NSString *)abnormalInfoStrWithDeviceId:(NSString *)deviceId; // 异常信息字符串，用于显示
+ (BOOL)hasAbnormalInfoWithDeviceId:(NSString *)deviceId; // 判断是否有异常信息


/**
 把配电箱的电压都重置为0( 0,1端点除外 )，查询最新电压

 @param extAddr 配电箱MAC地址
 */
+ (void)resetVoltageToZeroWithExtAddr:(NSString *)extAddr;
+ (HMDistBoxAttributeModel *)objectWithDeviceId:(NSString *)deviceId;

/****   以下方法弃用      *******/
/**
 如果一个分控能控制或者能收到开关属性报告返回，则说明正常，把异常标志为的值置0，防止界面上一直显示红色的异常消息

 @param deviceId 分控deviceId
 */
//+ (void)updateAbnormalFlagWithDeviceId:(NSString *)deviceId;



@end
