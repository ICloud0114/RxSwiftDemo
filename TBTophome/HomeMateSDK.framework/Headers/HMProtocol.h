//
//  HMProtocol.h
//  HomeMate
//
//  Created by Air on 16/9/24.
//  Copyright © 2016年 Air. All rights reserved.
//

#ifndef HMProtocol_h
#define HMProtocol_h

#import "GatewayProtocol.h"
#import "SocketSendProtocol.h"
#import "AccountProtocol.h"

@protocol HMBusinessProtocol <GatewayProtocol,SocketSendProtocol,AccountProtocol>

@end

#endif /* HMProtocol_h */
