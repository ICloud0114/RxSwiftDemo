//
//  DeleteTimerCmd.h
//  Vihome
//
//  Created by Ned on 3/25/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface DeleteTimerCmd : BaseCmd

@property (nonatomic,retain)NSString * deviceId;
@property (nonatomic,retain)NSString * timingId;

@end
