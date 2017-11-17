//
//  ThirdBindCmd.h
//  HomeMate
//
//  Created by orvibo on 16/4/5.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ThirdBindCmd : BaseCmd
@property (nonatomic,strong)NSString *userId;


@property (nonatomic,strong)NSString *thirdId;

@property (nonatomic,strong)NSString *thirdUserName;

@property (nonatomic,strong)NSString *token;

@property (nonatomic,assign)int registerType;

@property (nonatomic,strong)NSString *file;

@end
