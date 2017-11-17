//
//  AuthorizedCancelCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface AuthorizedCancelCmd : BaseCmd

/**
 *  授权开锁表编号
 */
@property (nonatomic, strong)NSString * authorizedUnlockId;

@end
