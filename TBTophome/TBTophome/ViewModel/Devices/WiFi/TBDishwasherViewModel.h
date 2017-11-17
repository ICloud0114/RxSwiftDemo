//
//  TBDishwasherViewModel.h
//  TBTophome
//
//  Created by zhengyun on 2017/2/23.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

@interface TBDishwasherViewModel : TBDeviceViewModel

@property (nonatomic, assign) NSInteger cleanMode;              //操作模式
@property (nonatomic, assign) NSInteger mixMode;                // 3合一
@property (nonatomic, assign) NSInteger status;                 //设备状态
@property (nonatomic, assign) NSInteger appointmentHour;        //预约小时
@property (nonatomic, assign) NSInteger remainingMinute;        //剩余分钟
@property (nonatomic, assign) NSInteger childLock;              //童锁
@property (nonatomic, assign) NSInteger faultCode;              //故障码
@property (nonatomic, assign) NSInteger warning;                //报警
/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 选择模式
 */
@property (nonatomic, strong, readonly) RACCommand *selectCleanMode;

/**
 开始工作
 */
@property (nonatomic, strong, readonly) RACCommand *startWork;


/**
 电源开关
 */
@property (nonatomic, strong, readonly) RACCommand *power;

/**
 3合1操作
 */
@property (nonatomic, strong, readonly) RACCommand *mix3IN1;

/**
 童锁
 */
@property (nonatomic, strong, readonly) RACCommand *lockCommand;


/**
 預約
 */
@property (nonatomic, strong, readonly) RACCommand *reservationCommand;

@end
