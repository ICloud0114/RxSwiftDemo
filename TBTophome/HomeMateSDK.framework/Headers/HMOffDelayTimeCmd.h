//
//  HMOffDelayTimeCmd.h
//  HomeMate
//
//  Created by liuzhicai on 16/3/14.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

/**
 *  延时关闭命令
 */
@interface HMOffDelayTimeCmd : BaseCmd



@property (nonatomic, retain)NSString * deviceId;

@property (nonatomic, assign)int delayTime;  // 单位秒:0-300秒


@property (nonatomic, assign)BOOL isEnable;


@end
