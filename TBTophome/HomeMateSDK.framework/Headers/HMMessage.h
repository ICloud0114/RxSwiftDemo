//
//  PushInfoModel.h
//  HomeMate
//
//  Created by Air on 15/8/20.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

/**
 *  HMMessage表包括以前PushInfo表的字段，以前PushInfo表废弃
 */
@interface HMMessage : HMBaseModel

@property (nonatomic,assign) int            pushInfoId;
@property (nonatomic,strong) NSString *     messageId;
/**
 *  针对指定用户的推送信息
 */
@property (nonatomic,strong) NSString *     userId;

@property (nonatomic,assign) long long     serial;
@property (nonatomic,assign) int            infoType; //0：定时提醒 1：属性报告
@property (nonatomic,strong) NSString *     text;
@property (nonatomic,assign) int            action;
@property (nonatomic,assign) int            pageId;
@property (nonatomic,strong) NSString *     url;


/**
 *  定时类型 infoType为0
 */
@property (nonatomic,strong) NSString *     timingId;
@property (nonatomic,assign) int            status;
@property (nonatomic,strong) NSString *     deviceId;
@property (nonatomic,assign) int            time;
@property (nonatomic,strong) NSString *     bindOrder;
@property (nonatomic,assign) int            value1;
@property (nonatomic,assign) int            value2;
@property (nonatomic,assign) int            value3;
@property (nonatomic,assign) int            value4;

@property (nonatomic,assign) int            online;
@property (nonatomic,assign) int            alarmType;
@property (nonatomic,assign) int           deviceType;

/**
 *  infoType为6
 *  邀请请求的id
 */
@property (nonatomic,strong) NSString *     inviteId;

/**
 *  infoType为7
 *  0：接受邀请
 1：拒绝邀请
 */
@property (nonatomic,assign) int            dealType;

/**
 *  是否已读     0:未读   1：已读
 */
@property (nonatomic,assign) int            readType;



/**
 *  消息cell 时用到
 */
@property (nonatomic, assign)CGFloat cellHeight;

/**
 *  当一条消息跟上一条消息处于同一分钟时，隐藏时间
 */
@property (nonatomic, assign)BOOL shouldHideTime;

/**
 *  精确到分钟的时间字符串 （当一条消息跟上一条消息处于同一分钟时，隐藏时间）
 */
@property (nonatomic, copy)NSString * minPreciseTimeStr;




/**
 *  获取未读信息条数
 *
 *  @return int
 */
+ (int)getUnreadMsgNum;
+(int)getAllMsgNum;
+ (BOOL)isHasSameDataWithSerial:(long long)serial;
+ (int)dealTypeWithInviteId:(NSString *)inviteId;

/**
 *  删除相应设备的消息, app上删除设备时用，传当前userId
 *
 *  @param decice
 *
 *
 */
+ (BOOL)deleteMsgWithDeviceId:(NSString *)deciceId;


// 防止清空后第一次触发收到多条消息，对最新的消息标记删除，其他消息物理删除
+ (BOOL)deleteAllMsg;

///**
// *  获得最新的消息
// *
// *  @param deviceId deviceId
// *
// *  @return 消息对象
// */
//- (instancetype)newestMsgWithDeviceId:(NSString *)deviceId;

+ (void)setAllMsgToHasRead;

+ (void)setSomeDeviceMsgToHasReadWithDeviceId:(NSString *)deviceId;

/**
 *  查找某一设备的最新消息
 *
 *  @param deviceId
 *
 *  @return
 */
+ (HMMessage *)lastestMsgWithDeviceId:(NSString *)deviceId;


/**
 *  从当前count开始的下20条消息  （不包括安防记录）
 *
 *  @param count 当前count
 *
 */
+ (NSArray *)lastTwentyMsgFromCount:(int)count;


@end
