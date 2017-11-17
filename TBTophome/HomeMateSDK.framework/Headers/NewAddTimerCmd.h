//
//  NewAddTimerCmd.h
//  HomeMateSDK
//
//  Created by Feng on 2017/3/3.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

typedef NS_ENUM(NSUInteger, new_timer_type) {
    new_timer_type_scene = 3,
    new_timer_type_security = 4,
};

@interface NewAddTimerCmd : BaseCmd <OrderProtocol>

@property (nonatomic, strong) NSString * name;//设备动作名称
@property (nonatomic, strong) NSString * deviceId;//定时执行的设备编号（情景定时使用sceneNo，安防定时填写securityId）
@property (nonatomic, strong) NSString * order;
@property (nonatomic, assign) int value1;
@property (nonatomic, assign) int value2;
@property (nonatomic, assign) int value3;
@property (nonatomic, assign) int value4;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;
@property (nonatomic, assign) int week;
@property (nonatomic, assign) int timingType;
@end
