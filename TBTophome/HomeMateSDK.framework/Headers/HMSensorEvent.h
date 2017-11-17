//
//  HMSensorEvent.h
//  HomeMate
//
//  Created by orvibo on 16/8/22.
//  Copyright © 2016年 Air. All rights reserved.
//

@interface HMSensorEvent : HMBaseModel

@property (nonatomic, strong) NSString *sensorEventId;

@property (nonatomic, strong) NSString *deviceId;

@property (nonatomic, assign) int powerStatus;      ///< 供电状态

@property (nonatomic, assign) int deviceStatus;     ///< 设备故障

@property (nonatomic, assign) int muteStatus;       ///< 声音状态

@property (nonatomic, assign) int brightness;       ///< 指示灯亮度百分比

@property (nonatomic, assign) int alarmLevel;       ///< 0: 无报警 1: 报警等级为标准 2: 报警等级为健康 3: 报警等级为绿色

@property (nonatomic, assign) int voiceStatus;      ///< 0: 无声音 1: 正在鸣响

+ (instancetype)objectWithDeviceId:(NSString *)deviceId uid:(NSString *)uid;
+ (instancetype)originObjectWithDeviceId:(NSString *)deviceId uid:(NSString *)uid;

+ (BOOL)deleteWithDeviceId:(NSString *)deviceId;

+ (instancetype)sensorEventWithDictionary:(NSDictionary *)dic;

+ (int)changeHostIntToShowBrightness:(int)originBrightness;
@end
