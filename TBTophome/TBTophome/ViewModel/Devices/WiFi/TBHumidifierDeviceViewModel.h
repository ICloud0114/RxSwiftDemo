//
//  TBHumidifierDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/1/19.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBHumidifierDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) BOOL powerStatus; //开关机
@property (nonatomic, assign) CGFloat currentTemperature; //当前温度
@property (nonatomic, assign) NSInteger setHumidity; //当前设定湿度 默认40，最大90
@property (nonatomic, assign) NSInteger gear; //雾量, 默认1
@property (nonatomic, assign) BOOL isLackWater; //是否缺水

/**
 设备开关机
 */
@property (nonatomic, strong, readonly) RACCommand *power;

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 湿度设定
 */
@property (nonatomic, strong, readonly) RACCommand *humiditySetting;


/**
 档位设定
 */
@property (nonatomic, strong, readonly) RACCommand *gearSetting;
@end
NS_ASSUME_NONNULL_END
