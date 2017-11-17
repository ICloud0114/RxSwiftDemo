//
//  LoginCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface LoginCmd : BaseCmd

@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *familyId;
@property (nonatomic,assign)int type;

@end
