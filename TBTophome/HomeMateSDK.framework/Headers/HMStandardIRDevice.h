//
//  VihomeStandardIRDevice.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMStandardIRDevice : HMBaseModel

@property (nonatomic, retain)NSString *         irDeviceId;

@property (nonatomic, retain)NSString *         company;

@property (nonatomic, retain)NSString *         model;

@end
