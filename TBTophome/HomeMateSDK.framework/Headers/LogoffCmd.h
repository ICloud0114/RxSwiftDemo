//
//  LogoffCmd.h
//  Vihome
//
//  Created by Air on 15-3-16.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface LogoffCmd : BaseCmd

@property (nonatomic, assign)int type;

@property (nonatomic,strong)NSString *token;

@end
