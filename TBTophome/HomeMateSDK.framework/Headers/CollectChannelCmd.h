//
//  CollectChannelCmd.h
//  HomeMate
//
//  Created by orvibo on 16/7/20.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface CollectChannelCmd : BaseCmd

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, assign) int channelId;
@property (nonatomic, assign) int isHd;
@property (nonatomic, strong) NSString *countryId;



@end
