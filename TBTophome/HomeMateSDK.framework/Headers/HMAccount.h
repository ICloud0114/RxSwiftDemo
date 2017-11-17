//
//  VihomeAccount.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAccount : HMBaseModel

@property (nonatomic, retain)NSString *             userId;

@property (nonatomic, retain)NSString *             userName;

@property (nonatomic, retain)NSString *             password;

@property (nonatomic, retain)NSString *             phone;

@property (nonatomic, retain)NSString *             email;

@property (nonatomic, assign)int                    userType;

@property (nonatomic, assign)int                    registerType;

@property (nonatomic, assign)int                    idc;

@property (nonatomic, retain)NSString *             country;

@property (nonatomic, retain)NSString *             state;

@property (nonatomic, retain)NSString *             city;


/**
 *  当前账号所属的账号，父账号
 */
@property (nonatomic, retain)NSString *             fatherUserId;
/**
 *  更新用户昵称
 *
 *  @param userName
 *
 *  @return
 */
+(BOOL)updateNickName:(NSString *)userName;
/**
 *  根据userId获取当前account表中帐号的信息
 *
 *  @param userId
 *
 *  @return 没有返回nil
 */
+(HMAccount *)viHomeAccountWithUserId:(NSString *)userId;

+(BOOL)updateEmail:(NSString *)email;

+(BOOL)updatePhone:(NSString *)phone;

+(BOOL)updatePassword:(NSString *)password;

+(NSString *)userIdWithName:(NSString *)name;

+(HMAccount *)accountWithName:(NSString *)name;
/**
 *   如果 account 表里面没有当前userId则把当前账号插入信息插入
 *
 *  @param userId
 *  @param userName
 *  @param password
 *
 *  @return
 */
+(void)saveAccountWithUserId:(NSString *)userId name:(NSString *)userName password:(NSString *)password;

/**
 *  返回家庭成员数组
 */
+(NSArray *)familyMemberArray;

/**
 *  删除子账号信息
 *
 *  @param subUserId      子账号userId
 *  @param fatherUserId   主帐号userId
 */
+(BOOL)deleteSubAccountUserId:(NSString *)subUserId fatherUserId:(NSString *)fatherUserId;


@end
