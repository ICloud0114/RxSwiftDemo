//
//  ABB
//
//  Created by orvibo on 14-3-7.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#ifndef HMConstant_h
#define HMConstant_h


#if HOMEMATE_RELEASE

#define sendCmd(cmd,completion)\
        hm_sendCmd((char *)__FUNCTION__,__LINE__,(char *)__FILE__,cmd,completion)

#define sendLCmd(cmd,loading,completion)\
        hm_sendLCmd((char *)__FUNCTION__,__LINE__,(char *)__FILE__,cmd,loading,completion)

#else

void sendCmd(BaseCmd *cmd,SocketCompletionBlock completion);

void sendLCmd(BaseCmd *cmd,BOOL loading,SocketCompletionBlock completion);

#endif


#import "AccountSingleton.h"

// 网络判断
BOOL isEnable3G();
BOOL isEnableWIFI();
BOOL isNetworkAvailable();


/** 通过mdns 查找网关 */
void searchGatewaysAndPostResult();
void searchGatewaysWtihCompletion(SearhMdnsBlock completion);


/** 返回当前账号绑定的多个zigbee网关的uid 数组 */

NSArray *familyUids();

/** 返回当前账号绑定的多个zigbee网关的uid 拼接成的字符串 */

NSString *uids();

/** 返回当前账号信息 */
AccountSingleton *userAccout();


BOOL isValidString(NSString *string,NSString *regex);   // 给定的字符串是否符合对应的正则
BOOL isValidUID(NSString *uid);                         // 是否是合法的网关UID
Gateway *getGateway(NSString *uid);                     // 根据网关UID获取网关信息
Gateway *getCoco(NSString *uid);                        // 根据coco UID获取网关信息
void removeDevice(NSString *uid);                       // 根据uid 移除内存中的设备信息（退出登录时调用）
NSNumber *getLastUpdateTime(NSString *key);             // 根据uid/familyId获取 主机/家庭 数据的上次最大更新时间
NSMutableData *stringToData(NSString*str ,int len);     // 字符串转成data
NSString *asiiStringWithData(NSData *data);             // data转成string
int byteLength(NSString *text);
NSData *stringAsciiData(NSString*hexString,int length); //把字符串中的字符为对应的 asii码 data

/** 将系统当前时间转为yyyy-MM-dd HH:mm:ss格式 */
NSString *currentTime();//获取系统当前时间，精确到微秒
NSString *currentDay();//获取系统当前日期，精确到天
NSString *getCurrentTime(NSString *dateFormat);//按指定格式获取当前时间


/** 上报deviceToken到服务器 */
void postToken();

/** 返回md5值 */
NSString* md5WithStr(NSString *input);

/** 发送指令（本地和远程都会尝试，指定发送到server的除外）*/
/** 简单调用方法见顶部宏定义 */
void hm_sendCmd(char *func,int line,char *file,BaseCmd *cmd,SocketCompletionBlock completion);

/**  发送指令,可以指定是否loading【loading 规则为，如果0.5s指令未响应，则调用delegate 的 displayLoading 方法】 */
void hm_sendLCmd(char *func,int line,char *file,BaseCmd *cmd,BOOL loading,SocketCompletionBlock completion);


/** 返回设备状态,Zigbee设备取消离线 */
HMDeviceStatus *statusOfDevice(HMDevice *device);

/** 返回本地设备真实状态 */
HMDeviceStatus *realStatusOfDevice(HMDevice *deviceVo);

void didDealWithGatewayReset(NSDictionary *dic,BOOL showAlert);

/**
 *  清除网关相关的所有数据，检测到网关被重置时调用
 */
void cleanGatewayDbData(NSString *uid);

/**
 *  清除掉wifi设备相关的所有数据，wifi设备解绑时调用
 */
void cleanWifiDeviceDataWithFamilyId(NSString *familyId, NSString *uid);

/**
 *  清除当前key对应的lastupdateTime值
 *
 *  @param key
 */
void cleanLastUpdateTime(NSString *key);


/**
 *  新增coco等设备时，添加一份本地的绑定关系，作为数据同步的依据。添加设备成功时调用
 */
void addDeviceBind(NSString *uid,NSString *model);




/** 获取网关/server返回数据的crc校验值 */
unsigned int getCrcValue(NSData *data);

/**
 *  根据uid读取指定的表数据，可能是远程也可能是本地
 *
 *  @param tableName  表名
 *  @param uid
 *  @param completion
 */

void readTable(NSString *tableName,NSString *uid,commonBlock completion);

/**
 *  从server 读取指定设备的所有数据
 *
 *  @param uid        设备uid
 *  @param completion 回调block
 */
void readTableFromServer(BOOL isCoco,NSString *uid,commonBlock completion);


/**
 获得iPhoned的设备型号
 */
NSString *getCurrentDeviceModel();

/**
 获得设备楼层房间名称
 */
NSString *getFloorRoomName(NSString *roomId);

/**
 获得当前uid上次更新的key值
 */
NSString *lastUpdateTimeKey(NSString *uid);
NSString *lastUpdateTimeSecKey(NSString *uid);

/**
 判断网关是否被重置，被重置则清除旧数据
 */
void dealWithGatewayReset(NSDictionary *dic,BOOL showAlert);

/**
 *  判断是不是手机号
 *
 *  @param phoneNum
 *
 *  @return
 */
