//
//  AddTimingGroupCmd.h
//  HomeMate
//
//  Created by Air on 16/7/8.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface AddTimingGroupCmd : BaseCmd


@property (nonatomic,strong)NSDictionary * timingGroup;
@property (nonatomic,strong)NSArray * timingList;


@end
