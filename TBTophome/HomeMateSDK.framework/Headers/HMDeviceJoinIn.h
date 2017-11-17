//
//  VihomeDeviceJoinIn.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMDeviceJoinIn : HMBaseModel

/**
 *  入网id
 */
@property (nonatomic, retain)NSString *        joinInId;


/**
 *  入网id
 */
@property (nonatomic, retain)NSString *         extAddr;

/**
 *  设备功能
 */
@property (nonatomic, assign)int                capabilities;

/**
 *  激活标志: 0新设备申请入网；1已经查询到设备的有效端点号；2已经查询到了普通设备所有端点的简单描述符，入网成功；3表示IAS Zone报警设备已经查到全部简单描述符，等待注册；4表示IAS Zone设备注册完成，入网成功
 */
@property (nonatomic, assign)int                activeType;

/**
 *  有效端点数量
 */
@property (nonatomic, assign)int                endpointNum;

/**
 *  实际查到的端点数
 */
@property (nonatomic, assign)int                actualNum;


@end
