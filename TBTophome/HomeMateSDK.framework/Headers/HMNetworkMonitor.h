//
//  HMNetworkMonitor.h
//  KeplerSDK
//
//  Created by Ned on 14-7-23.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络状态监视类
 */
@interface HMNetworkMonitor : NSObject

@property (nonatomic , strong) NSString *curSSID;
@property (nonatomic , strong) NSString *hostIP;
@property (nonatomic , assign) NetworkStatus networkStatus;

+ (instancetype)shareInstance;
-(void)startNetworkNotifier;
//-(NSString *)getHostIP;

/**
 *  更新设备列表界面网络状态横幅
 */
- (void)postForNetworkBanner;

+(NSString *)getSSID;

@end
