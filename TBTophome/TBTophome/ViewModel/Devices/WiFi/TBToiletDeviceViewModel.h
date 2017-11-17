//
//  TBToiletDeviceViewModel.h
//  TBTophome
//
//  Created by zhengyun on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TBToiletDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) NSInteger machStatus;     //操作模式
@property (nonatomic, assign) NSInteger s_temperature; //水温
@property (nonatomic, assign) NSInteger s_pressure;     //水压
@property (nonatomic, assign) NSInteger s_position;     //管位
@property (nonatomic, assign) NSInteger s_time;         //清洗时间
@property (nonatomic, assign) NSInteger s_dryLevel;     //风干档位
@property (nonatomic, assign) NSInteger s_dryTime;      //风干时间

@property (nonatomic, assign) NSInteger remainTime;      //剩余时间

@property (nonatomic, assign) NSInteger timeEnable;                //时间使能

@property (nonatomic, assign) BOOL peopleStatus;//是否有人

@property (nonatomic, assign) NSInteger c_machStatus;     //操作模式
@property (nonatomic, assign) NSInteger c_temperature; //水温
@property (nonatomic, assign) NSInteger c_pressure;     //水压
@property (nonatomic, assign) NSInteger c_position;     //管位
@property (nonatomic, assign) NSInteger c_time;         //清洗时间
@property (nonatomic, assign) NSInteger c_dryLevel;     //风干档位
@property (nonatomic, assign) NSInteger c_dryTime;      //风干时间

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 选择功能
 */
@property (nonatomic, strong, readonly) RACCommand *operationMode;


/**
 状态改变
 */
@property (nonatomic, strong, readonly) RACCommand *stateChange;


@end
NS_ASSUME_NONNULL_END