BOOL isPhoneNumber(NSString *phoneNum);


/**
 *  是否处于远程（非本地）模式，必须登录成功之后，而且包含有主机才能调用此方法
 *
 *  @return
 */

BOOL isRemoteMode();



/**
 *  vicenter - 300 大主机的modelID数组
 *
 *  @return 数组
 */
NSSet *VIHModelIDArray();

/**
 *  vicenter - 300 小主机的modelID数组
 *
 *  @return 数组
 */
NSSet *HubModelIDArray();

/**
 *  vicenter - 300 大，小主机的modelID总数组
 *
 *  @return 数组
 */
NSSet *AllZigbeeHostModel();

/**
 *  modelID 字符串，用来查询一个设备的model是否是主机的model
 *
 *  @return
 */
NSString *HostModelIDs();

/**
 *  modelID 字符串，用来查询一个设备的model是否是WIFI设备的model
 *
 *  @return
 */
NSString *wifiDeviceModelIDs();
/**
 *  晾衣架的modelID数组
 *
 *  @return
 */
NSArray *CLHModelIDArray();

/**
 *  coco的modelID
 *
 *  @return
 */
NSArray *COCOModelIDArray();

/**
 *  S20c 的modelID
 *
 *  @return
 */
NSArray *S20cModelIDArray();


/**
 *  判断当前的model 是否是主机，兼容最新的modelID
 *
 *  @param model 当前设备的model
 *
 *  @return
 */

BOOL isHostModel(NSString *model);

/**
 *  根据model 返回主机的类型，小主机 kDeviceTypeMiniHub 或大主机 kDeviceTypeViHCenter300
 *
 *  @param model
 *
 *  @return
 */
KDeviceType HostType(NSString *model);

/**
 *  根据model 返回设备的类型，主要用在wifi类设备
 *
 *  @param model
 *
 *  @return
 */
KDeviceType deviceTypeWithModel(NSString *model);

/**
 *  是否是wifi设备的model
 *
 *  @param model
 *
 *  @return
 */
BOOL isWifiDeviceModel(NSString *model);

/**
 *  是否是wifi设备的uid
 *
 *  @param 设备的uid
 *
 *  @return
 */
BOOL isWifiDeviceUid(NSString *uid);

/**
 *  所有wifi设备的model
 *
 *  @param model
 *
 *  @return
 */
NSSet *allWifiDeviceModel();

/**
 *  Allone2 的modelID
 *
 *  @return
 */
NSArray *Allone2ModelIDArray();



/**
 *  删除设备命令： wifi设备、zigbee设备不同
 *
 *  @param device 设备
 *
 *  @return 删除设备命令
 */
DeleteDeviceCmd *deleteCmdWithDevice(HMDevice *device);

/**
 *  延时执行，gcd实现
 *
 *  @param delay 延时时间
 *  @param block 执行内容
 */
void executeAfterDelay(NSTimeInterval delay,VoidBlock block);

/**
 *  全局队列异步执行，gcd实现
 *  @param block 执行内容
 */
void executeAsync(VoidBlock block);

/**
 *  通过gcd创建一个会重复执行的timer，gcd实现
 *
 *  @param interval    重复调用的间隔
 *  @param ^shouldStop 停止条件
 *
 *  @return
 */
dispatch_source_t gcdRepeatTimer(NSTimeInterval interval , BOOL(^shouldStop)() , VoidBlock block);

/**
 *  判断一个字符串中是否包含另一个字符串
 *
 *  @param source 源字符串
 *  @param target 是否包含的字符串
 *
 *  @return
 */
BOOL stringContainString(NSString *source,NSString *target);

/**
 *  返回当前是不是汉语环境
 *
 */
BOOL isZh_Hans();

/**
 *  返回当前是不是繁体汉语环境
 *
 */
BOOL isZh_Hant();

/**
 *  保存updateTime
 *
 *  @param dic
 */
void saveUpdateTime (NSDictionary *dic);

/**
 *  判断是不是空字符串
 *
 *  @param string
 *
 *  @return
 */
BOOL isBlankString(NSString * string);


NSDate *dateWithString(NSString *string);

/** 将字符串格式的日期转为现在到1970年的秒数 */
int secondWithString(NSString *string);


/**
 *  根据秒数返回日期字符串
 *
 */
NSString *dateStringWithSec(NSString *second);

/**
 *  设备顺序
 *
 *  @return 顺序数组
 */
NSArray *orderOfDeviceType();

/**
 *  返回当前语言 中文返回 chinese ，其他语言返回 english
 */
NSString *language();


/**
 *  是否是RGBW灯的白光那路
 *
 *  @param device
 *
 */
BOOL isWhiteLightEndPoint(HMDevice *device);

/**
 *  是否是RGBW灯的rgb那路
 *
 *  @param device
 *
 */
BOOL isRGBLightEndPoint(HMDevice *device);


/**
 *  指定URL和超时时间，发起一个 http/https 请求
 */
void requestURL(NSString *URL,NSTimeInterval delayTime, HMRequestBlock block);

/**
 根据 RF 主机的指令码 获取对应的字符串
 */
NSString *getRFClotherHangerStringWithCode(NSInteger code);

/**
 判断当前设备是否是Ember方案的mini主机，Ember Hub 支持一些新功能，NXP 方案的Hub不支持
 */
BOOL isEmberHub(NSString *uid);

#endif
