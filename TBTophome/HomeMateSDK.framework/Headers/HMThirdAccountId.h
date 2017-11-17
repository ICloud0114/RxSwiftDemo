//
//  HMThirdAccountId.h
//  HomeMate
//
//  Created by orvibo on 16/3/31.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMThirdAccountId : HMBaseModel

@property(nonatomic,copy)NSString *thirdAccountId;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *thirdId;
@property(nonatomic,copy)NSString *thirdUserName;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *file;
@property(nonatomic,assign)int userType;
@property(nonatomic,assign)int registerType;

+ (NSString *)selectUserIdByThirdId:(NSString *)thirdId;
+ (NSMutableArray *)selectRegisterTypeByUserId:(NSString *)userId;
+ (NSMutableArray *)selectThirdAccountIdByUserId:(NSString *)userId;
+ (NSString *)getUrlStringByUserId:(NSString *)userId;
+ (HMThirdAccountId *)selectThirdAccountByUserId:(NSString *)userId AndRegiseterType:(int )registerType;
@end
