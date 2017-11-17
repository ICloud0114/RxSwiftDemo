//
//  VihomeDeviceIr.h
//  Vihome
//
//  Created by Air on 15-2-9.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMDeviceIr : HMBaseModel

@property (nonatomic, retain)NSString *     deviceIrId;

@property (nonatomic, retain)NSString *         deviceId;

@property (nonatomic, retain)NSString *         bindOrder;

@property (nonatomic, retain)NSString *         deviceAddress;

@property (nonatomic, assign)int                length;

@property (nonatomic, retain)NSString *         ir;

@property (nonatomic, retain)NSString *         keyName;

- (BOOL)updateObject;

+ (NSArray *)getCorrespondingObjectByDevice:(HMDevice *)device;

- (BOOL)updateObjectWithDeviceID;

+ (HMDeviceIr *)getCorrespondingObjectByOrder:(NSString *)order device:(HMDevice *)device;

+ (int)getMaxInfraredOrderByUID:(NSString *)UID deviceID:(NSString *)deviceID;





@end
