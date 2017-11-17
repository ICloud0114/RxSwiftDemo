//
//  ModifyFamilyUsers.h
//  HomeMateSDK
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModifyFamilyUsersCmd : BaseCmd

@property (nonatomic, copy)NSString * familyUserId;
@property (nonatomic, copy)NSString * nicknameInFamily;


@end
