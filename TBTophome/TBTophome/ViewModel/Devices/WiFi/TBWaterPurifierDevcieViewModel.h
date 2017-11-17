//
//  TBWaterPurifierDevcieViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/2/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBWaterPurifierDevcieViewModel : TBDeviceViewModel

@property (nonatomic, assign) BOOL power;
@property (nonatomic, assign) NSInteger iTds;
@property (nonatomic, assign) NSInteger oTds;
@property (nonatomic, assign) NSInteger waterPurifierStatus; //净水器状态
@property (nonatomic, assign) NSInteger filterC2Status; //滤芯C2状态
@property (nonatomic, assign) NSInteger filterRoStatus; //滤芯Ro状态
@property (nonatomic, assign) NSInteger waterTimoutStatus; //制水超时状态

/**
 获取设备初始状态
 */
@property (nonatomic, strong, readonly) RACCommand *deviceState;

/**
 冲洗设定
 */
@property (nonatomic, strong, readonly) RACCommand *rinseSetting;

/**
 复位芯片
 */
@property (nonatomic, strong, readonly) RACCommand *resetFilterSetting;

@end
NS_ASSUME_NONNULL_END
