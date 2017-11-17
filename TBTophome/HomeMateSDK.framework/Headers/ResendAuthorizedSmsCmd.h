//
//  ResendAuthorizedSmsCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface ResendAuthorizedSmsCmd : BaseCmd

@property (nonatomic,strong)NSString * deviceId;

@property (nonatomic,strong)NSString *phone;

@end
