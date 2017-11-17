//
//  TokenReportCmd.h
//  HomeMate
//
//  Created by liuzhicai on 15/8/20.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface TokenReportCmd : BaseCmd

@property (nonatomic, retain)NSString * language;

@property (nonatomic, retain)NSString *phoneToken;

@property (nonatomic, retain)NSString *phoneSystem;

+ (BOOL)toKenIsNull;

@end
