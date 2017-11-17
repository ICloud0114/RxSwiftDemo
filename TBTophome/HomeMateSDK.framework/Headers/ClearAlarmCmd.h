//
//  ClearAlarmCmd.h
//  HomeMate
//
//  Created by orvibo on 16/8/10.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ClearAlarmCmd : BaseCmd

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, assign) int delayTime;

@end
