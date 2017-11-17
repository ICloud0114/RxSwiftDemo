//
//  TBInductionCookingDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//
//电磁炉

#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBInductionCookingDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) NSInteger stoveHeadCount; //灶头数
@property (nonatomic, assign) BOOL lockKeyStatus; //童锁状态
@property (nonatomic, assign) NSInteger selectedStoveHead; //当前选中的灶头

@property (nonatomic, assign) BOOL st1WorkGearIsMaxPower;
@property (nonatomic, assign) BOOL st1WorkGearIsLowPower;
@property (nonatomic, assign) NSInteger st1WorkGear; //灶头1工作档位
- (NSInteger)st1WorkGear;
@property (nonatomic, assign) NSInteger st1RemainingTimging; //灶头1剩余的定时时间
@property (nonatomic, assign) NSInteger st1FaultCode; //灶头1故障码

@property (nonatomic, assign) BOOL st2WorkGearIsMaxPower;
@property (nonatomic, assign) BOOL st2WorkGearIsLowPower;
@property (nonatomic, assign) NSInteger st2WorkGear; //灶头2工作档位
- (NSInteger)st2WorkGear;
@property (nonatomic, assign) NSInteger st2RemainingTimging; //灶头2剩余的定时时间
@property (nonatomic, assign) NSInteger st2FaultCode; //灶头2故障码

@property (nonatomic, assign) BOOL st3WorkGearIsMaxPower;
@property (nonatomic, assign) BOOL st3WorkGearIsLowPower;
@property (nonatomic, assign) NSInteger st3WorkGear; //灶头3工作档位
- (NSInteger)st3WorkGear;
@property (nonatomic, assign) NSInteger st3RemainingTimging; //灶头3剩余的定时时间
@property (nonatomic, assign) NSInteger st3FaultCode; //灶头3故障码

@property (nonatomic, assign) BOOL st4WorkGearIsMaxPower;
@property (nonatomic, assign) BOOL st4WorkGearIsLowPower;
@property (nonatomic, assign) NSInteger st4WorkGear; //灶头4工作档位
- (NSInteger)st3WorkGear;
@property (nonatomic, assign) NSInteger st4RemainingTimging; //灶头4剩余的定时时间
@property (nonatomic, assign) NSInteger st4FaultCode; //灶头4故障码

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 切换灶头
 */
@property (nonatomic, strong, readonly) RACCommand *switchStoveHead;

/**
 切换灶头档位
 */
@property (nonatomic, strong, readonly) RACCommand *switchStoveHeadGear;


/**
 切换灶头定时时间
 */
@property (nonatomic, strong, readonly) RACCommand *switchStoveHeadTimming;

/**
 童锁
 */
@property (nonatomic, strong, readonly) RACCommand *childLockSetting;
@end
NS_ASSUME_NONNULL_END
