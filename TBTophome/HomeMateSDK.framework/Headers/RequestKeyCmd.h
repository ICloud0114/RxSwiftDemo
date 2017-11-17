//
//  RequestKeyCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface RequestKeyCmd : BaseCmd

@property (nonatomic, retain)NSString * source;

@property (nonatomic, retain)NSString * softwareVersion;
@property (nonatomic, retain)NSString * sysVersion;
@property (nonatomic, retain)NSString * hardwareVersion;
@property (nonatomic, retain)NSString * language;
@end
