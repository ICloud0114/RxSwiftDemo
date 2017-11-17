//
//  HMAppFactoryConfig.h
//  HomeMateSDK
//
//  Created by PandaLZMing on 2017/4/28.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMAppFactoryConfig : NSObject


+ (instancetype)appFactory;


/**
 获取 App 软件工厂信息
 */
+ (void)getAppFactoryDataFromServer;

/**
 *  版本更新的历史记录
 */
+(NSString *)updateHistoryUrl;


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
- (NSArray <HMAppNaviTab *> *)tabBarItems;


/**
 *  获取添加设备列表的一级目录
 *
 *  @return NSArray 包含HMAppProductType对象
 */
- (NSArray <HMAppProductType *>*)addDeviceFirstLevel;


/**
 *  获取添加设备列表的二级目录
 *
 *  preProductTypeId 父目录Id
 *
 *  @return NSArray 包含HMAppProductType对象
 */
- (NSArray <HMAppProductType *>*)addDeviceSecondLevel:(NSString *)preProductTypeId;


@end
