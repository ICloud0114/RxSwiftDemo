//
//  ClockSyncCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ClockSyncCmd : BaseCmd

@property (nonatomic, retain)NSString * Timezone;

@property (nonatomic, assign)int DST;

@property (nonatomic, assign)int Time;

@end
