//
//  InviteFamilyCmd.h
//  HomeMateSDK
//
//  Created by user on 17/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface InviteFamilyCmd : BaseCmd

@property (nonatomic, copy)NSString * userId;

@property (nonatomic, copy)NSString * familyId;

@property (nonatomic, copy)NSString * familyName;


@end
