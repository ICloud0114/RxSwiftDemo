//
//  CountdownModel.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "HMBaseModel.h"

@interface HMCountdownModel : HMBaseModel

@property (nonatomic, strong) NSString *       countdownId;

@property (nonatomic, strong) NSString *        deviceId;

@property (nonatomic, strong) NSString *        bindOrder;

@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;


@property (nonatomic, assign)int                time;

@property (nonatomic, assign)int                startTime; //UTC 时间


@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;


/**
 *  0：表示暂停
 1：表示生效
 */
@property (nonatomic, assign)int                isPause;

+ (NSArray *)countdownArrWithDeviceId:(NSString *)deviceId;

+ (HMCountdownModel *)objectWithCountdownId:(NSString *)countdownId;

+(BOOL)updatePause:(int)isPause startTime:(int)startTime time:(int)time countdownId:(NSString *)countdownId;


+(BOOL)updatePause:(int)isPause startTime:(int)startTime countdownId:(NSString *)countdownId;

+ (BOOL)updateStartTime:(int)startTime countdownId:(NSString *)countdownId;

+ (BOOL)updateStartTime:(int)startTime time:(int)time countdownId:(NSString *)countdownId;

+ (NSArray *)validCountdownArrWithDeviceId:(NSString *)deviceId;

/**
 *  根据倒计时执行时间排序
 *
 *  @param countArray 装满倒计时对象的数组
 *
 *  @return 返回按执行时间先后顺序排序的数组
 */
+ (NSArray *)sortArrByExecutedTimeWithCountdownArr:(NSArray *)countArray;

+ (BOOL)deleteCountdownObjWithDeviceId:(NSString *)deviceId;

+ (BOOL)deleteCountdownObjWithUid:(NSString *)uid;

// 倒计时个数
+ (int)countDownNumWithDeviceId:(NSString *)deviceId;
@end
