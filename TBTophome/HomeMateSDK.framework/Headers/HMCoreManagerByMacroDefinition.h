//
//  HMCoreManagerByMacroDefinition.h
//  HomeMate
//
//  Created by liuzhicai on 16/5/4.
//  Copyright © 2016年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMCoreManagerByMacroDefinition : NSObject

/**
 *  注册时、分享时等输入框的placeholder
 *
 *  @return 
 */
+ (NSString *)userNamePlaceholder;


/**
 *  提示连的ssid
 *
 *  @return
 */
+ (NSString *)connectSsid;

/**
 *  分享设备时的提示语
 *
 *  @return
 */
+ (NSString *)shareDeviceTips;

+ (NSString *)appName;


/**
 *  用户协议url
 *
 *  @return
 */
+ (NSString *)userProtocolUrlStr;



/**
 *  icon图片是否圆角
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)logoIconRounded;


/**
 *  是否显示about页面二维码
 *
 *  @return YES 显示  NO 不显示
 */
+ (BOOL)showQRCodeImage;


/**
 *  是不是只有中文
 *
 *  @return YES 是  NO 不是
 */
+ (BOOL)onlyChinese;

/**
 *  是否搜索主机
 *
 *  @return YES 搜索   NO 不搜索
 */
+ (BOOL)searchGateWay;
@end
