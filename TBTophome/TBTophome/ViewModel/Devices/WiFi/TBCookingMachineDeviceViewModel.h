//
//  TBCookingMachineDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/2/16.
//  Copyright © 2017年 Topband. All rights reserved.
//
//料理机
#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBCookingMachineDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) NSInteger curWorkMode;
@property (nonatomic, assign) NSInteger curSteering; // 当前转向
@property (nonatomic, assign) NSInteger curGears; //当前档位
@property (nonatomic, assign) NSInteger curTemp; //当前温度
@property (nonatomic, assign) NSInteger curTime; //当前时间
@property (nonatomic, assign) NSInteger curWeight; //当前重量
@property (nonatomic, assign) NSInteger curMenu; //菜单
/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 档位设置
 */
@property (nonatomic, strong, readonly) RACCommand *gearSetting;


/**
 温度设置
 */
@property (nonatomic, strong, readonly) RACCommand *tempSetting;

/**
 定时设置
 */
@property (nonatomic, strong, readonly) RACCommand *timeSetting;

/**
 点动设置
 */
@property (nonatomic, strong, readonly) RACCommand *rollMaxSetting;

/**
 开始工作
 */
@property (nonatomic, strong, readonly) RACCommand *startWorkSetting;

/**
 暂停工作
 */
@property (nonatomic, strong, readonly) RACCommand *pauseWorkSetting;

/**
 称重设置
 */
@property (nonatomic, strong, readonly) RACCommand *weightSetting;

/**
 停止设置
 */
@property (nonatomic, strong, readonly) RACCommand *stopSetting;

/**
 反转设置
 */
@property (nonatomic, strong, readonly) RACCommand *reverseSetting;
@end
NS_ASSUME_NONNULL_END
