//
//  TBAddDeviceConfigViewController.h
//  TBTophome
//
//  Created by Topband on 2017/1/5.
//  Copyright © 2017年 Topband. All rights reserved.
//
//连接设备
#import "TBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBAddDeviceConfigViewController : TBBaseViewController


/**
 实例化配置页面

 @param param @{
    kDeviceName: @"",
    kDeviceRealImage: @"",
    kDeviceOnImage: @"",
    kDeviceOffImage: @""
 }
 */
+ (instancetype)instanceAddDeviceConfigViewController:(NSDictionary *)param;

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceRealImage;
@property (nonatomic, copy) NSString *deviceOnImage;
@property (nonatomic, copy) NSString *deviceOffImage;

@end
NS_ASSUME_NONNULL_END
