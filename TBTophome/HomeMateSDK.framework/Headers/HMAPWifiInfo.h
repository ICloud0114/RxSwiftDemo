//
//  VHAPWifiInfo.h
//  HomeMate
//
//  Created by Orvibo on 15/8/11.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMAPWifiInfo : NSObject


/**
 *  只有 auth 为 OPEN , enc 为 NONE 时, AP为没有任何加密机制.
 */
@property (nonatomic, copy) NSString * auth;
@property (nonatomic, copy) NSString * enc;


/**
 *  AP热点的mac地址 (无法获取则填空格)
 */
@property (nonatomic, copy) NSString * bssid;


/**
 *  扫描到的SSID
 */
@property (nonatomic, copy) NSString * ssid;

/**
 *  该AP的信道 (无法获取则填0)
 */
@property (nonatomic, assign) NSInteger channel;


/**
 *  信号强度 0~100% 表示
 */
@property (nonatomic, assign) NSInteger rssi;


@property (nonatomic, assign) BOOL isSelected;


- (instancetype)initForDic:(NSDictionary *)dic;

@end
