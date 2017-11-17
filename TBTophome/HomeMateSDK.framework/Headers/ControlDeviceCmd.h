//
//  ControlDeviceCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ControlDeviceCmd : BaseCmd

@property (nonatomic, retain)NSString * deviceId;

@property (nonatomic, retain)NSString * order;

@property (nonatomic, assign)int value1;
@property (nonatomic, assign)int value2;
@property (nonatomic, assign)int value3;
@property (nonatomic, assign)int value4;
@property (nonatomic, assign)int delayTime;
@property (nonatomic, copy) NSString *model;


@property (nonatomic, assign)BOOL isLevelControl;


/**
 *  是否对整个设备有效。（创维RGB灯）
 *  True:对整个设备有效，而不是对单个端点。
 *  False:对单个端点有效

 */
@property (nonatomic, assign)BOOL forWholeDevice;
/**
 *  客户端在控制RGB灯的时候，如果手还没有离开屏幕的时候qualityOfService和defaultResponse都填写0，其他时候两个参数都填写1
 */

/**
 *  0：不需要重发，不关心是否一定能达到
 
    1：需要重发，保证命令一定能达到设备
 */
@property (nonatomic, assign)int qualityOfService;

/**
 *  0表示不需要默认返回
 
    1表示需要默认返回
 
    APP发送 情景控制命令 时，defaultResponse字段也请填为0，不需要设备默认返回。
 */
@property (nonatomic, assign)int defaultResponse;

/**
 *  当order为ir control的时候有效。其他控制指令的时候填0或者不带这个参数
 *  目前支持范围为20000-60000
 */
@property (nonatomic, assign) int freq;

/**
 *  当order为ir control的时候有效。其他控制指令的时候填空值或者不带这个参数
 *  红外码的时间序列
 */
@property (nonatomic, copy) NSString *pluseData;

/**
 *  表示时间序列的个数
 */
@property (nonatomic, assign) int pluseNum;

/**
 *  0：单播、广播 1：组播
 */
@property (nonatomic,strong) NSNumber * addrMode;

//组播或者是order为添加、删除组的时候这里需要填写组id
@property (nonatomic,strong) NSNumber * groupId;

@end
