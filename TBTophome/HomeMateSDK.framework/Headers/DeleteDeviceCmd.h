//
//  DeleteDeviceCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface DeleteDeviceCmd : BaseCmd

@property (nonatomic, retain)NSString * deviceId;

@property (nonatomic, retain)NSString * extAddr;

@property (nonatomic, assign) BOOL isZigbeeDevice;
@end
