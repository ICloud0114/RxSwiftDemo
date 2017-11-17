//
//  TimerPushCmd.h
//  HomeMate
//
//  Created by liuzhicai on 15/8/24.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface TimerPushCmd : BaseCmd

/**
    0：对所有设备的定时任务的推送设置
    1：对单个设备的定时任务的推送设置。如果存在type为0的设置，则以0的设置为准
 */

@property (nonatomic, assign)int type;

/**
    0：需要推送
    1：不需要推送
 */
@property (nonatomic, assign)int isPush;


/**
    当type为0时，这里填空值
    当type为1时，这里填写的是设备的deviceId。
 */
@property (nonatomic, copy)NSString *deviceId;



@end
