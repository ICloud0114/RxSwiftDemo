//
//  SetFrequentlyModeCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface SetFrequentlyModeCmd : BaseCmd

/**
 *  常用模式表编号
 */
@property (nonatomic, strong)NSString * frequentlyModeId;

/**
 *  模式名称
 */
@property (nonatomic, strong)NSString * name;

@property (nonatomic, strong)NSString * order;
@property (nonatomic, assign)int value1;
@property (nonatomic, assign)int value2;
@property (nonatomic, assign)int value3;
@property (nonatomic, assign)int value4;

@end
