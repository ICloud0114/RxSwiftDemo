//
//  EditTimerCmd.h
//  Vihome
//
//  Created by Ned on 3/25/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifyTimerCmd : BaseCmd <OrderProtocol>
@property (nonatomic,retain)NSString * deviceId;

@property (nonatomic,strong)NSString *bindOrder;
@property (nonatomic,retain)NSString * timingId;
@property (nonatomic,assign)int value1;
@property (nonatomic,assign)int value2;
@property (nonatomic,assign)int value3;
@property (nonatomic,assign)int value4;
@property (nonatomic,assign)int hour;
@property (nonatomic,assign)int minute;
@property (nonatomic,assign)int second;
@property (nonatomic,assign)int week;


@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;


/** 雷士日期定时 已在另外的.m 处理*/
@property (nonatomic,strong) NSString * startDate;

@property (nonatomic,strong) NSString * endDate;

@end
