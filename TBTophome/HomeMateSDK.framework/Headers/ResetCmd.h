//
//  RestCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ResetCmd : BaseCmd

/**
 *  1：恢复所有数据（包括zigbee网络）
    2：恢复所有数据，只保留zigbee网络
 */
@property (nonatomic, assign)int type;

@end
