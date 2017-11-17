//
//  HMKKDevice.h
//  HomeMate
//
//  Created by orvibo on 16/4/11.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMKKDevice : HMBaseModel

/**
 *  酷控设备表id
 */
@property (nonatomic, copy) NSString *kkDeviceId;

/**
 *  遥控器id
 */
@property (nonatomic, assign) int rid;

/**
 *  载波频率
 */
@property (nonatomic, assign) int freq;

/**
 *  酷控设备类型
 */
@property (nonatomic, assign) int type;

/**
 *  键码扩展数据
 */
@property (nonatomic, copy) NSString *exts;

@property (nonatomic, copy) NSString *deviceId;

+ (instancetype)objectWithRid:(int)rid deviceId:(NSString *)deviceId;

+ (BOOL)deleteWithDeviceId:(NSString *)deviceId;

@end
