//
//  HMGroupMember.h
//  HomeMate
//
//  Created by liqiang on 16/11/14.
//  Copyright © 2016年 Air. All rights reserved.
//


@interface HMGroupMember : HMBaseModel<SceneEditProtocol>
@property (nonatomic, strong)NSString * groupMemberId;
@property (nonatomic, strong)NSString * deviceId;
@property (nonatomic, strong)NSString * groupId;


// 以下为非协议字段

@property (nonatomic, strong)NSString *         bindOrder;

@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;

@property (nonatomic, assign)int                delayTime;
@property (nonatomic, strong)NSString *         deviceName;
@property (nonatomic, strong)NSString *         floorRoom;
@property (nonatomic, strong)NSString *         roomId;
@property (nonatomic, assign)int                deviceType;
@property (nonatomic, assign) BOOL              selected;
@property (nonatomic, assign,readonly) BOOL     isLearnedIR;
@property (nonatomic, assign,readonly) BOOL     changed;



+ (instancetype)deviceObject:(FMResultSet *)rs;

+ (instancetype)bindObject:(FMResultSet *)rs;

@end
