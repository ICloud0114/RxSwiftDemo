//
//  RootTransferCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface RootTransferCmd : BaseCmd

@property (nonatomic, retain)NSString * accountName;

@property (nonatomic, retain)NSString * password;

@property (nonatomic, retain)NSString * phone;

@property (nonatomic, retain)NSString * email;

@property (nonatomic, assign)int userType;

@property (nonatomic, assign)int registerType;

@end
