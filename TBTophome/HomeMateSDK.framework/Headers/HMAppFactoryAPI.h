//
//  HMAppFactoryAPI.h
//  HomeMateSDK
//
//  Created by liqiang on 17/5/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

// 智能开关
static NSString * const addDeviceSwitchDefault = @"homemate://addDevice/switch/switchDefault";

// 智能照明
static NSString * const addDeviceLightDefault = @"homemate://addDevice/light/lightDefault";

// 智能门锁
static NSString * const addDeviceLockDefault = @"homemate://addDevice/smartlock/lockDefault";

// 智能音箱
static NSString * const addDeviceSoundDefault = @"homemate://addDevice/sound/soundDefault";

// 智能空气开关管理器
static NSString * const addDeviceDistboxDefault = @"homemate://addDevice/distbox/distboxDefault";

// 多功能控制盒
static NSString * const addDevicecOntrolboxDefault = @"homemate://addDevice/controlbox/controlboxDefault";

// 公子小白
static NSString * const addDeviceRobotDefault = @"homemate://addDevice/robot/robotDefault";


// coco
static NSString * const addDeviceSocketCoco = @"homemate://addDevice/socket/coco";

// s30
static NSString * const addDeviceSocketS30 = @"homemate://addDevice/socket/s30";

// s20
static NSString * const addDeviceSocketS20 = @"homemate://addDevice/socket/s20";
// 一栋
static NSString * const addDeviceSocketYidong = @"homemate://addDevice/socket/yidong";
// 林肯
static NSString * const addDeviceSocketLincoln = @"homemate://addDevice/socket/lincoln";
// 小E
static NSString * const addDeviceSocketXiaoE = @"homemate://addDevice/socket/xiaoe";
// ZFC
static NSString * const addDeviceSocketZFC = @"homemate://addDevice/socket/zfcstrip";
// 其他插座
static NSString * const addDeviceSocketOtheroutlet = @"homemate://addDevice/socket/otheroutlet";




// 小方
static NSString * const addDeviceRemoteXiaoF = @"homemate://addDevice/remote/xiaofang";
//all One pro
static NSString * const addDeviceRemoteAllonePro = @"homemate://addDevice/remote/rfallone";
// all one
static NSString * const addDeviceRemoteZigbeeAllone = @"homemate://addDevice/remote/zigbeeallone";
// 智能遥控器
static NSString * const addDeviceRemoteRemotecontrol = @"homemate://addDevice/remote/remotecontrol";



// 门磁
static NSString * const addDeviceSensorDoorsensor = @"homemate://addDevice/sensor/doorsensor";
//人体红外
static NSString * const addDeviceSensorMotionsensor = @"homemate://addDevice/sensor/motionsensor";
// 人体光照
static NSString * const addDeviceSensorMotionlight = @"homemate://addDevice/sensor/motionlight";
// CO监测
static NSString * const addDeviceSensorCO = @"homemate://addDevice/sensor/co";
// 甲醛监测
static NSString * const addDeviceSensorHcho = @"homemate://addDevice/sensor/hcho";
// 烟雾报警器
static NSString * const addDeviceSensorHmsmoke = @"homemate://addDevice/sensor/hmsmoke";
// CO报警器
static NSString * const addDeviceSensorHmco = @"homemate://addDevice/sensor/hmco";
// 可燃气体报警器
static NSString * const addDeviceSensorHmburn = @"homemate://addDevice/sensor/hmburn";
// 水浸探测器
static NSString * const addDeviceSensorHmwater = @"homemate://addDevice/sensor/hmwater";
// 温湿度探测器
static NSString * const addDeviceSensorHmtemp = @"homemate://addDevice/sensor/hmtemp";
// 紧急按钮
static NSString * const addDeviceSensorHmButton = @"homemate://addDevice/sensor/hmbutton";
// 信号输入模块
static NSString * const addDeviceSensorSormodule = @"homemate://addDevice/sensor/sensormodule";





// 萤石摄像机
static NSString * const addDeviceCameraYingshi = @"homemate://addDevice/camera/yingshi";
// 小欧摄像机
static NSString * const addDeviceCameraXiaoou = @"homemate://addDevice/camera/xiaoou";
// p2p摄像机
static NSString * const addDeviceCameraP2P = @"homemate://addDevice/camera/p2p";




// 晾霸晾衣机
static NSString * const addDeviceHangerLingBa = @"homemate://addDevice/hanger/liangba";
// 紫宸晾衣机
static NSString * const addDeviceHangerZichen = @"homemate://addDevice/hanger/zicheng";
// 奥科晾衣机
static NSString * const addDeviceHangerAoke = @"homemate://addDevice/hanger/aoke";
// 麦润晾衣机
static NSString * const addDeviceHangerMairun = @"homemate://addDevice/hanger/mairun";
// 帮和晾衣机
static NSString * const addDeviceHangerBanghe = @"homemate://addDevice/hanger/banghe";

@interface HMAppFactoryAPI : HMBaseAPI

/**
 *  获取QQ授权码
 *
 *  @return
 */
- (NSString *)qqAuth;


/**
 *  获取微信授权码
 *
 *  @return
 */
- (NSString *)wechatAuth;


/**
 *  获取小方授权码
 *
 *  @return
 */
- (NSString *)xiaoFAuthority;

/**
 *  获取大拿授权码
 *
 *  @return
 */
- (NSString *)daNaCoreCode;




/**
 *  获取controller的背景颜色
 *
 *  @return UIColor 默认透明
 */
- (UIColor *)controllerBgColor;



/**
 *  获取彩色字体颜色
 *
 *  @return UIColor 默认透明
 */
- (UIColor *)appFontColor;


/**
 *  获取app主题颜色
 *
 *  @return UIColor 默认透明
 */
- (UIColor *)appTopicColor;


/**
 *  获取安防颜色
 *
 *  @return UIColor 默认透明
 */
- (UIColor *)secuityBgColor;




/**
 *  获取tabbarItem
 *
 *  @return NSArray 包含HMAppNaviTab对象
 */
+ (NSArray <HMAppNaviTab *> *)tabBarItems;


/**
 *  获取添加设备列表的一级目录
 *
 *  @return NSArray 包含HMAppProductType对象
 */
+ (NSArray <HMAppProductType *> *)addDeviceFirstLevel;


/**
 *  获取添加设备列表的二级目录
 *
 *  preProductTypeId 父目录Id
 *
 *  @return NSArray 包含HMAppProductType对象
 */
+ (NSArray <HMAppProductType *>*)addDeviceSecondLevel:(NSString *)preProductTypeId;
@end
