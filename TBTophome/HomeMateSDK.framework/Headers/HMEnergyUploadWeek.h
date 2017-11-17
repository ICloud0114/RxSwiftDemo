//
//  HMEnergyUploadWeek.h
//  HomeMate
//
//  Created by orvibo on 16/7/4.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMEnergyUploadBaseModel.h"

@interface HMEnergyUploadWeek : HMEnergyUploadBaseModel

@property (nonatomic, strong) NSString *energyUploadWeekId;     ///< 按周统计表id
@property (nonatomic, strong) NSString *energy;                 ///< 功耗
@property (nonatomic, assign) int workingTime;                  ///< 工作时长(分钟)
@property (nonatomic, strong) NSString *week;                   ///< 统计周(2016_25)
@property (nonatomic, strong) NSString *deviceId;


+ (NSArray *)readAllWeekEnergyDataWithDevice:(HMDevice *)device;


@end
