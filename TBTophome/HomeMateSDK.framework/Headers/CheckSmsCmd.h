//
//  CheckSmsCmd.h
//  Vihome
//
//  Created by Air on 15-1-29.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface CheckSmsCmd : BaseCmd

@property (nonatomic, retain)NSString * authCode;
@property (nonatomic, retain)NSString * phoneNumber;

@end
