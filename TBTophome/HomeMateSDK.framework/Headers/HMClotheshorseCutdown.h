//
//  ClotheshorseCutdown.h
//  HomeMate
//
//  Created by Air on 15/11/18.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

typedef enum : NSUInteger {
    KCountDownTimeLight,      // 照明
    KCountDownTimeAirDry,      // 风干
    KCountDownTimeHeatDry,      // 烘干
    KCountDownTimeSterilize      // 消毒
} KCountDownTimeType;


@interface HMClotheshorseCutdown : HMBaseModel

@property (nonatomic, strong) NSString *            deviceId;

@property (nonatomic, assign) NSInteger             clotheshorseCutdownId;

@property (nonatomic, assign) NSInteger             lightingTime;

@property (nonatomic, assign) NSInteger             sterilizingTime;

@property (nonatomic, assign) NSInteger             heatDryingTime;

@property (nonatomic, assign) NSInteger            windDryingTime;

+ (HMClotheshorseCutdown *)objectWithDeviceId:(NSString *)deviceId;

+ (void)updateObjWithDeviceId:(NSString *)deviceId countDownTime:(NSInteger)cdTime countDownType:(KCountDownTimeType)cdType;

@end
