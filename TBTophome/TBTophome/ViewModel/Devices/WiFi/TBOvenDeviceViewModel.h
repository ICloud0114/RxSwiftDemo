//
//  TBOvenDeviceViewModel.h
//  TBTophome
//
//  Created by zhengyun on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

typedef enum{
    OVEN_STATUS_OFF,
    OVEN_STATUS_ON,
    OVEN_OPERATION_ON,
    OVEN_OPERATION_OFF,
};

typedef struct{
    unsigned char       power           :2;                 /* 电源  */
    unsigned char       oven_lamp       :2;                 /* 炉灯 */
    unsigned char       screen_lock     :2;                 /* 屏锁 */
    unsigned char       reserved        :2;                 /* 保留 */
    
}light_status_t;

NS_ASSUME_NONNULL_BEGIN
@interface TBOvenDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) NSInteger lightStatus;

@property (nonatomic, assign) NSInteger preheatingFlag;
@property (nonatomic, assign) NSInteger startWorkFlag;
@property (nonatomic, assign) NSInteger pauseFlag;
@property (nonatomic, assign) NSInteger stopFlag;
@property (nonatomic, assign) NSInteger increaseTimeFlag;
@property (nonatomic, assign) NSInteger changeTimeFlag;

@property (nonatomic, assign) NSInteger workMode;
@property (nonatomic, assign) NSInteger displayMode;

@property (nonatomic, assign) NSInteger remindTime;//提示时间
@property (nonatomic, assign) NSInteger remainingWorkTime;//剩余时间
@property (nonatomic, assign) NSInteger setWorkTime;
@property (nonatomic, assign) NSInteger setTemp;


/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *ovenState;


/**
 设备开关
 */
@property (nonatomic, strong, readonly) RACCommand *powerControl;


/**
 照明开关
 */
@property (nonatomic, strong, readonly) RACCommand *lightControl;

/**
 屏锁开关
 */
@property (nonatomic, strong, readonly) RACCommand *screenLock;

/**
 预热
 */
@property (nonatomic, strong, readonly) RACCommand *preHeating;


/**
 开始烘烤
 */

@property (nonatomic, strong, readonly) RACCommand *startHeating;

/**
 暂停、继续
 */

@property (nonatomic, strong, readonly) RACCommand *pauseHeating;

/**
 停止
 */

@property (nonatomic, strong, readonly) RACCommand *stopHeating;

/**
 修改时间
 */

@property (nonatomic, strong, readonly) RACCommand *changeTime;

/**
 补时
 */

@property (nonatomic, strong, readonly) RACCommand *timekeeping;


/**
 提醒时间
 */

@property (nonatomic, strong, readonly) RACCommand *alertTime;

@end
NS_ASSUME_NONNULL_END
