//
//  VihomeDevice.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"


@interface HMDevice : HMBaseModel 

@property (nonatomic, retain)NSString *         deviceId;

@property (nonatomic, retain)NSString *         extAddr;

/**
 *  设备端口号
 */
@property (nonatomic, assign)int                endpoint;

/**
 *  ProfileID
 */
@property (nonatomic, assign)int                profileID;

/**
 *  ProfileID
 */
@property (nonatomic, retain)NSString *         deviceName;

/**
 *  appDeviceID
 */
@property (nonatomic, assign)KDeviceID          appDeviceId;

/**
 *  设备类型
 */
@property (nonatomic, assign)KDeviceType        deviceType;

/**
 *  设备子类型(传感器接入模块)
 */
@property (nonatomic, assign)KDeviceType        subDeviceType;

/**
 *  防区ID 对于appDeviceId为0x0402的安防设备，需要给每个设备分配一个zoneId，zoneId不能重复，取值范围为1到255
 */
@property (nonatomic, assign)int                zoneId;

/**
 *  所属房间编号
 */
@property (nonatomic, retain)NSString *         roomId;

/**
 *  标准红外设备表外键，如果是红外设备，而且使用码库的话，此字段有效，填写大于0的值。其他无效的时候填写为0.
 *  Allone2下面创建的红外设备这里填写rid
 */
@property (nonatomic, retain)NSString *          irDeviceId;

/**
 *  设备的生产厂商，我们自己的设备填写成orvibo，接入的其他公司产品填写其他公司的名称
 *  Allone2下面创建的红外设备这里填写的数据格式为：spType,spId,areaId,brandId,countryId
 *  spType:运营商类型[0:普通有线,1:IPTV]
 *  -1表示是自己创建的可学习的Allone红外遥控器
 */
@property (nonatomic, retain) NSString *         company;

@property (nonatomic, retain) NSString *         model;
@property (nonatomic, retain) NSString *         version;


@property (nonatomic, retain) NSString *         floorId;

/**
 *  常用设备标识   1-常用； 0 - 不常用
 */
@property (nonatomic, assign)int commonFlag;

//  是否需要提醒  1-不提醒； 0 - 提醒
@property (nonatomic, assign)int energySaveFlag;

/**
 *  排序的权值
 */
@property (nonatomic, readonly)NSUInteger       weightedValue;
/**
 *  设备管理列表排序使用   格式："UID_FloorID_roomID" e.g. @"00034328982d_1_2"
 */
@property (nonatomic, copy)NSString *           sortKey;

/**
 *  根据model类型获取设备数组
 *
 *  @param model 如COCO, SOC，E10
 *
 *  @return 如果找不到返回nil
 */
+ (NSArray *)wifiDeviceArray;

//新增
/**
 *  作用于视图显示时给每个设备一个序号
 */
@property (nonatomic, assign) int               serialNumber;

/**
 *  设备本地排序序号 （首页2.0用到）
 */
@property (nonatomic, assign) int               nactiveSortNum;

/**
 *  判断当前设备是不是情景面板、遥控器、随意贴等其他设备
 *
 */
@property (nonatomic, assign)BOOL                isOtherDevice;


/**
 如果设备是配电箱类型，则用到此字段
 */
@property (nonatomic, assign)int distBoxSortNum;

/**
 是否禁止节能提醒推送   YES: 不推送  NO：推送
 */
@property (nonatomic, assign)BOOL isForbidEnergySavePush;

/**
 是否开关   YES: 开  NO：关
 */
@property (nonatomic, assign)BOOL isOn;

/**
 *  判断当前设备是不是wifi 类设备 coco，S20，一栋等
 *
 *  @return
 */
@property (nonatomic, assign)BOOL                isWifiDevice;

@property (nonatomic, assign) BOOL               isControlling;

+ (instancetype)objectWithDeviceId:(NSString *)deviceId uid:(NSString *)uid;
+ (instancetype)objectWithUid:(NSString *)uid;
+ (NSArray *)deviceWithSameExtAddress:(HMDevice *)device;
+ (NSArray *)deviceArrWithSameAppDeviceId:(int)appDeviceId;
+ (instancetype)objectWithUid:(NSString *)uid deviceType:(KDeviceType)deviceType;
+ (NSString *)versionWithDeviceId:(NSString *)deviceId ;
+ (NSArray *)deviceArrWithUid:(NSString *)uid;
/**
 *  更新设备的名称
 *
 *  @param name     新的名称
 *  @param deviceId 设备id
 *
 *  @return
 */
+(BOOL)updateDeviceName:(NSString *)name deviceId:(NSString *)deviceId;

/**
 *  根据设备的mac地址更新设备的名称
 */
+(BOOL)updateDeviceName:(NSString *)name extAddr:(NSString *)extAddr;

/**
 *  根据设备的mac地址更新设备的房间
 */
+(BOOL)updateRoomId:(NSString *)roomId extAddr:(NSString *)extAddr;


+(KDeviceType)deviceTypeWithDeviceId:(NSString *)deviceId;

