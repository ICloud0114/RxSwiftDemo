//
//  SecurityCmd.h
//  HomeMate
//
//  Created by orvibo on 16/3/7.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface SecurityCmd : BaseCmd

@property (nonatomic, copy) NSString *securityId;

@property (nonatomic, copy) NSString *familyId;

/**
 *  0：表示布防
 *  1：表示撤防
 */
@property (nonatomic, assign) int isArm;

@property (nonatomic, assign) int delay;

@end
