//
//  VihomeTiming.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMTiming : HMBaseModel <OrderProtocol>

@property (nonatomic, retain) NSString *       timingId;

@property (nonatomic, retain) NSString *        name;

@property (nonatomic, retain) NSString *        deviceId;

@property (nonatomic, retain) NSString *        bindOrder;


/**
 *  对于开关型的设备，value1里面填0表示状态为开，填1表示状态为关；
 对于调幅型的设备，value1里面填写的为当前的幅度（亮度）值；
 对于RGB灯：value1填写亮度值，value2填写饱和度值，value3填写色度值；
 对于cluster为0x0102的窗帘：value1填写的是窗帘打开的百分比。0表示关，100表示开，其他值表示停；
 对于门磁、窗磁：value1填写0表示关闭，不需要报警，填写1表示打开，需要报警；value3填写0表示低电量，填写1表示正常电量。
 对于烟感：value1填写0表示不报警，填写1表示报警；value3填写0表示低电量，填写1表示正常电量。
 对于人体红外：value1填写0表示没有报警，填写1表示检测到入侵，需要报警；value2填写1表示入侵的人一直存在，填写0表示没有检测到入侵持续存在；value3填写0表示低电量，填写1表示正常电量。
 对于照度、温湿度传感器：value1填写传感器上报的测量值MeasuredValue。
 */
@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;

@property (nonatomic, assign)int                hour;

@property (nonatomic, assign)int                minute;

@property (nonatomic, assign)int                second;

@property (nonatomic, assign)int                week;

/**
 *  0：表示暂停
    1：表示生效
 */
@property (nonatomic, assign)int                isPause;

@property (nonatomic, assign)int                timingType;
@property (nonatomic, assign)int                resourceId;
@property (nonatomic, assign)int                typeId;
@property (nonatomic, assign)int                isHD;

/** 小方定时 */
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;


/** 雷士日期定时 已在另外的.m 处理*/
@property (nonatomic,strong) NSString * startDate;

@property (nonatomic,strong) NSString * endDate;

/** 模式定时 */
@property (nonatomic, retain) NSString *       timingGroupId;
@property (nonatomic, assign) int showIndex;

/**
 *  判断两个定时任务是否相同
 *
 *  @param timer 定时任务
 *
 *  @return 是否相同 YES：相同 NO：不同
 */
- (BOOL)isEqualtoTimer:(HMTiming *)timer;

/**
 *  根据deviceId获取某个设备的所有定时，按照定时的时间排序
 *
 *  @param deviceId 网关下设备的唯一编号
 *
 *  @return 定时数组,没有定时返回nil
 */
+(NSArray *)timingArrWithDeviceId:(NSString *)deviceId;

/**
 *  根据deviceId获取某个设备所有有效的定时
 *
 *  @param deviceId
 *
 *  @return 有效定时数组,没有定时返回nil
 */
+(NSArray *)availabilityTimingArrWithDeviceId:(NSString *)deviceId;

/**
 *  更新定时有效位
 *
 *  @param isPause 0：暂停    1：生效
 *
 *  @return
 */
+(BOOL)updatePause:(int)isPause timingId:(NSString *)timingId;

/**
 *  删除一个定时
 *
 *  @param timingId
 *
 *  @return
 */
+(BOOL)deleteTimerWithTimingId:(NSString *)timingId;

/**
 *  确定当前设置的定时对应的时间是否与已经设置的定时有冲突
 *
 *  @param hour     当前设置定时的hour
 *  @param minute   当前设置定时的minute
 *  @param newWeek  当前设置定时的周
 *  @param deviceId 设备的deviceId
 *
 *  @return YES:当前设置的定时与已经存在的定时存在冲突，NO:当前设置的定时没有与已经设置的定时存在冲突
 */
+(BOOL)sameHour:(int)hour minute:(int)minute newTimerWeek:(int)newWeek deviceId:(NSString *)deviceId;

/**
 *  编辑定保存时判断
 *
 *  @return YES：存在冲突，  NO：正常
 */
+(BOOL)sameHour:(int)hour minute:(int)minute newTimerWeek:(int)newWeek deviceId:(NSString *)deviceId ignoreTimingId:(NSString *)timingId;

/**
 *  获取对应timingId的对象
 *
 *  @param timingId
 *
 *  @return
 */
+ (HMTiming *)objectWithTimingId:(NSString *)timingId;

/**
 *  获得小方的预约定时
 *
 *  @param deviceId
 *
 *  @return 
 */
+ (NSArray *)appointmentProgramsWithDeviceId:(NSString *)deviceId;

/**
 *  在某时某分是否有预约节目
 *
 *  @param hour
 *  @param minute
 *  @param deviceId
 *  @param name   节目名字
 *  @return
 */
+ (BOOL)isHasOrderProgramInHour:(int)hour minute:(int)minute week:(int)week isHd:(BOOL)isHd deviceId:(NSString *)deviceId name:(NSString *)name;


+ (HMTiming *)orderProgramInHour:(int)hour minute:(int)minute week:(int)week isHd:(BOOL)isHd deviceId:(NSString *)deviceId name:(NSString *)name;


@end
