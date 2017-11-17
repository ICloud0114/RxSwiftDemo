//
//  HMMessageLast.h
//  HomeMate
//
//  Created by liuzhicai on 16/9/26.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

/**
 *  最新消息表，每个设备保留最新的一条消息，主要是传感器、门锁（首页显示用）
 */
@interface HMMessageLast : HMBaseModel


@property (nonatomic,strong) NSString *     messageLastId;
/**
 *  针对指定用户的推送信息
 */
@property (nonatomic,strong) NSString *     userId;

@property (nonatomic,strong) NSString *     deviceId;

/**
 *  消息文字
 */
@property (nonatomic,strong) NSString *     text;

/**
 *  是否已读     0:未读   1：已读
 */
@property (nonatomic,assign) int            readType;


/**
 *  1970年1月1号到现在的秒数
 */
@property (nonatomic,assign) int            time;

@property (nonatomic,assign) int           deviceType;

@property (nonatomic,assign) int            value1;
@property (nonatomic,assign) int            value2;
@property (nonatomic,assign) int            value3;
@property (nonatomic,assign) int            value4;

@property (nonatomic,assign) int            sequence;

/**
 *  该消息是否进行推送0:不推送 1:推送
 */
@property (nonatomic,assign) int            isPush;

/**
 *  在线状态，该属性不存入数据库。
 */
@property (nonatomic, assign) BOOL isOnline;

/**
 *  当前账号下的数据量
 */
+ (NSInteger)dataNum;

+ (instancetype)objectWithDeviceId:(NSString *)deviceId;

/**
 *  获取指定设备类型中最新的数据
 *
 *  @param deviceTypeString 格式：@"1,2,3,4,5"
 *  @param roomId 可选
 */
+ (instancetype)latestObjWithDeviceTypeString:(NSString *)deviceTypeString roomId:(NSString *)roomId;


@end



