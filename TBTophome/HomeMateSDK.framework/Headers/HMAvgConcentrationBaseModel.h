//
//  HMAvgConcentrationBaseModel.h
//  HomeMate
//
//  Created by JQ on 16/8/9.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAvgConcentrationBaseModel : HMBaseModel

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *deviceId;


/**
 *  时平均一氧化碳,获取到的值未放大，因为UI上显示的浓度是整型，avgCOStr按照avgCO四舍五入转化，
 *  取数据用avgCOStr, [NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) float avgCO;
@property (nonatomic, copy) NSString *avgCOStr;

/**
 *  小时最小一氧化碳浓度，获取到的值未放大
 *  取数据用minCOStr, [NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) int minCO;
@property (nonatomic, copy) NSString *minCOStr;

/**
 *  小时最大一氧化碳浓度，获取到的值未放大
 *  取数据用maxCOStr, [NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) int maxCO;
@property (nonatomic, copy) NSString *maxCOStr;



/**
 *  时平均甲醛，获取到的值已被放大100倍
 *  取数据用avgHCHOStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) float avgHCHO;
@property (nonatomic, copy) NSString *avgHCHOStr;

/**
 *  小时最小甲醛浓度，获取到的值已被放大100倍，
 *  取数据时用minHCHOStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) int minHCHO;
@property (nonatomic, copy) NSString *minHCHOStr;

/**
 *  小时最大甲醛浓度，获取到的值已被放大100倍，
 *  取数据时用maxHCHOStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) int maxHCHO;
@property (nonatomic, copy) NSString *maxHCHOStr;




/**
 *  小时平均温度，avgTemp是放大10倍后发上来的，因为UI上显示的温度是整型，avgTempStr按照avgTemp四舍五入转化，
 *  取数据时用avgTempStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) float avgTemp;
@property (nonatomic, copy) NSString *avgTempStr;

/**
 *  小时最小温度，获取到的值已被放大10倍，
 *  取数据时用minTempStr
 */
@property (nonatomic, assign) int minTemp;
@property (nonatomic, copy) NSString *minTempStr;

/**
 *  小时最大温度，获取到的值已被放大10倍，
 *  取数据时用maxTempStr
 */
@property (nonatomic, assign) int maxTemp;
@property (nonatomic, copy) NSString *maxTempStr;




/**
 *  小时平均湿度,获取到的值未放大，因为UI上显示的湿度是整型，avgHumidityStr按照avgHumidity四舍五入转化
 *  取数据时用avgHumidityStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) float avgHumidity;
@property (nonatomic, copy) NSString *avgHumidityStr;

/**
 *  小时最小湿度，获取到的值未放大
 *  取数据时用minHumidityStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) int minHumidity;
@property (nonatomic, copy) NSString *minHumidityStr;

/**
 *  小时最大湿度，获取到的值未放大
 *  取数据时用maxHumidityStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) int maxHumidity;
@property (nonatomic, copy) NSString *maxHumidityStr;

/**
 *  小时平均配电箱功率,获取到的值未放大
 *  取数据时用avgDistBoxPowerStr，[NSNull null]表示这个点没有数据
 */
@property (nonatomic, assign) float avgDistBoxPower;
@property (nonatomic, copy) NSString *avgDistBoxPowerStr;


+ (NSString *)createTableStirngWithPrimaryKey:(NSString *)primaryKey column1:(NSString *)column1 uniqueColumn:(NSString *)uniqueColumn;

- (NSString *)updateStatementStringWithPrimaryKey:(NSString *)primaryKey primaryKeyValue:(NSString *)primaryKeyValue column1:(NSString *)colum1 column1Value:(NSString *)column1Value;

- (BOOL)deleteObjectWithPrimaryKey:(NSString *)primaryKey primaryKeyValue:(NSString *)primaryKeyValue;

+ (NSString *)getAllDataSql:(HMDevice *)device;

+ (NSArray *)allDataWithDevice:(HMDevice *)device;


@end



