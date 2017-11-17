//
//  ServerModifyDevice.h
//  CloudPlatform
//
//  Created by orvibo on 15/6/28.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ServerModifyDeviceCmd : BaseCmd

/**
 *  被修改的设备编号
 */
@property (nonatomic, copy) NSString        *deviceId;

/**
 *  设备名称
 */
@property (nonatomic, copy) NSString        *deviceName;

/**
 *  设备类型
 */
@property (nonatomic, assign) KDeviceType   deviceType;

/**
 *  所属房间编号
 */
@property (nonatomic, copy) NSString *           roomId;

/**
 *  标准红外设备id
 */
@property (nonatomic, copy) NSString *          irDeviceId;

@end
