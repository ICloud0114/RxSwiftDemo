//
//  AddTimerCmd.h
//  Vihome
//
//  Created by Air on 15-3-10.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddTimerCmd : BaseCmd <OrderProtocol>

@property (nonatomic,strong)NSString * deviceId;

@property (nonatomic,strong)NSString *bindOrder;

@property (nonatomic,assign)int value1;
@property (nonatomic,assign)int value2;
@property (nonatomic,assign)int value3;
@property (nonatomic,assign)int value4;
@property (nonatomic,assign)int hour;
@property (nonatomic,assign)int minute;
@property (nonatomic,assign)int second;
@property (nonatomic,assign)int week;

/**
 *  定时类型：
 0 普通定时
 1 模式定时
 2 小方预约

 */
@property (nonatomic,assign)int timingType;


@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;


/** 雷士日期定时 已在另外的.m 处理*/
@property (nonatomic,strong) NSString * startDate;

@property (nonatomic,strong) NSString * endDate;

/**
 *  节目资源id:    节目匹配上的对象加密id。timingType为2时有效
 */
@property (nonatomic, copy) NSString * resourceId;

/**
 *  节目匹配上的对象typeId。timingType为2时有效
 */
@property (nonatomic,assign)int typeId;

/**
 *  是否高清
 0:标清
 1:高清
 与酷控sdk的isHd对应。timingType为2时有效

 */
@property (nonatomic,assign)int isHD;



@end
