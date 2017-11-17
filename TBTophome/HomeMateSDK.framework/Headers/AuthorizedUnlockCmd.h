//
//  AuthorizedUnlockCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface AuthorizedUnlockCmd : BaseCmd

/**
 *  门锁编号
 */
@property (nonatomic, strong)NSString * deviceId;

/**
 *  授权手机号
 */
@property (nonatomic, strong)NSString * phone;

/**
 *  授权时间 单位，分钟 UTC
 */
@property (nonatomic, assign)int  time;

/**
 *  授权次数 在有效期内允许开锁的次数。
    填写0的时候表示不限制次数。
 */
@property (nonatomic, assign)int  number;

@end
