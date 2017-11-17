//
//  TBCoffeeDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/2/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBCoffeeDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) NSInteger curHandleStatus; //当前拉柄状态
@property (nonatomic, assign) NSInteger curCoffeeStatus; //当前煲咖啡状态
@property (nonatomic, assign) NSInteger curSystemStatus; //当前系统状态
@property (nonatomic, assign) NSInteger curTemp; //当前温度
@property (nonatomic, assign) NSInteger curCoffeeCups; //当前咖啡杯数

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 启动工作
 */
@property (nonatomic, strong, readonly) RACCommand *startWorkSetting;

/**
 停止工作
 */
@property (nonatomic, strong, readonly) RACCommand *stopWorkSetting;

/**
 唤醒
 */
@property (nonatomic, strong, readonly) RACCommand *wakeupSetting;

/**
 温度设置
 */
@property (nonatomic, strong, readonly) RACCommand *temperatureSetting;
@end
NS_ASSUME_NONNULL_END
