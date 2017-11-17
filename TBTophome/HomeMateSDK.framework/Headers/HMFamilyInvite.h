//
//  HMFamilyInvite.h
//  HomeMateSDK
//
//  Created by user on 17/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMFamilyInvite : HMBaseModel

@property (nonatomic, copy) NSString *familyInviteId;
//@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *sendUserId;
@property (nonatomic, copy) NSString *receiveUserId;
@property (nonatomic, assign) int status;


@end
