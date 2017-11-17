//
//  HMCommonScene.h
//  HomeMateSDK
//
//  Created by liuzhicai on 16/9/29.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMCommonScene : HMBaseModel

@property (nonatomic, retain)NSString *   userId;

@property (nonatomic, retain)NSString *   roomId;

@property (nonatomic, retain)NSString *   sceneNo;

@property (nonatomic, assign)int   sortNum;


+ (NSArray *)commonSceneWithRoomId:(NSString *)roomId;

+ (BOOL)deleteCommonSceneWithRoomId:(NSString *)roomId;

@end
