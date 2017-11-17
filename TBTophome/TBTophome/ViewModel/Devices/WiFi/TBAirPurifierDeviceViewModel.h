//
//  TBAirPurifierDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

@interface TBAirPurifierDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) BOOL powerStatus;
@property (nonatomic, assign) NSInteger environmentStatus; //环境状态 0x01(优),0x02（良）,0x03（差）
@property (nonatomic, assign) NSInteger fanSpeed; //风速 挡位0x01---0x05
@property (nonatomic, assign) BOOL swingMode; //摆头模式
@property (nonatomic, copy) NSString *filteringTime; //滤网时间
@property (nonatomic, assign) NSInteger lightBelfMode; //灯带模式
@property (nonatomic, assign) NSInteger timerMode; //定时器模式

/**
 设备开关机
 */
@property (nonatomic, strong, readonly) RACCommand *power;

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;


/**
 定时器设定
 */
@property (nonatomic, strong, readonly) RACCommand *timerSetting;

/**
 风速设定
 */
@property (nonatomic, strong, readonly) RACCommand *fanSpeedSetting;

/**
 风速设定
 */
@property (nonatomic, strong, readonly) RACCommand *swingSetting;

/**
 灯带设定
 */
@property (nonatomic, strong, readonly) RACCommand *lightBelfSetting;
@end
