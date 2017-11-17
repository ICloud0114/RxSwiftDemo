//
//  HMTimingGroupModel.h
//  HomeMate
//
//  Created by Air on 16/7/8.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMTimingGroupModel : HMBaseModel

@property (nonatomic, retain) NSString *timingGroupId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *deviceId;

/* 0暂停，1生效 **/
@property (nonatomic, assign) int isPause;

// 非协议字段
@property (nonatomic, assign) int week;
@property (nonatomic, assign ,readonly) BOOL isChanged;
@property (nonatomic, assign ,readonly) BOOL isNameChanged;
@property (nonatomic, assign ,readonly) BOOL isTimingChanged;

@property (nonatomic, assign ,readonly) BOOL isBeginTimeChanged;
@property (nonatomic, assign ,readonly) BOOL isEndTimeChanged;

@property (nonatomic, assign ,readonly) BOOL isConflict;

@property (nonatomic, strong, readonly) HMTiming *beginTimer;
@property (nonatomic, strong, readonly) HMTiming *endTimer;

@property (nonatomic,strong) NSString *beginTime;
@property (nonatomic,strong) NSString *endTime;


- (void)active:(int)active;

- (NSString *)repeatMode;


+ (NSMutableArray *)allModels:(HMDevice *)device;
+ (instancetype)activeModel:(HMDevice *)device;

@end
