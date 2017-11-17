//
//  ActiveTimingGroupCmd.h
//  HomeMate
//
//  Created by Air on 16/7/8.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ActiveTimingGroupCmd : BaseCmd

@property (nonatomic, strong)NSString * timingGroupId;

@property (nonatomic, assign) int isPause;

@end
