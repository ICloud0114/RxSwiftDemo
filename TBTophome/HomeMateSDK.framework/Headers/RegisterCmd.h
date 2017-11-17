//
//  RegisterCmd.h
//  Vihome
//
//  Created by Air on 15-1-24.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface RegisterCmd : BaseCmd

@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *password;

@end
