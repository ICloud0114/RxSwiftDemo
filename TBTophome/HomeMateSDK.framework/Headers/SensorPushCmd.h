//
//  SensorPushCmd.h
//  HomeMate
//
//  Created by Air on 15/10/13.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"
#import "TimerPushCmd.h"

@interface SensorPushCmd : TimerPushCmd

@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, assign)int authorizedId;
@property (nonatomic, assign)int week;
@property (nonatomic, copy)NSString *familyId;
@property (nonatomic, copy)NSString *userId;
/**
 *  用户设置了week，则此字段自动设为yes
 */
@property (nonatomic, assign)BOOL hasWeekValue;

@end
