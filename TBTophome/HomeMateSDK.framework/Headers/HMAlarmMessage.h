//
//  VihomeAlarmMessage.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAlarmMessage : HMBaseModel

/**
 *  主键、自增长
 */
@property (nonatomic, retain)NSString *                messageId;

/**
 *  报警设备编号
 */
@property (nonatomic, retain)NSString *                deviceId;


/**
 *  0 防区报警，3 电量报警。
 */
@property (nonatomic, assign)int                type;


/**
 *  报警时间
 */
@property (nonatomic, assign)int                time;

/**
 *  消息提醒
 */
@property (nonatomic, retain)NSString *         message;


/**
 *  0 未读，1 已读
 */
@property (nonatomic, assign)int                readType;

/**
 *  撤防标志位,0：针对本次报警尚未撤防; 1：针对本次报警已撤防
 */

@property (nonatomic, assign)int                disarmFlag;



@end
