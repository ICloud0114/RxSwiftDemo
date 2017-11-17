//
//  VhAPConfigMsg.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/6.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAPConfigCallback.h"



typedef NS_ENUM(int , VhAPConfigCmd){
    VhAPConfigCmd_DeviceInfo = 79,
    VhAPConfigCmd_WIFIList = 80,
    VhAPConfigCmd_SetWifi = 81,
    
    
    /**
     *  3.4.64本地测量模式接口,
     */
    VhAPConfigCmd_LocalMeasurement = VIHOME_CMD_LOCAL_MEASUREMENT,
    /**
     *  3.6.23传感器数据上报接口
     */
    VhAPConfigCmd_SENSOR_DATA_REPORT = VIHOME_SENSOR_DATA_REPORT,
    
    /**
     *  3.5.14	AP配置剩余时间上报接口
     */
    VhAPConfigCmd_REMAIN_TIME = VIHOME_CMD_REMAIN_TIME,

} ;


/**
 一条消息从 发送 到 响应/超时 的生命周期结构体
 */
@interface HMAPConfigMsg : NSObject
@property (nonatomic, assign) VhAPConfigCmd cmd;
@property (nonatomic, strong) NSDictionary * msgBody;
@property (nonatomic, assign) id <HMAPConfigCallback> callback;

/**
 发出请求的开始时间戳，用于超时；由超时管理器操作它；
 */
@property (nonatomic, strong) NSDate* startTimestamp;

/**
 请求超时秒数
 */
@property (nonatomic, assign) NSInteger timeoutSeconds;

/**
 *	@brief	设置超时起始时间
 */
-(void)startTimeout;

/**
 *	@brief	获得超时起始时间
 *
 *	@return 起始时间
 */
-(NSDate*)getStartTime;

/**
 *	@brief	获得设定的超时时间
 *
 *	@return	超时时间（s）
 */
-(NSInteger)getTimeoutTime;

/**
 超时时执行
 */
- (void)doTimeout;
@end
