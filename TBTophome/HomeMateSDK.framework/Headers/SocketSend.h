//
//  SocketSend.h
//  ABB
//
//  Created by orvibo on 14-5-22.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketSendProtocol.h"

@interface SocketSend : NSObject

@property (nonatomic, weak) id <SocketSendProtocol> delegate;

+(SocketSend *)shareInstance;

+(void)cancelLoading;

// 只发送数据，不管接收
-(void)onlySendData:(BaseCmd *)cmd;
/**
 *  下面的接口发送失败后直接返回结果，不自动重发
 *
 *  @param cmd
 *  @param completion
 */
- (void)onlySendCmd:(BaseCmd *)cmd completion:(SocketCompletionBlock)completion;

// 下面的接口发送失败后会自动重新登录gateway（本地和远程都会尝试）

- (void)sendCmd:(BaseCmd *)cmd completion:(SocketCompletionBlock)completion;
- (void)sendCmd:(BaseCmd *)cmd loading:(BOOL)loading alertTimeout:(BOOL)alert completion:(SocketCompletionBlock)completion;
- (void)sendCmd:(BaseCmd *)cmd loading:(BOOL)loading alertTimeout:(BOOL)alert delay:(NSTimeInterval)delay  completion:(SocketCompletionBlock)completion;

- (void)sendCmd:(BaseCmd *)cmd delegate:(id)deletage completion:(SocketCompletionBlock)completion;
- (void)sendCmd:(BaseCmd *)cmd delegate:(id)deletage loading:(BOOL)loading alertTimeout:(BOOL)alert  completion:(SocketCompletionBlock)completion;


@end
