//
//  ModifyDeviceCmd.h
//  Vihome
// 
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifyDeviceCmd : BaseCmd

@property (nonatomic, retain)NSString * deviceId;

/**
 如果是修改多个端点一体的设备的房间（roomId），如：温度+湿度传感器、人体红外+光照传感器，则需要传本字段。如果传了本字段，则不需要再转deviceId字段。
 */
@property (nonatomic, retain)NSString * extAddr;

@property (nonatomic, retain)NSString * deviceName;

@property (nonatomic, assign)int deviceType;

@property (nonatomic, retain)NSString * roomId;

@property (nonatomic, retain)NSString * irDeviceId;

@end
