//
//  CmdBase.h
//  Vihome
//
//  Created by Air on 15-1-24.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalSocket.h"

@protocol BaseCmdProtocol <NSObject>

@required

-(NSDictionary *)payload;
@end

@interface BaseCmd : NSObject <BaseCmdProtocol>
{
    @protected
    
    // data send
    NSMutableDictionary *sendDic;
}

// payload
@property (nonatomic,assign) VIHOME_CMD cmd;
@property (nonatomic,assign)int serialNo;

// UID 用于区分 cmd 要发给哪个网关
@property (nonatomic,strong) NSString *uid;

/**
 *  当前登录用户的userName（手机号或邮箱）
 */
@property (nonatomic,strong)NSString *userName;

// 是否指定发送命令到服务器,默认为NO，发送命令到网关
@property (nonatomic,assign) BOOL sendToServer;

/**
 *  此命令被重发的次数
 */
@property (nonatomic,assign)int resendTimes;

/**
 *  时间戳， 主机判断客户端的数据不是最新的话，就返回错误，不允许做修改操作
    41：主机数据已修改，请重新同步最新数据
    42：主机繁忙，请等待30秒之后再重试
 */
@property (nonatomic,strong)NSNumber *lastUpdateTime;

/**
 *  此命令的回调
 */
@property (nonatomic,copy) SocketCompletionBlock finishBlock;

-(instancetype)taskWithCompletion:(SocketCompletionBlock)completion;

+(instancetype)object;
-(NSData *)data; // 适用于UDP广播包，没有session信息
-(NSData *)data:(GlobalSocket *)socket;
-(NSDictionary *)jsonDic;

/******************************数据同步******************************/

/**
 *  当需要数据同步的时候，数据同步（读取表数据）是否成功，只有数据更新成功才能更新系统的lastUpdateTime
 */
@property (nonatomic,assign) BOOL syncDataSuccess;

@property (nonatomic,assign) BOOL needSyncData;

/** 红外控制不重发 */
@property (nonatomic,assign) BOOL onlySendOnce;// 红外控制不重发

/** 此指令发送的时候，后台处于繁忙状态，繁忙时重发指令要增加超时时间 */
@property (nonatomic,assign) BOOL isBusyStatus;

/**
 *  判断哪些命令需要LastUpdateTime参数，而且同步数据后需要更新LastUpdateTime
 *
 *  @return
 */
-(BOOL)needUpdateTime;

/**
 *  重新读表之后更新lastUpdateTime值，再发命令下去
 */
-(void)updateCmdLastUpdateTime;

/**
 *  携带lastUpdateTime的指令，返回的数据里面会携带updateTime，此时要更新系统的LastUpdateTime
 *
 *  @param dic 指令返回的数据
 */
-(void)updateLastUpdateTime:(NSDictionary *)dic;

/**
 *  发送指令后，返回 41错误码 主机数据已修改，请重新同步最新数据 或 70错误码 服务器数据已修改，请重新同步最新数据
 *  时先同步数据，数据同步完成之后，再次发送命令时更新一下流水号，避免服务器返回一分钟内流水号重复
 *  @param dic 指令返回的数据
 */
-(void)updateSerialNo;

@end
