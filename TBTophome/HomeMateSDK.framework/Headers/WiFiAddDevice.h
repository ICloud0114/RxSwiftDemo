//
//  WiFiAddDevice.h
//  HomeMate
//
//  Created by orvibo on 16/3/30.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface WiFiAddDevice : BaseCmd

@property (nonatomic, assign)int deviceType;

@property (nonatomic, retain)NSString * deviceName;

@property (nonatomic, retain)NSString * roomId;

/**
 *  标准红外设备表外键，如果是红外设备，而且使用码库的话，此字段有效，填写大于0的值。其他无效的时候填写为0.
 *  Allone2下面创建的红外设备这里填写rid
 */
@property (nonatomic, retain)NSString * irDeviceId;

@property (nonatomic, retain)NSString * deviceId;

/**
 *  设备的生产厂商，我们自己的设备填写成orvibo，接入的其他公司产品填写其他公司的名称
 *  Allone2下面创建的红外设备这里填写brandId, -1表示自定义学码的设备
 */
@property (nonatomic, retain)NSString *company;

@end
