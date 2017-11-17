//
//  AddGroupCmd.h
//  HomeMateSDK
//
//  Created by peanut on 2017/3/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface AddGroupCmd : BaseCmd
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, assign) int pic;
@end
