//
//  HMProductModel.h
//  HomeMate
//
//  Created by liuzhicai on 16/1/13.
//  Copyright © 2016年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMProductModel : NSObject

// 产品名称
@property (nonatomic, copy)NSString *productName;

// 厂商
@property (nonatomic, copy)NSString *manufacturer;

// 32位设备标识符，即设备表的model
@property (nonatomic, copy)NSString *model;

// 产品型号
@property (nonatomic, copy)NSString *productModel;

//  多路产品的各路集合
/*  eg: 极光三路开关的appDeviceId为0x0000，设备类型为1，有三个端点号，则这里填写的数据为：
 *     01,0,1|02,0,1|03,0,1
 */
@property (nonatomic, copy)NSString *endpointSet;

// 产品的图片
@property (nonatomic, copy)NSString *imageStr;

// 此字段用于二维码扫描设备时， 对应的添加入口类型， 用于页面跳转
@property (nonatomic, copy)NSString *entryType;

// 产品的二维码字符串
@property (nonatomic, copy)NSString *qrCodeStr;

// 新增设备的信息
@property (nonatomic, copy)NSString *stepInfo;



@property (nonatomic, getter=isNeedToDownload)BOOL needToDownload;


@property (nonatomic, strong)UIImage *deviceImage;


// 根据二维码序号找到对应的产品model
+ (HMProductModel *)productModelWithQrCodeNo:(NSString *)qrCodeNo;

// 根据 32位设备标识符，即设备表的model 找到对应的产品model
+ (HMProductModel *)productModelWithModel:(NSString *)model;

+ (HMProductModel *)productModelWithDevice:(HMDevice *)device;


+ (UIImage *)deviceImageWithImgStr:(NSString *)imgStr;

+ (void)downloadImgWithDevice:(HMDevice *)device;

+ (void)downloadImageToCacheWithUrlStr:(NSString *)urlStr;




@end
