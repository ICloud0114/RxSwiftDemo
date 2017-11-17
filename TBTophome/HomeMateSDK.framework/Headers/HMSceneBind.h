//
//  VihomeSceneBind.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"


@interface HMSceneBind : HMBaseModel <SceneEditProtocol>

@property (nonatomic, retain)NSString *        sceneBindId;

@property (nonatomic, retain)NSString *        sceneNo;

@property (nonatomic, retain)NSString *        deviceId;

@property (nonatomic, retain)NSString *         bindOrder;

@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;

@property (nonatomic, assign)int                delayTime;

// 小方以及Allone Pro 创建的虚拟红外设备才有的字段
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;
@property (nonatomic, strong) NSString * actionName;

// 非数据库存储字段，根据编程需要，在查询数据时联合查询出设备楼层和名字

@property (nonatomic, retain)NSString *         deviceName;
@property (nonatomic, retain)NSString *         floorRoom;
@property (nonatomic, retain)NSString *         extAddr;
@property (nonatomic, assign)int                endPoint;
@property (nonatomic, assign)int                deviceType;
@property (nonatomic, assign)KDeviceID          appDeviceId;
@property (nonatomic, retain)NSString *         model;
@property (nonatomic, retain)NSString *         roomId;
@property (nonatomic, retain)NSString *         company;

@property (nonatomic, assign)int                ItemId;


@property (nonatomic, assign) BOOL                selected;

@property (nonatomic, assign,readonly) BOOL       isLearnedIR;

@property (nonatomic, assign,readonly) BOOL       changed;

-(void)copyObj:(HMSceneBind *)obj;

- (NSMutableDictionary *)dictionWithSceneBindObject;

// 选择绑定设备时使用
+ (instancetype)deviceObject:(FMResultSet *)rs;

/**
 根据 device 初始化对象
 */
+ (instancetype)objectWithDevice:(HMDevice *)device;

// 情景编辑设备时使用
+ (instancetype)bindObject:(FMResultSet *)rs;

+ (instancetype)objectWithUID:(NSString *)uid deviceID:(NSString *)deviceId;



@end
