//
//  AuthorizedUnlock.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "HMBaseModel.h"

@interface HMAuthorizedUnlockModel : HMBaseModel

@property (nonatomic, strong) NSString * authorizedUnlockId;

/**
 *  被授权的门锁编号
 */
@property (nonatomic, strong) NSString * deviceId;

/**
 *  授权id
 */
@property (nonatomic, assign) int authorizedId;

/**
 *  授权手机号
 */
@property (nonatomic, strong) NSString * phone;

/**
 *  单位，分钟 UTC时间
 */
@property (nonatomic, assign) int time;

/**
 *  在有效期内允许开锁的次数。
    填写0的时候表示不限制次数。
 */
@property (nonatomic, assign) int number;

/**
 *  UTC时间
 */
@property (nonatomic, assign) int startTime;

/**
 *  已开锁次数
 */
@property (nonatomic, assign) int unlockNum;

/**
 *  0：正常授权
    1：超过有效期
    2：超过最大次数限制
    3：手工取消授权
 */
@property (nonatomic, assign) int authorizeStatus;

/**
 *  获取最近一次授权的用户信息
 *
 *  @param deviceID
 *
 *  @return
 */
+(HMAuthorizedUnlockModel *)SelectRecentUserWithDeviceId:(NSString *)deviceId;


@end
