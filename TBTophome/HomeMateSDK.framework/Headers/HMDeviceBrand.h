//
//  HMDeviceBrand.h
//  HomeMateSDK
//
//  Created by peanut on 16/10/28.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface HMDeviceBrand : HMBaseModel

@property (nonatomic, retain) NSString *        brandId;

/** 品牌的类型，每个品牌对应一个类型 */
@property (nonatomic, assign)int                brandType;

/**  设备类型，见device表  */
@property (nonatomic, assign)int                deviceType;

@property (nonatomic, retain) NSString *        brandName;


/**
 *  zh：简体中文
 zh-TW：繁体中文
 en：英文
 de：德文
 fr：法文
 
 匹配语言的时候如果地区性的语言包存在的话就以地区性的为准，不存在的话就以这种语言的通用语言为准。
 例如手机设置的是加拿大的法语，系统里面读出来的语言为fr-CA，那优先去找fr-CA的语言包，找不到的话就去掉这个字符串里面的“-”以及后面的字符串，用剩下的fr去找，再找不到的话就使用默认的语言en。

 */
@property (nonatomic, retain) NSString *        language;

/**  排序  */
@property (nonatomic, assign)int                sequence;

@property (nonatomic, assign)int                createTimeSec;
@property (nonatomic, assign)int                updateTimeSec;


@end