+(NSString *)deviceNameWithDeviceId:(NSString *)deviceId;

+(NSString *)deviceNameWithExtAddr:(NSString *)extAddr differentDeviceId:(NSString *)deviceId;

/**
 *  除了删除设备自己外，还删除相关联的设备
 *
 *  @return
 */
-(BOOL)deleteObjectAndRelatedObject;

/**
 *  搜索设备时先删除当前设备的旧数据，再插入新数据
 *
 *  @return
 */
- (BOOL)deleteObjectOnSearchDevice;

/**
 *  常用设备
 *
 *  @return 常用设备数组
 */
+ (NSArray *)commonUseDevices;

/**
 *  查找所有房间中能被选择作为常用设备的设备数组， 包括已是常用设备的设备
 *
 *  @return
 */
+ (NSArray *)devicesToChooseForCommonUse;


/**

 *  获取设备的roomId
 *
 *  @return
 */
+(NSString *)roomIdByUid:(NSString *)uid deviceId:(NSString *)devcieId;



/**
 *  查找某一房间中能被选择作为常用设备的设备数组， 包括已是常用设备的设备

 *
 *  @param roomId 某一房间Id
 *
 *  @return 
 */
+ (NSArray *)devicesToChooseForCommonUseWithRoomId:(NSString *)roomId;

/**
 *  判断设备是否是常用设备
 *
 *  @param deviceId
 *
 *  @return 
 */
+ (BOOL)isComonUseDeviceWithDeviceId:(NSString *)deviceId;

/**
 *  查找wifi设备，重配后deviceId，uid都不变
 *
 *  @param uid 设备uid
 *
 *  @return
 */
+ (instancetype)wifiObjectWithUid:(NSString *)uid;

//// 需要节能提醒的设备 : 所有开着的灯光类设备 (***2.0用***)

+ (NSArray *)devicesNeedToEnergyTipV2;

////// 需要节能提醒的设备 : 所有开着的灯光类设备
//+ (NSArray *)devicesNeedToEnergyTip;

// 灯光类设备 ： 调光灯、色温灯、RGB 灯、普通灯
+ (NSArray *)lightDevices;

// 灯光设备的个数
+ (int)lightDeviceCount;

// 是否需要节能提醒
+ (BOOL)isNeedEnergySaveTip:(NSString *)deviceId;

/**
 *  得到所有可以绑定电源按键的的电视
 *
 *  return nil表示没有电视
 */
+ (NSArray *)allTheTVCanBeBoundArrayWithUid:(NSString *)uid;


// 使用事务插入数据库
-(BOOL)insertObjectWithSqlite: (sqlite3*)sqliteHandle;

/**
 *  删除小方所有虚拟设备存储在数据库中的数据
 */
+ (void)deleteAllRelatedObjectDBDataWithUid:(NSString *)uid;

/**
 *  删除小方的一个虚拟设备存储在数据库中的数据
 */
+ (void)deleteTheRelatedObjectDBData:(HMDevice *)device;

/**
 *  根据设备类型和model获取设备的总数量
 *
 *  @param deviceType
 *  @param model
 *
 *  @return 
 */
+ (NSInteger)numberOfDeviceType:(KDeviceType)deviceType model:(NSString *)model;

/**
 *  查出创维RGBW的w那路设备  （RGBW分为两路，rgb一路，w一路）
 *
 *  @param extAddr RGB那路的mac地址
 *
 *  @return
 */
+ (HMDevice *)chuangweiWDeviceWithExtAddr:(NSString *)extAddr;

/**
 *  查出创维RGBW的rgb那路设备  （RGBW分为两路，rgb一路，w一路）
 *
 *  @param extAddr extAddr W那路的mac地址
 *
 *  @return
 */
+ (HMDevice *)chuangweiRgbEndPointDeviceWithExtAddr:(NSString *)extAddr;

/**
 *  某分控的主配电箱即端点1-有数据 , 端点0是主机用的-没数据，客户端忽略
 *  端点2-17是16个分控
 */
+ (HMDevice *)mainDistBoxWithExtAddr:(NSString *)extAddr;


/**
 *  查找是否有设备未设置房间
 */
+ (BOOL )thereIsDeviceInDeafaultRoom;

/**
 *  获取国家id，用于小方虚拟遥控器,获取码库需要用到countryId
 *
 *  @param company 小方下面创建的红外设备数据格式为：spType,spId,areaId,brandId,countryId
 */
- (NSString *)getCurrentDeviceCountryId;
/**
 *  查找是否没有房间也没有设备
 */
+ (BOOL)notExsitDeviceAndRoom;


/**
 获取光照传感器中的灯设备的 deviceId
 */
+ (NSString *)getLightSensorDeviceIdWithExtAddr:(NSString *)extAddr;

/**
 获取光照传感器中人体设备的 deviceId
 */
+ (NSString *)getHumanSensorDeviceIdWithExtAddr:(NSString *)extAddr;

/**
 *  查找设备所处位置
 */
+ (NSString *)selectDevicePositionByDevice:(HMDevice *)device;


@end
