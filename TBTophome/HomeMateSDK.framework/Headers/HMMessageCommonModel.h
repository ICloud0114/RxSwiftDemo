//
//  HMMessageCommonModel.h
//  HomeMateSDK
//
//  Created by liuzhicai on 16/11/17.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface HMMessageCommonModel : HMBaseModel

@property (nonatomic, strong)NSString *messageCommonId;

@property (nonatomic, strong)NSString *userId;

@property (nonatomic, strong)NSString *deviceId;

@property (nonatomic, strong)NSString *text;

@property (nonatomic, strong)NSString *deviceName;

@property (nonatomic, strong)NSString *roomName;


/**
 *  是否已读     0:未读   1：已读
 */
@property (nonatomic, assign)int readType;

/**
 *  1970年1月1号到现在的秒数
 */
@property (nonatomic, assign) int time;

@property (nonatomic, assign) int deviceType;

@property (nonatomic, assign) int value1;
@property (nonatomic, assign) int value2;
@property (nonatomic, assign) int value3;
@property (nonatomic, assign) int value4;

@property (nonatomic, assign) int sequence;

/**
 *  该消息是否进行推送0:不推送 1:推送
 */
@property (nonatomic, assign) int isPush;


/**
 *  当一条消息跟上一条消息处于同一分钟时，隐藏时间
 */
@property (nonatomic, assign)BOOL shouldHideTime;


/**
 *  精确到分钟的时间字符串 （当一条消息跟上一条消息处于同一分钟时，隐藏时间）
 */
@property (nonatomic, copy)NSString * minPreciseTimeStr;


/**
 *  某用户消息的本地最大序号 （默认当前家庭）
 */
+ (int)getMaxSequenceNum;


/**
 *  某用户消息的某一家庭本地最大序号

 @param familyId 
 */
+ (int)getMaxSequenceNumWithFamilyId:(NSString *)familyId;

+ (NSArray *)lastTwentyMsgFromCount:(int)count;

+(int)getUnreadMsgNum;


/**
 首页是否有红点

 @param familyId <#familyId description#>
 */
+(BOOL)isHasHomePageRedInFamilyId:(NSString *)familyId;

+ (BOOL)deleteAllMsg;

+ (void)setAllMsgToHasRead;

/**
 *  判断某消息序号是否有中断
 *
 *  @param sequence 消息序号
 */
+ (BOOL)isHasInterruptMsgAfterSomeSequence:(int)sequence;

/**
 *  获得sequence之后的中断序号
 */
+ (int)getInterruptSequenceAfterSomeSequence:(int)sequence;

+ (NSMutableArray *)getCommonMsgBetweenMinSequence:(int)minSequence maxSequence:(int)maxSequence;

+ (NSMutableArray *)continuousMessageAfterSomeSequence:(int)sequence;

@end
