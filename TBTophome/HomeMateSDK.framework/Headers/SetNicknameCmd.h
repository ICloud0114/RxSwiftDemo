//
//  SetNicknameCmd.h
//  CloudPlatform
//
//  Created by orvibo on 15/6/28.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface SetNicknameCmd : BaseCmd

@property (nonatomic, copy) NSString *nickname;

@end
