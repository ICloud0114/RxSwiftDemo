//
//  AccountVerifyCmd.h
//  HomeMate
//
//  Created by orvibo on 16/4/1.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface AccountVerifyCmd : BaseCmd

@property (nonatomic,strong)NSString * thirdId;

@property (nonatomic,assign)int registerType;



@end
