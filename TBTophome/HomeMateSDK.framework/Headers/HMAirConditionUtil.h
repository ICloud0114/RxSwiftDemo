//
//  HMAirConditionUtil.h
//  HomeMate
//
//  Created by liqiang on 16/3/22.
//  Copyright © 2016年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

// wifi空调/空调面板模式类型
typedef NS_ENUM(NSInteger,HMAirModelStatus) {
    HMAirModelStatusCold, // 制冷
    HMAirModelStatusHot, // 制热
    HMAirModelStatusWet, // 抽湿
    HMAirModelStatusWind, // 抽风
    HMAirModelStatusAuto,  // 自动
    
    /** 新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理 */
    HMAirModelStatusVRVStartPoint,       // 作为基准，不使用
    /** VRV自动模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVAuto,
    /** VRV除湿模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVDehumidification,
    /** VRV制冷模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVCool,
    /** VRV制热模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVHeat,
    /** VRV紧急加热模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    //HMAirModelStatusVRVEmergencyHeating, [替换为采暖模式]
    /** VRV采暖模式(协议没有，需要协商)(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVHeatPlumbing,
    /** VRV预冷却模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVPrecooling,
    /** VRV送风模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVFanOnly,
    /** VRV干燥模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVDry,
    /** VRV睡眠模式(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
    HMAirModelStatusVRVSleep,
    /** VRV采暖模式(协议没有，需要协商)(新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理) */
//    HMAirModelStatusVRVHeatPlumbing,
};

// wifi空调/空调面板 风速
typedef NS_ENUM(NSInteger,HMAirWindLevel) {
    HMAirWindLevelAuto, // 自动
    HMAirWindLevelWeak, //弱风
    HMAirWindLevelMiddleWeak, //弱风
    HMAirWindLevelMiddle, //中风
    HMAirWindLevelMiddleStrong, //强风
    HMAirWindLevelStrong, //强风
    HMAirWindLevelSuper, //无极条速
    
    /** 新加的VRV，在HMVRVAirConditionUtil处理，HMAirConditionUitl不做处理 */
    HMAirWindLevelVRVStartPoint,       // 作为基准，不使用
    HMAirWindLevelVRVLow,              // 弱
    HMAirWindLevelVRVMedium,           // 中
    HMAirWindLevelVRVHigh,             // 强
    HMAirWindLevelVRVOn,               //
    HMAirWindLevelVRVAuto,             //
    HMAirWindLevelVRVSmart,            //
    HMAirWindLevelVRVMediumLow,        //
    HMAirWindLevelVRVMediumHigh,       //
    
};
@interface HMAirConditionUtil : NSObject

/**
 *  设置温度
 *
 *  @param temperature 温度值
 *  @param device      设备
 *
 *  @return 设置温度命令
 */
+ (ControlDeviceCmd *)setTemperature:(NSInteger)temperature device:(HMDevice *)device;

/**
 *  控制开关命令
 *
 *  @param isOpen YES 开  NO 关
 *  @param device
 *
 *  @return 开关命令
 */
+ (ControlDeviceCmd *)openAirCondition:(BOOL)isOpen device:(HMDevice *)device;

/**
 *  空调锁的命令
 *
 *  @param isLock YES 锁 NO 开锁
 *  @param device
 *
 *  @return 锁命令
 */
+ (ControlDeviceCmd *)lockAirCondition:(BOOL)isLock device:(HMDevice *)device;

/**
 *  设置空调模式
 *
 *  @param status  模式
 *  @param device
 *
 *  @return 模式命令
 */
+ (ControlDeviceCmd *)setAirModel:(HMAirModelStatus)statusModel device:(HMDevice *)device;

/**
 *  设置风级命令
 *
 *  @param level  风级
 *  @param device
 *
 *  @return 风级命令
 */
+ (ControlDeviceCmd *)setWindLevel:(HMAirWindLevel)level device:(HMDevice *)device;

/**
 *  获取当前温度值
 *
 *  @param device
 *
 *  @return 温度值
 */
+ (int)airconditionCurrentValue:(HMDevice *)device;




/**
 *  获取设置温度值
 *
 *  @param device
 *
 *  @return 温度值
 */
+ (int)airconditionSettingValue:(HMDevice *)device;


/**
 *  判断空调面板 是否加锁
 *
 *  @param device
 *
 *  @return YES 是  NO 否
 */
+ (BOOL)airIsLock:(HMDevice *)device;

/**
 *  判断WiFi空调/空调面板开关
 *
 *  @param device
 *
 *  @return YES 开  NO 关
 */
+ (BOOL)airIsOpen:(HMDevice *)device;

/**
 *  获取WiFi空调/空调面板当前风速
 *
 *  @param device
 *
 *  @return 风速
 */
+ (HMAirWindLevel)airWindLevel:(HMDevice *)device;


/**
 *  获取WiFi空调/空调面板当前模式
 *
 *  @param device
 *
 *  @return 模式
 */
+ (HMAirModelStatus)modelStatus:(HMDevice *)device;











/**
 *  绑定命令设置温度
 *
 *  @param temperature 温度
 *  @param scenebind
 *
 *  @return
 */
+ (id)setBindTemperature:(NSInteger)temperature senebind:(id)scenebind;


/**
 *  绑定空调 开关
 *
 *  @param isOpen
 *  @param scenebind
 *
 *  @return
 */
+ (id)setBindAirOpen:(BOOL)isOpen senebind:(id)scenebind;

/**
 *  绑定空调锁动作
 *
 *  @param isLock
 *  @param scenebind
 *
 *  @return
 */
+ (id)setBindAirLock:(BOOL)isLock senebind:(id)scenebind;

/**
 *  绑定设置模式
 *
 *  @param statusModel
 *  @param sceneBind
 *
 *  @return
 */
+ (id)setAirBindModel:(HMAirModelStatus)statusModel sceneBind:(id)sceneBind;

/**
 *  绑定air风级
 *
 *  @param level
 *  @param sceneBind
 *
 *  @return
 */
+ (id)setBindWindLevel:(HMAirWindLevel)level sceneBind:(id)sceneBind;


/**
 *  判断绑定开关
 *
 *  @param sceneBind
 *
 *  @return
 */
+ (BOOL)bindOpen:(id)sceneBind ;


/**
 *  判断绑定锁
 *
 *  @param sceneBind
 *
 *  @return
 */
+ (BOOL)bindLock:(id)sceneBind;

/**
 *  绑定模式
 *
 *  @param sceneBind
 *
 *  @return
 */
+ (HMAirModelStatus)bindModel:(id)sceneBind;

/**
 *  绑定风速
 *
 *  @param sceneBind
 *
 *  @return
 */
+ (HMAirWindLevel)bindWindLevel:(id)sceneBind;


/**
 *  获取设定温度
 *
 *  @param sceneBind
 *
 *  @return
 */
+ (int)getBindSettingTemperature:(id)sceneBind;



/**
 *  根据value1 判断是否开关
 *
 *  @param value1
 *
 *  @return
 */
+ (BOOL)open:(int)value1;

+ (int)airTemperatureInt:(int)value2 temperature:(int)temperature;

#pragma mark - Func Methods

/**
 将value的第position位设为1
 
 @param value    修改前的值
 @param position 第position位设定为1，position的序号从1开始
 @return         修改后的值
 */
+ (int)value1:(int)value position:(int)position;
/**
 将value的第position位设为0
 
 @param value    修改前的值
 @param position 第position位设定为0，position的序号从1开始
 @return         修改后的值
 */
+ (int)value0:(int)value position:(int)position;



@end
