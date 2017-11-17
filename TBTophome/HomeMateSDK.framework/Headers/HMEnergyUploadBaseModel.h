//
//  HMEnergyUploadBaseModel.h
//  HomeMate
//
//  Created by orvibo on 16/8/22.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"



@interface HMEnergyUploadBaseModel : HMBaseModel

@property (nonatomic, strong) NSString *showTimeString;
@property (nonatomic, strong) NSString *workingTimeString;
@property (nonatomic, strong) NSString *totalEnergyString;
@property (nonatomic, strong) NSString *averageEnergyString;
@property (nonatomic, strong) NSString *yearString;

+ (NSString *)transformEnergy:(CGFloat)energy;

+ (NSString *)transformWorkingTime:(int)workingTime;

+ (NSString *)particularYearWithCurrentObj:(id)currentObj lastObj:(id)lastObject;

@end
