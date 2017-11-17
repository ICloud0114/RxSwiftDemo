//
//  TBHeaterDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBHeaterDeviceViewModel : TBDeviceViewModel

@property (nonatomic, assign) CGFloat currentTemperature; //当前温度
@property (nonatomic, assign) CGFloat setTemperature; //设定温度(25~75)
@property (nonatomic, assign) NSInteger ledBrightness; //led亮度(1~9)
@property (nonatomic, assign) NSInteger heaterStatus; //热水器状态

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;


/**
 设置亮度
 */
@property (nonatomic, strong, readonly) RACCommand *brightnessSetting;

/**
 温度设定
 */
@property (nonatomic, strong, readonly) RACCommand *temperatureSetting;

@end
NS_ASSUME_NONNULL_END
