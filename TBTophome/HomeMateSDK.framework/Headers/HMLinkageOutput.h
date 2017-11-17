//
//  VihomeLinkageOutput.h
//  HomeMate
//
//  Created by Air on 15/8/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"
#import "HMScene.h"

@interface HMLinkageOutput : HMBaseModel <SceneEditProtocol>

/**
 *  主键 UUID
 */
@property (nonatomic, retain)NSString *          linkageOutputId;

/**
 *  外键
 */
@property (nonatomic, retain)NSString *          linkageId;

/**
 *  联动的设备编号
 */
@property (nonatomic, retain)NSString *        deviceId;

/**
 *  布防联动设备的控制指令
 */
@property (nonatomic, retain)NSString *         bindOrder;
/**
 *  布防联动设备的控制值
 */
@property (nonatomic, assign)int                value1;
@property (nonatomic, assign)int                value2;
@property (nonatomic, assign)int                value3;
@property (nonatomic, assign)int                value4;
@property (nonatomic, assign)int                delayTime;
@property (nonatomic, assign)int                outputType;

@property (nonatomic, strong) NSString *       actionName;
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;

/**
 *  非协议字段
 */
@property (nonatomic, retain)NSString *         deviceName;
@property (nonatomic, assign)int                deviceType;
@property (nonatomic, assign)KDeviceID          appDeviceId;
@property (nonatomic, retain)NSString *         model;
@property (nonatomic, retain)NSString *         company;// 厂商
@property (nonatomic, retain)NSString *         extAddr;
@property (nonatomic, assign)int                endPoint;
@property (nonatomic, retain)NSString *         floorRoom;
@property (nonatomic, retain)NSString *         roomId;
@property (nonatomic, assign) BOOL              selected;
@property (nonatomic, assign,readonly) BOOL              isLearnedIR;
@property (nonatomic, assign,readonly) BOOL     changed;


+ (instancetype)deviceObject:(FMResultSet *)rs;

// 情景编辑设备时使用
+ (instancetype)bindObject:(FMResultSet *)rs;


/**
 根据 device 初始化对象
 */
+ (instancetype)objectWithDevice:(HMDevice *)device;

/**
 根据 scene 初始化对象
 */
+ (instancetype)objectWithScene:(HMScene *)scene;


// 联动情景时使用
//+ (instancetype)bindScene:(HMScene *)scene;

-(void)copyInitialValue;
@end
