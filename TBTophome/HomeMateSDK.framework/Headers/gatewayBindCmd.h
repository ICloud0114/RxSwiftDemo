//
//  gatewayBindCmd.h
//  Vihome
//
//  Created by Air on 15-1-29.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface gatewayBindCmd : BaseCmd

@property (nonatomic, retain)NSString * password;

@property (nonatomic, retain)NSString * phone;

@property (nonatomic, retain)NSString * email;

@property (nonatomic, retain)NSString * userId;

@property (nonatomic, retain)NSString * familyId;

@property (nonatomic, assign)int userType;

@property (nonatomic, assign)int registerType;

@property (nonatomic, retain)NSString * language;

@property (nonatomic, assign)NSInteger utcTime;

@property (nonatomic, assign)NSInteger zoneOffset;

/*
    有夏令时的情况下需要把时区的时间加上夏令时偏移量之后才是真实的时间。
 **/
@property (nonatomic, assign)NSInteger dstOffset;

@end
