//
//  ModifyCameraCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifyCameraCmd : BaseCmd

@property (nonatomic, assign)int deviceId;

@property (nonatomic, retain)NSString * deviceName;

@property (nonatomic, assign)int roomId;

@property (nonatomic, retain)NSString * user;

@property (nonatomic, retain)NSString * password;

@end
