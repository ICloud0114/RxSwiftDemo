//
//  HMDeviceAPI.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseAPI.h"

@interface HMDeviceAPI : HMBaseAPI


/**
 获取uid的摄像头类型
 @param uid 摄像头uid
 @return 0：p2p 1,2:萤石 3：小欧 4：云台
 */
+ (NSInteger)cameraType:(NSString *)uid;

/**
 判断p2p摄像头是否已被添加
 
 @param did 摄像头did
 */
+ (BOOL)isHasAddedP2PCameraDid:(NSString *)did;

/**
 添加p2p摄像头
 
 @param chDID 摄像头DID
 @param block 回调添加结果
 */
+ (void)addP2PCameraChDID:(NSString *)chDID result:(KReturnValueBlock)block;


/**
 获取一个在线的主机uid
 
 @return 主机uid
 */
+ (NSString *)onlineHostUid;

@end
