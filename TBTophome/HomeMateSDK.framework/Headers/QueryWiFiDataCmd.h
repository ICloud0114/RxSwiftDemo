//
//  QueryWiFiDataCmd.h
//  HomeMate
//
//  Created by Air on 16/7/25.
//  Copyright © 2016年 Air. All rights reserved.
//
#import "BaseCmd.h"

@interface QueryWiFiDataCmd : BaseCmd

@property (nonatomic, assign)int LastUpdateTime;

@property (nonatomic, retain)NSString * userId;

@property (nonatomic, retain)NSString * familyId;

@property (nonatomic, assign)int PageIndex;

@property (nonatomic, retain)NSString * dataType;

@end
