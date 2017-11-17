//
//  ModifyRemoteBindServiceCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifyRemoteBindServiceCmd : BaseCmd


@property (nonatomic, strong )NSString * deleteRemoteBindId;
@property (nonatomic, strong )NSDictionary * remoteBind;

@end
