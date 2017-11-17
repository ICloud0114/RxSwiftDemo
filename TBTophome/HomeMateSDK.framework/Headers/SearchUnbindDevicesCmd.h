//
//  SearchUnbindDevicesCmd.h
//  HomeMate
//
//  Created by Air on 15/11/3.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface SearchUnbindDevicesCmd : BaseCmd
/**
 *  填写设备名称：
    S20：wifi插座
    ViH001：新的主机
    Kepler：燃气报警器
    Allone：红外遥控
    E10：CoCo排插
    MiniHub：小网关
    ViH002:链融网关
 
 如果这个参数不填的话表示查找局域网内所有类型的设备，填写了的时候表示查找指定类型的设备。
 */
@property (nonatomic, copy) NSString *deviceType;

@end
