//
//  HMSceneExtModel.h
//  HomeMateSDK
//
//  Created by orvibo on 16/10/7.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMSceneExtModel : HMBaseModel

@property (nonatomic, copy, nullable) NSString *sceneNo;
@property (nonatomic, assign) int sequence;

+ (nullable NSArray <HMScene*>*)readAllSceneArray;

- (void)insertObjectWithSceneNo:(nullable NSString *)sceneNo;
- (void)deleteObjectWithSceneNo:(nullable NSString *)sceneNo;

@end
