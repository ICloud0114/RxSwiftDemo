//
//  HMFamilyUsers.h
//  HomeMateSDK
//
//  Created by user on 17/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMFamilyUsers : HMBaseModel

@property (nonatomic, copy) NSString *familyUserId;
//@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) int userType;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nicknameInFamily;


+ (NSMutableArray *)selectFamilyUsersByFamilyId:(NSString *)familyId;

@end
