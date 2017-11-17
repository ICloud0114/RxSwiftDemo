//
//  VhAPConfig.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/5.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAPConfigMsg.h"
#import "HMAPConfigCallback.h"
#import "HMAPDevice.h"
#import "HMApUtil.h"
#import "HMAPDeleteDeviceProtocol.h"

typedef NS_ENUM(NSInteger, VhAPConfigResult) {
    
    VhAPConfigResult_Connected, // 连接设备成功
    VhAPConfigResult_getDeviceInfoFinish,//获取设备信息成功
    VhAPConfigResult_getOneWifi,// 获取一条wifi
    VhAPConfigResult_getWifiListFinish,// 获取wifi列表完成
    VhAPConfigResult_setDeviceFinish,// ap配置完成
    VhAPConfigResult_setDeviceFail,// ap配置失败
    VhAPConfigResult_unbindSuccess,// 解绑成功
    VhAPConfigResult_unbindFail,// 解绑失败
    VhAPConfigResult_bindSuccess,// 绑定成功
    VhAPConfigResult_bindFail,// 绑定失败
    VhAPConfigResult_bindDeviceOffLine,//绑定设备不在线
    
    VhAPConfigResult_modifyNameSuccess,//修改设备名字成功
    VhAPConfigResult_modifyNameFail,//修改设备名字失败
    
    VhAPConfigResult_getDeviceInfoTimeOut,
    VhAPConfigResult_setDeviceTimeOut,
    VhAPConfigResult_getWifiListTimeOut,
    VhAPConfigResult_StopConnectCOCO,
    
    VhAPConfigResult_Success,//通用成功
    VhAPConfigResult_Fail,//通用失败
    VhAPConfigResult_TimeOut,//通用超时
    
    VhAPConfigResult_CanNotConnectToDeviceWiFi,//当手机没有连接设备的WiFi返回这个错误码
    VhAPConfigResult_disconnectSocket, //断开socket连接
    
};



@protocol VhAPConfigDelegate <NSObject>

- (void)vhApConfigResult:(VhAPConfigResult)result;

@optional
/**
 *  3.4.64本地测量模式接口、3.6.23传感器数据上报接口、3.5.14 AP配置剩余时间上报接口 等 通过这个方法返回结果和数据
 *
 *  @param result    VhAPConfigResult_Success、VhAPConfigResult_Fail、VhAPConfigResult_TimeOut
 *  @param cmd       VhAPConfigCmd_LocalMeasurement,VhAPConfigCmd_SENSOR_DATA_REPORT,VhAPConfigCmd_REMAIN_TIME等
 *  @param returnObj
 */
- (void)vhApConfigResult:(VhAPConfigResult)result cmd:(VhAPConfigCmd)cmd returnObj:(id)returnObj;

@end


@interface HMDeviceConfig : NSObject

@property (nonatomic, weak) id <VhAPConfigDelegate> delegate;

@property (nonatomic, assign) HmAPDeviceType apDeviceType;


@property (strong, nonatomic) HMAPDevice * APDevice;
@property (strong, nonatomic) HMDevice * vhDevice;

@property (nonatomic, assign) BOOL stopSetDevice;

@property (nonatomic, assign) BOOL autoRequestWifiList;

@property (nonatomic,assign) BOOL deviceControllerShowSearchResult;

@property (nonatomic, assign) BOOL searchResultAlertHidden; //是否需要隐藏搜索结果的alert default = NO

@property (nonatomic, assign) BOOL isCOorHCHODetecterConnnecting;   ///< CO／HCHO监测仪是否正在连接

/**
 *  重新绑定设备成功后，会自动删除数据库中的数据，其它本地数据由遵循这个协议的类删除
 */
@property (nonatomic, weak) id<HMAPDeleteDeviceProtocol>deleteDataDelegate;

+ (instancetype)defaultConfig;

- (NSString *)getCurrentAPDeviceSSID;


/**
 *  判断是否有COCO
 *
 *  @return
 */
- (BOOL)ishasWifiDevice;

/**
 *  添加所有搜索到的COCO
 *
 *  @param block 结束回调
 */
- (void)addAllSeachCOCO:(void(^)(BOOL isfinish, BOOL success))block;

/**
 *  搜索COCO
 */
- (void)searchUnbindCOCO;
/**
 *  搜索coco结果
 *
 *  @return
 */
- (NSMutableArray *)getSearchCOCOResult;

- (void)removeDeviceArray;


- (void)onTimeout:(HMAPConfigMsg *)msg;

- (BOOL)isORviboDeviceSSID;

/**
 *  请求WiFi列表
 */
- (void)requestWifiListTimeOut:(NSTimeInterval)timeOut;

/**
 *  刷新wifi
 */
- (void)reFreshWiFiList;


/**
 *  停止请求wifi
 */
- (void)stopRequestWiFi;


/**
 *  修改设备名称
 *
 *  @param deveceName
 */
- (void)modifyDeviceName:(NSString *)deviceName;

/**
 *  停止连接
 */
- (void)stopConnectToCOCO;
/**
 *  判断是否连接到COCO
 *
 *  @return
 */
- (BOOL)isConnectedToDevice;

/**
 *  绑定设备
 */
- (void)startBindDevice;

/**
 *  解绑设备,第一次调用这个方法需要给deleteDataDelegate赋值
 */
- (void)startUnBindDevice;
/**
 *  取消绑定
 */
- (void)stopBindDevice;

/**
 *  配置设备wifi
 *
 *  @param ssid
 *  @param pwd
 */
- (void)settingDevice:(NSString *)ssid pwd:(NSString *)pwd timeOut:(NSTimeInterval)timeOut;


/**
 *  获取wifi列表
 *
 *  @return wifi
 */
- (NSMutableArray *)getOrderWifiList;

/**
 *  获取默认SSID
 *
 *  @return 默认ssid
 */
- (NSString *)getDefaultSSID;

/**
 *  保存用户默认SSID
 */
- (void)setDefaultSSID;

/**
 *  判断设备和Wifi名称是否对应
 *
 *  @return
 */
- (BOOL)isCOCOSsid;

/**
 *  获取手机正在连接的ssid
 *
 *  @return ssid
 */
- (NSString *)currentConnectSSID;


/**
 *  断开设备连接
 */
- (void)disConnect;

/**
 *  连接设备
 */
- (void)connetToHost;


/**
 *  绑定成功后，把返回的数据插入到数据库
 */
- (void)insertToDataBase:(NSDictionary *)returnDic isSearch:(BOOL)isSearch;



/**
 *  甲醛、CO 本地测试模式
 *
 *  @param uid     设备uid
 *  @param cmdType 0：开始本地测量模式  1：结束本地测量模式
 */
- (void)localMeasurementWithUid:(NSString *)uid cmdType:(int)cmdType;

/**
 *  一段时间内都不允许再连接Host
 */
- (void)dontConnectHostForAWhile:(NSTimeInterval)littleTime;


@end
