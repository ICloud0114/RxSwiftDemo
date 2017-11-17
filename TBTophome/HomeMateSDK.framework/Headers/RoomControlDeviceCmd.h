//
//  RoomControlDeviceCmd.h
//  HomeMate
//
//  Created by JQ on 16/9/18.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface RoomControlDeviceCmd : BaseCmd

/**
 *  如果不传为整个家庭
 */
@property (nonatomic, copy) NSString *roomId;

/**
 *  命令列表, 数组中的元素为字典，key值如下：
 *  deviceType 设备类型
 *  order      控制命令
 *  value1     状态值1
 *  value2     状态值2
 *  value3     状态值3
 *  value4     状态值4
 */
@property (nonatomic, strong) NSArray *orderList;

@end
