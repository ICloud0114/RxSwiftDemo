//
//  Gateway.h
//  Vihome
//
//  Created by Air on 15-1-26.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalSocket.h"
#import "BaseCmd.h"

#import "GatewayProtocol.h"


@class ALData;
@class GroupData;

@interface Gateway : NSObject <GatewayProtocol>

@property(nonatomic,strong) NSString *          uid;
@property(nonatomic,strong) NSString *          host; // host
@property(nonatomic,assign) UInt16              port; // 端口号
@property(nonatomic,strong) NSString *          model;// 设备model
@property(nonatomic,assign) BOOL                mdns; // 是否通过mdns搜索到的设备

// 当前登录类型

@property (nonatomic, assign) LOGIN_TYPE loginType;

// 数据发送
@property (nonatomic, strong) NSMutableDictionary *taskQueue;

// 主机当前状态（是否正在同步数据）
@property (nonatomic, strong) NSMutableDictionary *statusInfo;

@property (nonatomic, weak) id <GatewayProtocol> delegate;

// 数据接收
@property (nonatomic, strong) NSMutableArray *tableQueue;
@property (nonatomic, strong) NSData *receivedData;

// 心跳包 每个网关维持一个心跳包
@property (nonatomic,strong) NSTimer *heartBeatTimer;

@property (nonatomic, strong, readonly) GlobalSocket *socket;
@property (nonatomic,assign) BOOL isSocketConnected;

// 组包属性
@property (nonatomic,strong) GroupData *groupData;
@property (nonatomic,assign) BOOL isGrouping;

@property (nonatomic, strong) NSString *             localSsid;

/**
    本次登录成功后获取到的最新的更新的时间
 */
@property (nonatomic, strong) NSString *             updateTime;

/**
 本次登录成功后获取到的最新的更新的时间
 */
@property (nonatomic, strong) NSNumber *             updateTimeSec;


/**
    上次保存的更新时间，本次登录的时候会使用此值，登录成功后更改此值为最新的值
 */
@property (nonatomic, strong) NSString *             lastUpdateTime;

/**
    指定表使用的更新时间
 */
@property (nonatomic,strong) NSMutableDictionary *   specificTableUpdateTime;

/** 
    使用当前用户名登录时，此网关是否登录成功
 */
@property (nonatomic,assign) BOOL isLoginSuccessful;

/**
 *  用于判断网关是否被重置,当需要一个绑定关系（HMDevicesBind）时赋值给它
 */
@property (nonatomic, assign)int                 versionID;


@property (nonatomic, assign,readonly)BOOL       isHostNotNil;

/**
 *  是否是小主机
 */
@property (nonatomic, assign,readonly)BOOL       isMiniHub;
/**
 *  命令超时时间
 */
@property (nonatomic, assign,readonly)CGFloat     cmdTimeout;

/**
 *  标记大主机还是小主机
 */
@property (nonatomic, assign)KDeviceType        deviceType;

/**
 是否已经尝试过查询能不能绑定某个主机 （多主机绑定用）
 */
@property (nonatomic, assign)BOOL hasTryQuery;

/**
 已被他人绑定
 */
@property (nonatomic, assign)BOOL hasBindByOther;

/**
 已被自己绑定
 */
@property (nonatomic, assign)BOOL hasBindByYourSelf;

/**
 已经绑定成功，通过点击添加按钮
 */
@property (nonatomic, assign)BOOL hasBindSuccess;

/**
 登录超时，绑定主机查询时用，用来刷新
 */
@property (nonatomic, assign)BOOL loginTimeoutWhenBind;

/**
 已被你的其他家庭绑定
 */
@property (nonatomic, assign)BOOL hasBindByYourOtherFamily;

/**
 可以被绑定
 */
@property (nonatomic, assign)BOOL canBeBinded;

/**
    登录成功，改此值为最新的值
 */
- (void)saveLastUpdateTime;
/**
    返回指定表的最新更新时间
 */
- (NSString *)tableUpdateTime:(NSString *)tableName;

/**
 *  监听退出登录
 */
- (void)addLogOffObserver;
- (void)addCancelTaskObserver;
- (void)removeCancelTaskObserver;

- (void)addMdnsObserver;

+ (Gateway *)newGateway;

- (void)disconnect;
- (void)cancelTask; // 取消剩余任务的执行
- (void)sendCmd:(BaseCmd *)cmd completion:(SocketCompletionBlock)completion; // 发送数据


@end
