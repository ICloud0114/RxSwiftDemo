//
//  HMTipsModel.h
//  HomeMate
//
//  Created by orvibo on 16/3/1.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

//typedef void (^TipsBlock)();

@interface HMTipsModel : HMBaseModel

@property (nonatomic, assign) int tipsId;

@property (nonatomic, assign) int tipsVersion;
@property (nonatomic, assign) int deviceType;
@property (nonatomic, assign) int num;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * language;

+(NSMutableArray *)tipsWithDeviceType:(int)deviceType;
+(void)getTipsFromServerWithCompletion:(VoidBlock)finishBlock;

@end
