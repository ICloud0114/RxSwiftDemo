//
//  InviteFamilyResponseCmd.h
//  HomeMateSDK
//
//  Created by user on 17/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface InviteFamilyResponseCmd : BaseCmd

@property (nonatomic, copy)NSString * familyInviteId;

@property (nonatomic, assign)int type;

@end
