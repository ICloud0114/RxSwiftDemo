//
//  NewModifyTimerCmd.h
//  HomeMateSDK
//
//  Created by Feng on 2017/3/3.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface NewModifyTimerCmd : BaseCmd <OrderProtocol>

@property (nonatomic,strong) NSString * name;
@property (nonatomic,retain) NSString * timingId;
@property (nonatomic,strong) NSString *order;
@property (nonatomic,assign) int value1;
@property (nonatomic,assign) int value2;
@property (nonatomic,assign) int value3;
@property (nonatomic,assign) int value4;
@property (nonatomic,assign) int hour;
@property (nonatomic,assign) int minute;
@property (nonatomic,assign) int second;
@property (nonatomic,assign) int week;

@end
