//
//  LeaveFamilyCmd.h
//  HomeMateSDK
//
//  Created by user on 17/2/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface LeaveFamilyCmd : BaseCmd

@property (nonatomic, copy)NSString * userId;
@property (nonatomic, copy)NSString * familyId;

@end
