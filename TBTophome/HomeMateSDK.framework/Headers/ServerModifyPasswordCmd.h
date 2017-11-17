//
//  ServerModifyPassword.h
//  CloudPlatform
//
//  Created by orvibo on 15/6/28.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ServerModifyPasswordCmd : BaseCmd

@property (nonatomic, copy) NSString *myNewPsd;
@property (nonatomic, copy) NSString *oldPsd;


@end
