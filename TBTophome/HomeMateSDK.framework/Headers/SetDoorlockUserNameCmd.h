//
//  SetDoorlockUserNameCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface SetDoorlockUserNameCmd : BaseCmd
/**
 *  门锁权限表编号
 */
@property (nonatomic, strong)NSString * doorUserId;

/**
 *  用户名称
 */
@property (nonatomic, strong)NSString * name;
@end
