//
//  AlarmLevelChoiceCmd.h
//  HomeMate
//
//  Created by orvibo on 16/8/10.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface AlarmLevelChoiceCmd : BaseCmd

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, assign) int alarmLevel;
@property (nonatomic, assign) int delayTime;

@end
