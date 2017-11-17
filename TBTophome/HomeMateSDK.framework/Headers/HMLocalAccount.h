//
//  LocalAccount.h
//  HomeMate
//
//  Created by Air on 15/8/11.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMLocalAccount : HMBaseModel

@property (nonatomic, strong)NSString *         userId;
/**
 *  一个帐号最后一次登录的帐号名(手机号/邮箱)
 */
@property (nonatomic, strong)NSString *         lastUserName;

/**
 *  每次登录成功都需要更新该时间
 */
@property (nonatomic, assign)int                loginTime;

/**
 *  登录的密码md5
 */
@property (nonatomic, strong) NSString *        password;

/**
 *  兼容第三方登录，同一个userId账号，第三方登录后仍然会把之前登录过的手机号或邮箱显示出来
 *  登录历史记录里面的用户名以这个字段显示
 */
@property (nonatomic, copy) NSString  *compatibleUserName;

/**
 *  获取所有本地的帐号信息
 *
 *  @return 没有返回nil
 */
+ (NSArray *)getAllLocalAccountArr;

/**
 *  用于登录页面，获取所有要显示的账号信息
 *
 *  @return 会过滤掉compatibleUserName为空的账号
 */
+ (NSArray *)getAllFilteredLocalAccountArr;

/**
 *  获取最后一次登录的帐号信息，按最大的登录时间算
 *
 *  @return
 */
+ (HMLocalAccount *)lastAccountInfo;

+(BOOL)updateEmail:(NSString *)email;

+(BOOL)updatePhone:(NSString *)phone;

+(BOOL)updatePassword:(NSString *)password;

/**
 *  通过登录名获取对象
 *
 *  @param name lastUserName/compatibleUserName
 *
 *  @return
 */
+ (instancetype)objectWithUserName:(NSString *)name;

@end 
