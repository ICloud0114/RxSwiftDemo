//
//  HMSensorAverageDataModel.h
//  HomeMateSDK
//
//  Created by PandaLZMing on 16/11/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"


/**
 *  本地表，传感器数据表，页面跳转时，先显示旧数据，再获取新数据，再更新数据。
 */

@interface HMSensorAverageDataModel : HMBaseModel

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *average;    ///< 传感器平均数值
@property (nonatomic, strong) NSString *time;       ///< 该条数据的时间
@property (nonatomic, strong) NSString *max;
@property (nonatomic, strong) NSString *min;
@property (nonatomic, assign) NSInteger dataType;

@property (nonatomic, strong) NSString *tranformTime;   ///< 转化后的time


/**
 *  非协议字段。
 */
@property (nonatomic, strong) NSString *hour;  // 转换后的小时
@property (nonatomic, strong) NSNumber *value; // 转换后的温湿度值
@property (nonatomic, strong) NSNumber *fahrenheit; // 华氏度

/**
 *  获取数据对象
 */
+ (HMSensorAverageDataModel *)objectWithDic:(NSDictionary *)dic
                                   deviceId:(NSString *)deviceId
                                        uid:(NSString *)uid
                                   dataType:(kQuerySensorDataType)dataType
                       isNeedToTranformTime:(BOOL)isneedToTranformTime
                      isNeedTranformAverage:(BOOL)isneedToTranformAverage;

/**
 *  光照传感器读取传感器的旧数据
 *
 *  @param deviceId 设备ID
 *  @param userId   用户ID
 *  @param dataType 数据类型
 *  @return
 */
+ (NSArray *)dataArrayWithDeviceId:(NSString *)deviceId
                          dataType:(kQuerySensorDataType)dataType;

+ (NSArray *)modelWithDeviceId:(NSString *)deviceId
                      dataType:(kQuerySensorDataType)dataType;

+ (NSArray *)readSensorDataArrayWithDeviceId:(NSString *)deviceId
                                    dataType:(kQuerySensorDataType)dataType;

/**
 *  删除传感器的旧数据（光照为7天数据，CO／HCHO，温湿度 为过去24小时数据）
 *
 *  @param deviceId 设备ID
 *  @param userId   用户ID
 *  @param dataType 数据类型    (0: 默认、 1:CO、  2:hcho、  3:温度、  4:湿度)
 */

+ (void)deleteDataWithDeviceId:(NSString *)deviceId dataType:(kQuerySensorDataType)dataType;
@end
