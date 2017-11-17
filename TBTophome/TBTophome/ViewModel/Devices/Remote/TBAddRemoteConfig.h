//
//  TBAddRemoteConfig.h
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//
//添加遥控器配置信息

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBAddRemoteConfig : NSObject

@property (class, nonatomic, copy) NSString *xiaofang_uid; //小方的uid
@property (class, nonatomic, copy) NSString *xiaofang_deviceId; //小方的deviceId

@end
NS_ASSUME_NONNULL_END
