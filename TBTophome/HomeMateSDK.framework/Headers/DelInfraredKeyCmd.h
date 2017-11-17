//
//  DelInfraredKeyCMD.h
//  Vihome
//
//  Created by Ned on 5/8/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface DelInfraredKeyCmd : BaseCmd

@property (nonatomic, copy) NSString * deviceIrId;

@property (nonatomic, copy) NSString * deviceId;

/**
 *  kkIr表中主键
 */
@property (nonatomic, copy) NSString * kkIrId;

/**
 *  设备为小方时需要此字段，只给服务器使用。
 *  type 为 0时按旧逻辑把kkIr表整条数据标记删除，
 *  type为1时只把kkIr表对应的 pluse（红外码序列）字段置为空，表示未学习状态。
 */
@property (nonatomic, assign) int type;

@end
