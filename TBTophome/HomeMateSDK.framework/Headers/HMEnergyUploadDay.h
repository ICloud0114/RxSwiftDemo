//
//  HMEnergyUploadDay.h
//  HomeMate
//
//  Created by orvibo on 16/7/4.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMEnergyUploadBaseModel.h"

@interface HMEnergyUploadDay : HMEnergyUploadBaseModel

@property (nonatomic, strong) NSString *energyUploadDayId;  ///< 按天统计表id
@property (nonatomic, strong) NSString *energy;             ///< 功耗
@property (nonatomic, assign) int workingTime;              ///< 工作时长(分钟)
@property (nonatomic, strong) NSString *day;                ///< 统计日期(2016-06-16)
@property (nonatomic, strong) NSString *deviceId;


+ (NSArray *)readAllDayEnergyDataWithDevice:(HMDevice *)device;

/**
 *  转换日期字符串
 *  2016-07-01 ---> 7/1
 */
+ (NSString *)tranformDateStringWithString:(NSString *)dateString;

@end
