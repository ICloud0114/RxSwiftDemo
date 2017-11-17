//
//  HMLevelDelayCmd.h
//  HomeMate
//
//  Created by liuzhicai on 16/3/14.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"


/**
 *  缓亮缓灭命令
 */
@interface HMLevelDelayCmd : BaseCmd


@property (nonatomic, retain)NSString * deviceId;

@property (nonatomic, assign)int delayTime;  // 单位秒:0-30

@property (nonatomic, assign)BOOL isEnable;



@end
