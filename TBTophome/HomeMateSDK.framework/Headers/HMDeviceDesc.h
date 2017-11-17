//
//  DeviceDesc.h
//  HomeMate
//
//  Created by liuzhicai on 16/1/13.
//  Copyright © 2016年 Air. All rights reserved.
//

@interface HMDeviceDesc : HMBaseModel

@property (nonatomic, copy)NSString *deviceDescId;

@property (nonatomic, copy)NSString *source;

@property (nonatomic, copy)NSString *model;

@property (nonatomic, copy)NSString *productModel;

@property (nonatomic, copy)NSString *endpointSet;

@property (nonatomic, copy)NSString *picUrl;
@property (nonatomic, assign)int hostFlag;
@property (nonatomic, assign)int wifiFlag; //  0: ZigBee设备 1: WiFi设备 2: 大主机 3: 小主机
// 根据32位标识符能查出对应的设备信息
+ (instancetype)objectWithModel:(NSString *)model;

+ (instancetype)objectFromDictionary:(NSDictionary *)dict;

// 根据 model 获取默认名称
+ (NSString *)defaultNameWithModel:(NSString *)model;

- (BOOL)insertObject;


@end
