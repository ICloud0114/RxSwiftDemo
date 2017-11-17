//
//  UIImage+AppImg.h
//  TBTophome
//
//  Created by Topband on 2016/12/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片资源管理
 */
NS_ASSUME_NONNULL_BEGIN
@interface UIImage (AppImg)
/**
 导航栏背景图片
 */
@property (class, nonatomic, readonly) UIImage *navigationBarImage;


/**
 导航栏返回图片
 */
@property (class, nonatomic, readonly) UIImage *navigationBackNormalImage;

@property (class, nonatomic, readonly) UIImage *navigationAddNormalImage;


/**
 空气净化器设备图标
 */
@property (class, nonatomic, readonly) UIImage *airPurifierDeviceIconImage;

/**
 空气净化器离线图标
 */
@property (class, nonatomic, readonly) UIImage *airPurifierDeviceOffIconImage;

/**
 热水器图标
 */
@property (class, nonatomic, readonly) UIImage *heaterDeviceIconImage;

/**
 热水器离线图标
 */
@property (class, nonatomic, readonly) UIImage *heaterDeviceOffIconImage;

/**
 情意灯图标
 */
@property (class, nonatomic, readonly) UIImage *ledDeviceIconImage;

/**
 情意灯离线图标
 */
@property (class, nonatomic, readonly) UIImage *ledDeviceOffIconImage;

/**
 加湿器图标
 */
@property (class, nonatomic, readonly) UIImage *humidifierDeviceIconImage;

/**
 加湿器离线图标
 */
@property (class, nonatomic, readonly) UIImage *humidifierDeviceOffIconImage;

/**
 净水器图标
 */
@property (class, nonatomic, readonly) UIImage *waterPurifierIconImage;

/**
 净水器离线图标
 */
@property (class, nonatomic, readonly) UIImage *waterPurifierOffIconImage;

/**
 电饭煲图标
 */
@property (class, nonatomic, readonly) UIImage *riceCookerIconImage;

/**
 电饭煲离线图标
 */
@property (class, nonatomic, readonly) UIImage *riceCookerOffIconImage;

/**
 净水器制水⚠️
 */
@property (class, nonatomic, readonly) UIImage *waterPurifierMadeImage;

/**
 净水器冲洗⚠️
 */
@property (class, nonatomic, readonly) UIImage *waterPurifierWashImage;

/**
 咖啡机图标
 */
@property (class, nonatomic, readonly) UIImage *coffeeDeviceIconImage;

/**
 咖啡机离线图标
 */
@property (class, nonatomic, readonly) UIImage *coffeeDeviceOffIconImage;

/**
 烤箱图标
 */
@property (class, nonatomic, readonly) UIImage *ovenDeviceIconImage;

/**
 烤箱离线图标
 */
@property (class, nonatomic, readonly) UIImage *ovenDeviceOffIconImage;

/**
 马桶图标
 */
@property (class, nonatomic, readonly) UIImage *toiletDeviceIconImage;

/**
 马桶离线图标
 */
@property (class, nonatomic, readonly) UIImage *toiletDeviceOffIconImage;

/**
 电磁炉图标
 */
@property (class, nonatomic, readonly) UIImage *inductionCookingIconImage;

/**
 电磁炉离线图标
 */
@property (class, nonatomic, readonly) UIImage *inductionCookingOffIconImage;

/**
 更多图标
 */
@property (class, nonatomic, readonly) UIImage *moreIconImage;

/**
 料理机图标
 */
@property (class, nonatomic, readonly) UIImage *cookingMachineIconImage;

/**
 料理机离线图标
 */
@property (class, nonatomic, readonly) UIImage *cookingMachineOffIconImage;

/**
 洗碗机图标
 */
@property (class, nonatomic, readonly) UIImage *dishwasherIconImage;

/**
 洗碗机离线图标
 */
@property (class, nonatomic, readonly) UIImage *dishwasherOffIconImage;
    
/**
 小方图标
 */
@property (class, nonatomic, readonly) UIImage *xiaofangIconImage;
    
/**
 小方离线图标
 */
@property (class, nonatomic, readonly) UIImage *xiaofangOffIconImage;

/**
 空调遥控器图标
 */
@property (class, nonatomic, readonly) UIImage *aricIconImage;

/**
 空调遥控器离线图标
 */
@property (class, nonatomic, readonly) UIImage *aricOffIconImage;

/**
 空调遥控器柜式图标
 */
@property (class, nonatomic, readonly) UIImage *aricCIconImage;

/**
 空调遥控器柜式离线图标
 */
@property (class, nonatomic, readonly) UIImage *aricCOffIconImage;
@end
NS_ASSUME_NONNULL_END
