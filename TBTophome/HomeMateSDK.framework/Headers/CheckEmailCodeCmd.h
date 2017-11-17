//
//  CheckEmailCodeCmd.h
//  CloudPlatform
//
//  Created by orvibo on 15/6/28.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface CheckEmailCodeCmd : BaseCmd

@property (nonatomic, copy) NSString *checkEmailCode;
@property (nonatomic, copy) NSString *email;

@end
