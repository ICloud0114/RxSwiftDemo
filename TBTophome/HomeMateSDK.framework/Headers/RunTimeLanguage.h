//
//  RunTimeLanguage.h
//  Vihome
//
//  Created by orvibo on 15-1-15.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

@class SingletonClass;

@interface RunTimeLanguage : SingletonClass

//如果当前语言环境为简体中文则返回yes，否则返回no
+(BOOL)isZh_Hans;

//如果当前语言环境为繁体中文则返回yes，否则返回no
+(BOOL)isZh_Hant;

/**
 *  返回系统语言简称
 *
 *  @return zh：简体中文 en：英文
 */
+(NSString *)languageCode;

/**
 *  返回设备信息对应的code
 *
 *  @return zh：简体中文 zh_TW：繁体中文 en：英文
 */
+(NSString *)deviceLanguage;
/**
 *  获取系统语言
 *
 *  @return 系统语言编码
 */
+ (NSString *)getCurrentLanguage;

- (NSString *)runTimeLocalizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end
