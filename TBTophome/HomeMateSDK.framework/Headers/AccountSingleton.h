//
//  AccountSingleton.h
//  Vihome
//
//  Created by Air on 15-3-10.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "SingletonClass.h"
#import "AccountProtocol.h"

@interface AccountSingleton : SingletonClass <AccountProtocol>

@property (nonatomic, weak) id <AccountProtocol> delegate;

/**
 *  当前账号对应的userId
 */
@property (nonatomic, strong) NSString                  *userId;

/**
*  当前userId选择的familyId
*/
@property (nonatomic, strong) NSString                  *familyId;

/**
 本次登录时使用的用户名
 */
@property (nonatomic, strong, readonly) NSString        *userName;

/**
 本次登录时输入的密码
 */
@property (nonatomic, strong, readonly) NSString        *password;

@property (nonatomic, strong, readonly) NSString        *email;

@property (nonatomic, strong, readonly) NSString        *phone;

/**
 *  最近一次登录的本地帐号信息LocalAccount对象
 */
@property (nonatomic, strong, readonly) HMLocalAccount    *currentLocalAccount;

/**
 *  最近一次登录的帐号信息VihomeAccount对象
 */
@property (nonatomic, strong, readonly) HMAccount   *currentAccount;

@property (nonatomic, strong ) NSString             *currentUserName;
@property (nonatomic, strong ) NSString             *currentPassword;

/**
 *  判断当前账号是否绑定了zigbee主机
 */
@property (nonatomic, assign) BOOL                  hasZigbeeHost;

/**
 *  判断当前账号是否绑定了Coco排插等wifi类设备
 */
@property (nonatomic, assign) BOOL                  hasWifiDevice;

/**
 *  判断当前账号是否绑定了小方，小方支持其创建的虚拟设备之间的联动
 */
@property (nonatomic, assign) BOOL                  hasMagicCube;

/**
 *  应用是否进入后台
 */
@property (nonatomic, assign) BOOL                  isEnterBackground;

/**
 *  是否处于AP配置模式
 */

@property (nonatomic, assign) BOOL                  isInAPConfiguring;

@property (nonatomic, assign) KReturnValue          serverLoginValue;
@property (nonatomic, assign) KReturnValue          localLoginValue;


/**
 *  持续socket链接，比如要接收验证码的时候退到后台去查看短信，此时不能断开链接
 *  此值为 YES 时退到后台不会主动断开server socket，为NO时退到后台主动断开链接
 */
@property (nonatomic, assign) BOOL                  persistSocketFlag;


/**
 *  保存mdns搜索到的网关
 */
@property (nonatomic, strong) NSMutableDictionary *gatewayDicList;

/**
 *  帐号列表，LocalAccount对象
 */
@property (nonatomic, strong, readonly) NSArray *accountArr;

/**
 *  只要手动登录成功一次，此值即为YES，并会保存在本地。直到用户名密码错误或者手动退出登录时才会重置为NO
 */
@property (nonatomic, assign) BOOL   isLogin;

/**
 *  是否正在登录读取数据，如果是，则不弹窗提示设备被删除
 */
@property (nonatomic, assign) BOOL   isReading;


// 用户是否手动退出登录，如果用户手动退出登录，但是回调block却没有执行完，则在执行block之前即return
@property (nonatomic, assign) BOOL isManualLogout;


/**
 *  上一次手动退出登录时，是否成功通知server，如果成功通知server，在退出登录状态下，server不会推送APNS通知
 *  否则，在退出登录状态下，服务器也会推送APNS通知。此值会保存在本地 UserDefault 里面
 */
@property (nonatomic, assign) BOOL lastLogoutNotifiedServer;

/**
 *  today widget UserDefault
 */
@property (nonatomic, strong) NSUserDefaults *widgetUserDefault;


/**
 当前family 绑定的所有待读表的主机绑定关系 （由 HMDevicesBind 对象组成的数组）
 */
@property (nonatomic, strong)NSMutableArray *hostBindsdArrToRead;

/**
 当前userId 在当前 FamilyId 下面是否拥有管理员权限
 */
@property (nonatomic, assign) BOOL   isAdministrator;

/**
 *  App启动判断是否需要自动登录
 *
 *  @return YES:自动登录   NO:不需要自动登录
 */
-(BOOL)isAutoLogin;

/**
 *  App设置是否自动登录
 *
 *  @param isAutoLogin YES:登录成功设置为YES， 用户点击退出登录按钮设置为NO
 */
-(void)setAutoLogin:(BOOL)isAutoLogin;

/**
 *  登录成功调用该接口
 *
 *  @param userName 填明文用户名
 *  @param password 填md5值
 *  @param type     登录类型
 */
-(void)addLocalAccountWithUserName:(NSString *)userName password:(NSString *)password userId:(NSString *)userId;

/**
 *  根据用户名(非昵称)删除一个帐号,只删除localAccount表中的数据（如果要删除account表中的数据以后修改TODO）
 *
 *  @param userName :填写邮箱或者手机号
 */
-(void)deleteLocalAccountWithUserId:(NSString *)userId;


/**
 *  删除与一个帐号有关的存在数据库的所有数据
 *
 *  @param userId
 */
-(void)deleteAccountWithUserId:(NSString *)userId;


/**
 获得某familyId 的所有主机绑定关系

 @param familyId 
 @return HMDevicesBind 对象组成的数组
 */
- (NSArray *)gatewayBindsOfFamily:(NSString *)familyId;


/**
 *  更新用户昵称
 *
 *  @param nickName 
 */
-(void)updateNickName:(NSString *)nickName;


-(void)logoutWithCompletion:(SuccessBlock)completion;

/**
 *  忘记密码后重置密码，或者修改密码后更新内存中的密码
 */
-(void)updatePassword:(NSString *)password;

/**
 *  修改邮箱后更新数据库
 */
- (void)updateEmail:(NSString *)email;

/**
 *  修改手机号后更新数据库
 */
- (void)updatePhone:(NSString *)phone;

/**
 *  向服务器发送退出登录请求，如果SuccessBlock返回 YES，表示服务器已确认客户端退出登录，
 *  服务器不会向APNS服务器再推送设备的状态信息。返回 NO，表示服务器未确认客户端退出登录，
 *  仍然会向当前客户端推送设备的状态信息
 */

- (void)sendLogoutRequestWithTimeout:(NSTimeInterval)timeout completion:(SuccessBlock)completion;


- (void)saveCurrentLocalAccount:(HMLocalAccount *)account;

@end
