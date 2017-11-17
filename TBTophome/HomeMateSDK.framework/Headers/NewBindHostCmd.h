//
//  NewBindHostCmd.h
//  HomeMateSDK
//
//  Created by liuzhicai on 17/3/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface NewBindHostCmd : BaseCmd

@property (nonatomic, copy)NSString *familyId;

@property (nonatomic, retain)NSString * language;

@property (nonatomic, assign)NSInteger zoneOffset;

/*
 有夏令时的情况下需要把时区的时间加上夏令时偏移量之后才是真实的时间。
 **/
@property (nonatomic, assign)NSInteger dstOffset;

@end
