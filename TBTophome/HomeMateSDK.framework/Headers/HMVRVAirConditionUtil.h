//
//  HMVRVAirConditionUtil.h
//  HomeMate
//
//  Created by peanut on 2017/1/10.
//  Copyright © 2017年 Air. All rights reserved.
//

@interface HMVRVErrorCode : NSObject

/**
 故障码
 */
@property (nonatomic, assign) int errorCode;

/**
 故障描述
 */
@property (nonatomic, copy) NSString *errorDescription;
@end



@interface HMVRVAirConditionUtil : HMAirConditionUtil

/**
 取得当前空调模式对应的下一个空调模式

 @param airModelStatus 当前空调模式
 @return 下一个空调模式
 */
+ (HMAirModelStatus)nextModelStatusWithModelStatus:(HMAirModelStatus)airModelStatus;

/**
 是否处于故障状态下，是则返回故障对象，不存在则不返回

 @param device 设备
 @return 故障对象
 */
+ (HMVRVErrorCode *)errorStatus:(HMDevice *)device;


/**
 是否有设备状态，有则返回状态

 @param device 设备
 @return 状态
 */
+ (HMDeviceStatus *)hasStatus:(HMDevice *)device;

/**
 面板对应的主控制器是否在线(主控制器在设备状态表有状态，且online=0才为离线)

 @param device 面板设备
 @return 是/否
 */
+ (BOOL)isMainControlOnline:(HMDevice *)device;

/**
 * 设置电源打开(控制命令)
 */
+ (void)openAirConditionWithCmd:(ControlDeviceCmd *)cmd;


/**
 根据action对象，确定对应的动作选择描述(定时/情景绑定/情景面板绑定/联动任务)

 @param action   HMTiming、HMSceneBind等遵循OrderProtocol协议的对象
 @return 动作选择描述
 */
+ (NSString *)actionDescWithAction:(id<OrderProtocol>)action;

/**
 面板地址码。地址码为endPoint+14，以十进制方式显示

 @param device VRV子面板设备
 @return 该设备的面板地址码
 */
+ (NSString *)addressCodeWithDevice:(HMDevice *)device;

@end









