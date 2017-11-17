//
//  DeviceSearchCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface DeviceSearchCmd : BaseCmd

/**
 *  open：开启搜索功能，开启之后250秒内有效，超过250秒之后自动关闭。
    close：关闭搜索功能
 */
@property (nonatomic, retain)NSString * Type;

@property (nonatomic, retain)NSString * familyId;


@end
