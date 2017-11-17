//
//  VhDeviceBind.h
//  HomeMate
//
//  Created by Orvibo on 15/8/12.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAPDevice.h"

typedef void(^ BindCallback)(int retunValue,NSDictionary *returnDic);

@interface HMDeviceBind : NSObject
@property (nonatomic, assign) BOOL isStop;

/**
 *  是否取消绑定
 *
 *  @param isStop
 */
- (void)stopBindDevice:(BOOL)isStop;

/**
 *  解绑设备
 *
 *  @param device
 */
- (void)unBindDevice:(HMAPDevice *)device callback:(BindCallback)callback;


/**
 *  绑定设备
 *
 *  @param device
 *  @param callback
 */
- (void)bindDevice:(HMAPDevice *)device callback:(BindCallback)callback;
@end
