//
//  ThirdAccountRegisterCmd.h
//  HomeMate
//
//  Created by orvibo on 16/3/31.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ThirdAccountRegisterCmd : BaseCmd

@property (nonatomic,strong)NSString * country;

@property (nonatomic,strong)NSString *state;

@property (nonatomic,strong)NSString *city;

@property (nonatomic,strong)NSString *thirdId;

@property (nonatomic,strong)NSString *thirdUserName;

@property (nonatomic,strong)NSString *token;

@property (nonatomic,assign)int registerType;

@property (nonatomic,strong)NSString *file;



@end
