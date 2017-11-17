//
//  HMDeviceAPInterface.h
//  HMOpenSDK
//
//  Created by Orvibo on 16/1/14.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMAPDevice;
@class HMAPWifiInfo;

/**
 *  AP 配置过程错误
 */
typedef NS_ENUM(NSInteger, HMDeviceAPErrorCode) {
   
    HMDeviceAPErrorNotDeviceSSID = 100, //连接不是设备WiFi
    
    HMDeviceAPErrorConnectTimeOut, //连接设备超时
    HMDeviceAPErrorWiFiSSIDOrPwdError, //配置WiFiSSID或者密码错误

    HMDeviceAPErrorGetAPDevieceInfoTimeOut, //获取配置设备信息超时
    HMDeviceAPErrorAddDeviceError, // 添加设备出错

    
};

/**
 *  AP 配置状态
 */
typedef NS_ENUM(NSInteger, HMDeviceAPStatus) {
    HMDeviceAPStatusConnectFinish = 200,//连接设备完成
    HMDeviceAPStatusGetAPDevieceInfoFinish,//获取配置设备信息成功
    HMDeviceAPStatusGetOneWiFiFinish,//接收到一个WiFi信息
    HMDeviceAPStatusGetWiFiListFinish,//获取WiFi信息列表完成
    HMDeviceAPStatusAPFinish,//配置完成
    HMDeviceAPStatusAddDeviceFinish,//添加设备完成

};


@protocol HMdeviceAPDelegate <NSObject>

/**
 * 配置过程错误
 *
 *  @param errorCode
 */
- (void)deviceAPConfigError:(HMDeviceAPErrorCode)errorCode;


/**
 * 配置过程
 *
 *  @param errorCode
 */
- (void)deviceAPConfigStatus:(HMDeviceAPStatus)errorCode;

@end

@protocol HMDeviceAPInterface <NSObject>


/**
 *  开始跟设备建立连接
 */
- (void)startConnectToDeviceHost;


/**
 *  判断是不是连接配置设备的SSID
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isAPDeviceSSID;


/**
 *  获取当前连接wifi ssid
 *
 *  @return ssid
 */
- (NSString *)currentConnectSSID;


/**
 *  获取配置设备信息
 *
 *  @return 
 */
- (HMAPDevice *)getAPdevice;


/**
 *  获取WiFi列表,按信号强度排序
 *
 *  @return NSArray HMAPWifiInfo 对象
 */
- (NSArray *)getWiFiList;


/**
 *  配置设备
 *
 *  @param ssid WiFi 名字
 *  @param pwd  WiFi密码
 */
- (void)setDeviceSSID:(HMAPWifiInfo *)selectWiFi withPwd:(NSString *)pwd;


/**
 *  结束AP配置
 */
- (void)stopAPDevice;
@end
