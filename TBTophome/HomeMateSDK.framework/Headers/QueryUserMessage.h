//
//  HMQueryUserMessage.h
//  HomeMateSDK
//
//  Created by user on 16/10/11.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface QueryUserMessage : BaseCmd

@property (nonatomic, copy)NSString * familyId;


@property (nonatomic, copy)NSString * userId;

@property (nonatomic, copy)NSString * tableName;

@property (nonatomic, assign)int minSequence;

@property (nonatomic, assign)int maxSequence;

@property (nonatomic, assign)int readCount;


@end
