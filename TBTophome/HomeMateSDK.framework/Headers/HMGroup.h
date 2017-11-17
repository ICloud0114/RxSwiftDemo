//
//  HMGroup.h
//  HomeMate
//
//  Created by liqiang on 16/11/9.
//  Copyright © 2016年 Air. All rights reserved.
//

@interface HMGroup : HMBaseModel
@property (nonatomic, strong)NSString * groupId;
@property (nonatomic, strong)NSString * groupName;
@property (nonatomic, strong)NSString * roomId;

@property (nonatomic, assign)int groupNo;
@property (nonatomic, assign)int pic;

@end
