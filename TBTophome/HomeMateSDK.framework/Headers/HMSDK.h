//
//  HMSDK.h
//  HomeMateSDK
//
//  Created by Air on 16/3/7.
//  Copyright © 2016年 orvibo. All rights reserved.
//

@interface HMSDK : NSObject

/**
 *  服务端推送时会根据appName选择对应的推送证书和密钥向APNS发送推送信息
 *  所以第三方接入时如果需要推送服务，需要提供应用的唯一英文名称和APP发布时使用的推送证书及密钥
 *
 *  @param appName 第三方应用的唯一英文名称
 *
 */
+ (instancetype)initWithAppName:(NSString *)appName;


/**
 *  设置推送的deviceToken，没有此token，server无法准确推送设备执行消息，暂只支持TCP推送
 *
 *  @param deviceToken
 */
+ (void)setDeviceToken:(NSString *)deviceToken;

/**
 *  设置是否开启debug模式
 *
 *  @param enable YES 允许  NO 不允许
 */
+ (void)setDebugEnable:(BOOL)enable;

/**
 *  设置设备描述表的source
 *
 *  @param enable YES 允许  NO 不允许
 */
+ (void)setDescSource:(NSString *)descSource;


/**
 *  根据用户名，密码进行登录，并通过block返回登录结果
 *
 *  @param userName   用户名
 *  @param password   密码
 *  @param completion 返回值
 */

+(void)loginWithUserName:(NSString *)userName password:(NSString *)password completion:(commonBlock)completion;


/**
 *  删除一个指定帐号的所有数据，如果出现数据无法同步的情况，可以执行一次此操作，然后重新登录
 *
 *  @param 用户userId
 */
+(void)deleteAllDataWithUserId:(NSString *)userId;


/**
 *  设置业务层的委托
 */

+(void)setBusinessDelegate:(id <HMBusinessProtocol>)delegate;


@end
