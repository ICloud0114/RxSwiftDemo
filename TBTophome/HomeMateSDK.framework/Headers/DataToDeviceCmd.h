//
//  DataToDeviceCmd.h
//  HomeMateSDK
//
//  Created by liqiang on 16/11/25.
//  Copyright © 2016年 orvibo. All rights reserved.
//

@interface DataToDeviceCmd : BaseCmd

/**
 *  如果是删除帐号跟主机的绑定关系的话，deviceId和extAddr都不用填写 
 *  wifi设备只需要填写uid，不需要填写deviceId
 */

@property (nonatomic, copy) NSString * deviceId;
@property (nonatomic, strong) NSDictionary * payload;

/**
 *  0 : 此命令设备不需要返回包 (异步)
 *  1 : 此命令设备需要返回包 (同步)
 */
@property (nonatomic, assign) int ackRequire;

@end
