//
//  ClotheshorseStatus.h
//  HomeMate
//
//  Created by Air on 15/11/18.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"


typedef enum {
    /**
     *  风干
     */
    KStatusTypeWindDry,
    /**
     *  烘干
     */
    KStatusTypeHeatDry,
    /**
     *  照明
     */
    KStatusTypeLight,
    /**
     *  消毒
     */
    KStatusTypeSterilize,
    /**
     *  总控
     */
    KStatusTypeMainCtrl,
    
}KStatusType;


@interface HMClotheshorseStatus : HMBaseModel

@property (nonatomic, strong) NSString *       deviceId;
@property (nonatomic, strong) NSString *       motorState;
@property (nonatomic, strong) NSString *       motorStateTime;

/**
 *  0:上升到顶部
   100:下降到底部
   其余0~100之间的数值为中间位置

 */
@property (nonatomic, assign) NSInteger       motorPosition;
@property (nonatomic, strong) NSString *       motorPositionTime;
@property (nonatomic, strong) NSString *       lightingState;
@property (nonatomic, strong) NSString *       lightingStateTime;
@property (nonatomic, strong) NSString *       sterilizingState;
@property (nonatomic, strong) NSString *       sterilizingStateTime;
@property (nonatomic, strong) NSString *       heatDryingState;
@property (nonatomic, strong) NSString *       heatDryingStateTime;
@property (nonatomic, strong) NSString *       windDryingState;
@property (nonatomic, strong) NSString *       windDryingStateTime;
@property (nonatomic, strong) NSString *       mainSwitchState;
@property (nonatomic, strong) NSString *       mainSwitchStateTime;
@property (nonatomic, strong) NSString *       exceptionInfo;
@property (nonatomic, strong) NSString *       exceptionInfoTime;

+ (HMClotheshorseStatus *)objectWithDeviceId:(NSString *)deviceId;

/**
 *  改变对应设备的状态
 *
 *  @param type     状态类型
 *  @param ctrlTime 控制时间
 *  @param status   功能状态： 1表示开，0 表示关
 *  @param deviceId 设备Id
 */
+ (BOOL)updateStatusType:(KStatusType)type ctrlTime:(NSString *)ctrlTime status:(int)status deviceId:(NSString *)deviceId;
@end
