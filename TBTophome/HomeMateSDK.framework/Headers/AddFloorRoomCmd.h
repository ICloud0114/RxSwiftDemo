//
//  AddFloorRoomCmd.h
//  Vihome
//
//  Created by Air on 15-3-6.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "AddFloorCmd.h"

@interface AddFloorRoomCmd : BaseCmd

@property (nonatomic, retain)NSArray * floorArray;
@property (nonatomic, copy)NSString * familyId;

@end

