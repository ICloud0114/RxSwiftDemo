//
//  Gateway+Receive.h
//  HomeMate
//
//  Created by Air on 16/5/6.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "Gateway.h"

@interface Gateway (Receive)

- (void)handleUdpTcpData:(NSData *)data socket:(GlobalSocket *)socket;

- (BOOL)socket:(GlobalSocket *)socket didReceiveData:(NSData *)data;

-(void)finishTaskWithStatus:(KReturnValue)status dictionary:(NSDictionary *)dic;

@end
