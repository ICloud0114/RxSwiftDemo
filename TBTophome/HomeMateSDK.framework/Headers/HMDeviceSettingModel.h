//
//  HMDeviceSettingModel.h
//  HomeMate
//
//  Created by liuzhicai on 16/7/6.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"


@interface HMDeviceSettingModel : HMBaseModel

/**
 *  主键，设备唯一标识
 */
@property (nonatomic, copy)NSString *deviceId;

/**
 *  主键，参数的唯一标识
 *  每个设备中的paramId是唯一的，不可重复。
 *  具有特定含义，如：relay_off_time延时关时长。
 */
@property (nonatomic, copy)NSString *paramId;


/**
 *  参数类型
    1:布尔，2:整数，3:小数，4:文本，5:二进制，6:JSON，7:自定义

 */
@property (nonatomic, assign)int paramType;

/**
 *  参数的值，如果是数值、小数，均转换成字符串存储。布尔转换成False或True，二进制的转换成HEX文本串保存。如果是复合类型，则保存为json格式。
 */
@property (nonatomic, copy)NSString *paramValue;


/**
 *  是否开启了缓亮缓灭
 */
+ (BOOL)slowOnSlowOffIsEnableWithDeviceId:(NSString *)deviceId;

/**
 *  是否开启了延时关闭
 */
+ (BOOL)delayOffIsEnableWithDeviceId:(NSString *)deviceId;


/**
 *  是否禁止在手机端关闭电源， 为YES 则 情景绑定那里不显示，二级界面没有开关
 */
+ (BOOL)shutOffOnMobileIsForbiddenWithDeviceId:(NSString *)deviceId;

/**
 *  是否启动自定义电流保护
 */
+ (BOOL)eletricitySaveIsOnWithDeviceId:(NSString *)deviceId;

/**
 *  保护点持续时间(s)
 */
+ (int)eletricTimeWithDeviceId:(NSString *)deviceId;

/**
 *  保护点电流(mA)     返回数据以 mA 为单位
 */
+ (int)eletricValueWithDeviceId:(NSString *)deviceId;

/**
 *  缓亮缓灭时间长度
 */
+ (int)slowOnSlowOffTimeWithDeviceId:(NSString *)deviceId;

/**
 *  延迟关时间长度
 */
+ (int)delayOffTimeWithDeviceId:(NSString *)deviceId;

/**
 *  设备排列序号 （配电箱的分控有排序）
 */
+ (int)sortNumOfDeviceId:(NSString *)deviceId;

+ (int)abnormalFlagValueWithDeviceId:(NSString *)deviceId;


/**
 配电箱异常标志对象

 @param deviceId <#deviceId description#>
 @return <#return value description#>
 */
+ (HMDeviceSettingModel *)abnormalDistObjWithDeviceId:(NSString *)deviceId;
///**
// *  查询传感器接入模块的设备类型
// */
//+ (int)selectSubDeviceTypeWithDeviceType:(NSString *)deviceId;

@end
