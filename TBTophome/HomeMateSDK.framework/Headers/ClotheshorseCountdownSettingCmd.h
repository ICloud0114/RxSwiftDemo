//
//  ClotheshorseCountdownSettingCmd.h
//  HomeMate
//
//  Created by Air on 15/11/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ClotheshorseCountdownSettingCmd : BaseCmd

@property (nonatomic, strong)NSString * deviceId;

/**
 *  照明倒计时设置 10~1440 ,单位为1分钟 范围(10min~24h)
    需要设置才带入此项
    填写0表示常亮

 */
@property (nonatomic, assign)NSInteger  lightingTime;

/**
 *  10~180 ,单位为1分钟 范围(10min~3h)
    需要设置才带入此项
 */
@property (nonatomic, assign)NSInteger  sterilizingTime;

/**
 *  烘干倒计时设置 ,10~300 , 单位为1分钟 范围(10min~5h)
 需要设置才带入此项
 */
@property (nonatomic, assign)NSInteger  heatDryingTime;

/**
 *  风干倒计时设置 ,10~1440 , 单位为1分钟 范围(10min~24h)
 需要设置才带入此项
 */
@property (nonatomic, assign)NSInteger  windDryingTime;

@property (nonatomic, assign)BOOL needSterilize;

@property (nonatomic, assign)BOOL needLight;

@property (nonatomic, assign)BOOL needHeatDry;

@property (nonatomic, assign)BOOL needWindDry;



@end
