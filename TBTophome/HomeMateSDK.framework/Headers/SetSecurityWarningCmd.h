//
//  SetSecurityWarningCmd.h
//  HomeMate
//
//  Created by orvibo on 16/6/28.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface SetSecurityWarningCmd : BaseCmd

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *securityId;
@property (nonatomic, assign) int warningType;
@property (nonatomic, assign) BOOL warningTypeChange;

/**
 *  warningMemberAddList 新增的打电话成员列表
 *  @key memberSortNum   Int    成员排序字段
 *  @key memberName      string 成员名字
 *  @key memberPhone     string 成员电话
 */
@property (nonatomic, strong) NSArray *warningMemberAddList;

/**
 *  warningMemberModifyList 修改的打电话成员列表 
 *  @key warningMemberId    string      成员id
 *  @key memberSortNum      Int         成员排序字段
 *  @key memberName         string      成员名字
 *  @key memberPhone        string      成员电话
 */
@property (nonatomic, strong) NSArray *warningMemberModifyList;


/**
 *  warningMemberDeleteList 删除的打电话成员列表
 *  @key warningMemberId    string      成员id
 */
@property (nonatomic, strong) NSArray *warningMemberDeleteList;

@end
