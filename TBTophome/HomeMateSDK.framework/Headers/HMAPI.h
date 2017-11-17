//
//  HMAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#ifndef HMAPI_h
#define HMAPI_h


/**
 @brief 情景相关的API    Scene API
 @abstract 添加情景，修改情景名称，删除情景，控制情景 Add scene,Modify scene name,Delete Scene,Control scene
 @abstract 添加情景绑定，修改情景绑定，删除情景绑定 Add scene bind,Modify scene bind,Delete scene bind
 */
#import "HMSceneAPI.h"

/**
 @brief 联动相关的API    Linkage API
 @abstract 添加联动，修改联动名称，删除联动，生效/暂停联动 Add linkage,Modify linkage name,Delete linkage,Active/deactive linkage
 @abstract 添加联动输出，修改联动输出，删除联动输出 Add linkage output,Modify linkage output,Delete linkage output
 */
#import "HMLinkageAPI.h"


/**
 @brief 安防相关的API    Security API
 @abstract
 @abstract
 */
#import "HMSecurityAPI.h"

/**
 @brief 主机相关的API    Hub Management API
 @abstract 主机搜索，主机绑定，开启zigbee组网，关闭zigbee组网，删除主机
 @abstract 主机信息展示
 */
#import "HMHubAPI.h"


/**
 @brief WiFi设备AP配置相关的API    WiFi device AP config API
 @abstract
 @abstract
 */
#import "HMAPConfigAPI.h"

/**
 @brief 设备定时相关的API    Device timing API
 @abstract
 @abstract
 */
#import "HMTimingAPI.h"

/**
 @brief 设备操作相关的API    Device operation API
 @abstract 修改名称，设置房间，删除设备，控制设备 Modify device name,Set room,Delete device,Control device
 @abstract 设备信息展示
 */
#import "HMDeviceAPI.h"

/**
 @brief 家庭相关的API    Family API
 @abstract
 @abstract
 */
#import "HMFaimilyAPI.h"

/**
 @brief 楼层房间相关的API  Floor and room API
 @abstract
 @abstract
 */
#import "HMFloorAPI.h"

/**
 @brief app软件工厂设置API  app system setting API
 @abstract
 @abstract
 */
#import "HMAppFactoryAPI.h"

#endif /* HMAPI_h */
