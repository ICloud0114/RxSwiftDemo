//
//  ModifyGroupCmd.h
//  HomeMateSDK
//
//  Created by peanut on 2017/3/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface ModifyGroupCmd : BaseCmd

@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, assign) int pic;

@end
