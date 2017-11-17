//
//  DeviceLanguage.h
//  HomeMate
//
//  Created by liuzhicai on 16/1/13.
//  Copyright © 2016年 Air. All rights reserved.
//

@interface HMDeviceLanguage : HMBaseModel

@property (nonatomic, copy)NSString *deviceLanguageId;

// 外键, 设备描述表id或者二维码对照表id的外键
@property (nonatomic, copy)NSString *dataId;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *defaultName;
@property (nonatomic, copy)NSString *manufacturer;
@property (nonatomic, copy)NSString *stepInfo;


+ (HMDeviceLanguage *)objectWithDataId:(NSString *)dataId;

+ (instancetype)objectFromDictionary:(NSDictionary *)dict;
+ (HMDeviceLanguage *)objectWithDataId:(NSString *)dataId sysLanguage:(NSString *)sysLanguage;

- (BOOL)insertObject;

@end
