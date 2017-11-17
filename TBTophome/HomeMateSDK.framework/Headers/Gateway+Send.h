//
//  Gateway+Send.h
//  Vihome
//
//  Created by Air on 15-1-27.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "Gateway.h"

@interface Gateway (Send)

- (void)onlySendData:(BaseCmd *)cmd; // 使用场景，调光的时候，需要密集发送多条命令

- (void)didSendCmd:(BaseCmd *)cmd completion:(SocketCompletionBlock)completion;

-(void)resendCmd:(BaseCmd *)cmd reason:(KReturnValue) returnValue;

-(BaseCmd *)getTask:(NSNumber *)serialNo;

-(void)addTask:(BaseCmd *)task;

-(void)removeTask:(BaseCmd *)task;

-(void)cancelALTimeout:(NSNumber *)serialNo;

-(void)ignoreTask:(NSDictionary *)taskInfo;
@end
