//
//  SetGroupMemberCmd.h
//  HomeMateSDK
//
//  Created by peanut on 2017/3/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface SetGroupMemberCmd : BaseCmd

@property (nonatomic,strong)NSString * groupId;
@property (nonatomic,strong)NSArray * addList;
@property (nonatomic, strong)NSArray* deleteList;

@end
