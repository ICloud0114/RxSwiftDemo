//
//  StartLearningCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface StartLearningCmd : BaseCmd

@property (nonatomic, retain)NSString * deviceId;

@property (nonatomic, retain)NSString * order;

@property (nonatomic, retain)NSString * keyName;

/**
 *  按键id
 */
@property (nonatomic, assign) int fid;

/**
 *  按键key，如power
 */
@property (nonatomic, copy) NSString * fKey;

/**
 *  按键名称，如电源
 */
@property (nonatomic, copy) NSString * fName;

@end
