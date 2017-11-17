//
//  HMApUtil.h
//  HomeMate
//
//  Created by liqiang on 15/11/20.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,HmAPDeviceType) {
    HmAPDeviceTypeCOCO,//coco  非usb
    HmAPDeviceTypeLenovo,//Lenovo coco插线板
    HmAPDeviceTypeS20, //s20
    HmAPDeviceTypeZFC, //ZFC
    HmAPDeviceTypeB25, //B25
    HmAPDeviceTypeS30, // s30
    HmAPDeviceTypeS31, // s31
    HmAPDeviceTypeYiDong, // 一栋插座
    HmAPDeviceTypeFeiDiao, // 飞雕排插
    HmAPDeviceTypeXiaoE,  // 小E智能插座
    HmAPDeviceTypeHuaDingStrip,//华顶排插
    HmAPDeviceTypeHuaDingSocket,//华顶插座
    HmAPDeviceTypeAoboer,//奥博尔智能插座
    HmAPDeviceTypeLiangBaHanger, //晾霸晾衣架
    HmAPDeviceTypeZiChenHanger, //紫宸晾衣架
    HmAPDeviceTypeMaiRunHanger, //麦润晾衣架
    HmAPDeviceTypeBangHeHanger, //邦禾晾衣架
    HmAPDeviceTypeAoKeHanger,// 奥科晾衣架
    HmAPDeviceTypeHomeMate,//统称类型
    HmAPDeviceTypeNeutral, //中性类型
    HmAPDeviceTypeAllone2, // allone2
    HmAPDeviceTypeCODetector,//CO探测器
    HmAPDeviceTypeHCHODetector,//甲醛探测器
    HmAPDeviceTypeRF,//RF主机
    HmAPDeviceTypeWifiCurtain,//WIFI窗帘电机
    HmAPDeviceTypeUnkown = 100 //未知类型
};

typedef NS_ENUM(NSInteger, HmCountryStandard) {
    HmCountryStandardUS,
    HmCountryStandardEU,
    HmCountryStandardUK,
    HmCountryStandardAU,
    HmCountryStandardCN,
};

@interface HMApUtil : NSObject



@property (nonatomic, copy) NSString * stepInfo;

+ (instancetype)util;

/**
 *  设置国家标准
 *
 *  @param standard
 */
- (void)setCountryStandard:(HmCountryStandard )standard;

/**
 * 根据modeId 设置 AP配置设备类型
 *
 *  @param modelId
 */
- (void)setApDeviceTypeForModelId:(NSString *)modelId;

/**
 *
 *
 *  添加页面标题
 *
 *  @return
 */

- (NSString *)getAddControllerTitle;
/**
 *  配置过程页面title
 *
 *  @return
 */
- (NSString *)getProcessControllerTitle;


/**
 *  设置ap配置设备类型
 *
 *  @param apDeviceType
 */
- (void)setApDeviceType:(HmAPDeviceType)apDeviceType;

/**
 *  第一步配置提示
 *
 *  @return
 */
- (NSString *)getFirstStepTip;

/**
 *  获取第一步简介图片数组
 *
 *  @return
 */
- (NSArray *)getFirstStepImageArray;

/**
 *  获取添加成功页面标题
 *
 *  @return
 */
- (NSString *)getAddSucessControllerTitle;

/**
 *  获取正在添加提示语
 *
 *  @return
 */
- (NSString *)getAddingDeviceTip;
@end
