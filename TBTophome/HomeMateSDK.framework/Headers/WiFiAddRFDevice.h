//
//  WiFiAddRFDevice.h
//  HomeMateSDK
//
//  Created by peanut on 2016/12/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface WiFiAddRFDevice : WiFiAddDevice

/**
 *  RF创建子设备命令需要这个参数，传入RF主机对应device的appDeviceId
 */
@property (nonatomic, copy) NSNumber * appDeviceId;

@end
