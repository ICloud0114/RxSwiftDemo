//
//  SocketSendProtocol.h
//  HomeMate
//
//  Created by Air on 16/9/21.
//  Copyright © 2016年 Air. All rights reserved.
//

#ifndef SocketSendProtocol_h
#define SocketSendProtocol_h

@protocol SocketSendProtocol <NSObject>

@optional

-(void)popAlert:(NSString *)alert;

/**
 *  显示默认的loading
 */
-(void)displayLoading;

/**
 *  停止默认的loading
 */
-(void)stopLoading;

@end



#endif /* SocketSendProtocol_h */
