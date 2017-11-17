//
//  RemoteGateway.h
//  Vihome
//
//  Created by Air on 15-3-14.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "Gateway+Send.h"

@interface RemoteGateway : Gateway

+ (instancetype)shareInstance;
// 数据接收
@property (nonatomic, strong) NSMutableArray *sensorTableQueue;
@property (nonatomic, strong) NSMutableArray *wifiTableQueue;

@property(nonatomic,strong,readonly)NSString *session;

-(void)refreshServerIP:(VoidBlock)completion;

@end
