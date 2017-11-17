//
//  TBLEDLightDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/1/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBLEDLightDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) BOOL powerStatus;
@property (nonatomic, assign) NSInteger red;
@property (nonatomic, assign) NSInteger green;
@property (nonatomic, assign) NSInteger blue;
@property (nonatomic, assign) NSInteger white;


/**
 设备开关机
 */
@property (nonatomic, strong, readonly) RACCommand *power;
/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;
/**
 灯色调节
 */
@property (nonatomic, strong, readonly) RACCommand *colorSetting;
@end
NS_ASSUME_NONNULL_END
