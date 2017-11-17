//
//  AccountProtocol.h
//  HomeMate
//
//  Created by Air on 16/9/21.
//  Copyright © 2016年 Air. All rights reserved.
//

#ifndef AccountProtocol_h
#define AccountProtocol_h

@protocol AccountProtocol <NSObject>

@optional

/**
 *  手动登录时，数据同步完成，做其他处理，比如开启定位，弹出提示信息等
 */
-(void)loginFinish:(KReturnValue)value;

/**
 *  如果应用层未实现此方法，则SDK会调用 sendLogoutRequestWithTimeout:completion:
 *  如果应用层已实现此方法，则SDK只会调用委托方法，自己不实现其他内容，故此时需要应用层自己调用
 *  sendLogoutRequestWithTimeout:completion: 并添加 loading 过程。
 *
 *  sendLogoutRequestWithTimeout:completion:方法会向服务器发送退出登录请求，
 *  如果SuccessBlock返回 YES，表示服务器已确认客户端退出登录，服务器不会再向APNS服务器推送设备的状态信息。
 *  返回 NO，表示服务器未确认客户端退出登录，仍然会向当前客户端推送设备的状态信息。
 */
-(void)logoutWithCompletion:(SuccessBlock)completion;

/**
 *  应在退出登录后（包括失败或成功）调用该方法，将会取消下一次启动时自动登录，并清除内存中的各种状态信息
 *  然后会调用应用层的委托方法，应用层应在委托方法里面实现 应用层的清理动作（如果需要的话）
 */
-(void)logoutAccount;


/**
 *  应在返回前台后会重新登录，登录完成后调用
 */
-(void)foregroundLoginFinish;




@end



#endif /* AccountProtocol_h */
