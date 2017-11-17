//
//  ActivateCountdownCmd.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "BaseCmd.h"

@interface ActivateCountdownCmd : BaseCmd

@property (nonatomic,strong)NSString * countdownId;

@property (nonatomic,assign)int isPause;

@property (nonatomic, assign)int startTime;

@end
