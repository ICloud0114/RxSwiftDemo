//
//  VihomeAuthority.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAuthority : HMBaseModel


@property (nonatomic, strong)NSString *            authorityId;


@property (nonatomic, strong)NSString *            userId;

/**
 *  0:家庭级 1:房间级
 */
@property (nonatomic, assign)int                    authorityLever;

/**
 *  0:允许使用 1：禁止使用
 */
@property (nonatomic, assign)int                    authorityType;

/**
 *  房间ID
 */
@property (nonatomic, strong)NSString *            roomNo;

@end
