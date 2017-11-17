//
//  ModifyCountdownCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface ModifyCountdownCmd : BaseCmd

@property (nonatomic,strong)NSString * countdownId;

@property (nonatomic,strong)NSString *order;

@property (nonatomic,assign)int value1;
@property (nonatomic,assign)int value2;
@property (nonatomic,assign)int value3;
@property (nonatomic,assign)int value4;
@property (nonatomic,assign)int time;
@property (nonatomic,assign)int startTime;


@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;

@end
