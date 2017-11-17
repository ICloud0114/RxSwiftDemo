//
//  ModifyPasswordCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifyPasswordCmd : BaseCmd

@property (nonatomic, retain)NSString * accountName;

@property (nonatomic, retain)NSString * OldPassword;

@property (nonatomic, retain)NSString * NewPassword;

@end
