//
//  BanShutOffPowerOnPhoneCmd.h
//  HomeMate
//
//  Created by liuzhicai on 16/7/27.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

/**
 *  禁止手机端关闭电源
 */

@interface BanShutOffPowerOnPhoneCmd : BaseCmd

/**
 *  True:开启
 *  False:关闭
 */
@property (nonatomic, assign)BOOL isEnable;

@property (nonatomic, copy)NSString *deviceId;

@end
