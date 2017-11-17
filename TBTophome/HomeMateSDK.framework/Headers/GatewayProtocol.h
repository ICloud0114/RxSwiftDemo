//
//  GatewayProtocol.h
//  HomeMate
//
//  Created by Air on 16/9/21.
//  Copyright © 2016年 Air. All rights reserved.
//

#ifndef GatewayProtocol_h
#define GatewayProtocol_h

@class HMDevice;

@protocol GatewayProtocol <NSObject>

@optional

-(void)popAlert:(NSString *)alert;


/**
 *  VRV面板上报弹框
 */
-(void)showVRVReportView:(NSString *)deviceName;


/**
 *  服务器返回当前操作的设备跟当前账号已无绑定关系
 */
-(void)showDeviceUnbindedTipView;

/**
 *  错误码26对应接口 网关上的数据已不存在
 */
-(void)handleNotExistWithDevcie:(HMDevice *)device;

/**
 *  删除wifi设备上报接口
 */
-(void)handleWifiDevcieDeletedReport:(NSDictionary *)payloadDic;


/**
 *  接收到任意数据时给委托对象的回调
 */
-(void)receiveDataCallback:(NSDictionary *)payloadDic;

/**
 *  接收到推送信息
 */
-(void)handlePushInfo:(NSDictionary *)resultDic;

/**
 *  后台自动登录时，服务器返回用户名密码错误
 */
-(void)popAlertWhenUserNameOrPasswordError;

/**
 *  向服务器查询传感器设备的最新状态（记录）
 */
-(void)queryLastestMsg;

/**
 *  查询主机升级状态
 */
- (void)checkHostUpgradeStatus;


/**
 处理配电箱属性报告
 */
- (void)handleDistBoxStatusReportWithDic:(NSDictionary *)dic;



@end


#endif /* GatewayProtocol_h */
