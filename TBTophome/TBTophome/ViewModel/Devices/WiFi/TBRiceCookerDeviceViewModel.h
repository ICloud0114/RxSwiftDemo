//
//  TBRiceCookerDeviceViewModel.h
//  TBTophome
//
//  Created by zhengyun on 2017/2/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TBRiceCookerDeviceViewModel : TBDeviceViewModel


@property (nonatomic, assign) NSInteger reservationTime;

@property (nonatomic, assign) NSInteger workTime;

@property (nonatomic, assign) NSInteger showTime;

@property (nonatomic, assign) NSInteger timeSetting;//0：无 1: 预约 2:定时

@property (nonatomic, assign) NSInteger workMode;

@property (nonatomic, assign) NSInteger workStatus;


@property (nonatomic, assign) BOOL isCookTiming;
@property (nonatomic, assign) BOOL isReservation;

/**
获取设备初始状态
*/
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 开始
 */
@property (nonatomic, strong, readonly) RACCommand *startCook;

/**
 停止
 */
@property (nonatomic, strong, readonly) RACCommand *stopCook;

/**
 保温
 */
@property (nonatomic, strong, readonly) RACCommand *warm;

/**
 预约
 */
@property (nonatomic, strong, readonly) RACCommand *reservation;

/**
 定时
 */
@property (nonatomic, strong, readonly) RACCommand *cookTiming;

/**
 时间调节
 */
@property (nonatomic, strong, readonly) RACCommand *timeAdjust;


/**
 模式
 */
@property (nonatomic, strong, readonly) RACCommand *cookMode;

@end
NS_ASSUME_NONNULL_END
