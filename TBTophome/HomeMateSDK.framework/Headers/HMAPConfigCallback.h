//
//  VhAPConfigCallback.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/6.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HMAPConfigCallback <NSObject>

/**
 *	@brief	处理服务器的响应消息
 *
 *	@param 	cmd			命令字
 *	@param 	seq			消息序列号
 *	@param 	msg			响应消息
 *	@param	isTimeout	是否超时
 *	@param	isNetDisconnect 是否网络断开
 *
 *	@return	N/A
 */
-(void)onResponseWithCmd:(int)cmd
                 MsgBody:(NSDictionary*)msg
               IsTimeout:(BOOL)isTimeout
         IsNetDisconnect:(BOOL)isNetDisconnect;
@end
