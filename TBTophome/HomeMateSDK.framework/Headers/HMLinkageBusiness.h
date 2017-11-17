//
//  HMLinkageBusiness.h
//  HomeMateSDK
//
//  Created by Air on 2017/5/2.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseBusiness.h"

@interface HMLinkageBusiness : HMBaseBusiness

+ (void)deleteLinkage:(HMLinkage *)linkage completion:(commonBlockWithObject)completion;

+ (void)createLinkageWithName:(NSString *)linkageName conditionList:(NSArray *)conditionList outputList:(NSArray *)outputList completion:(commonBlockWithObject)completion;

@end
