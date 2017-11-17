//
//  QuerySensorAverageCmd.h
//  HomeMate
//
//  Created by JQ on 16/8/19.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

/**
 *  查询传感器最近24小时数据的平均值
 */
@interface QuerySensorAverageCmd : BaseCmd

@property (nonatomic, copy) NSString *familyId;

@property (nonatomic, copy) NSString *deviceId;

/**
 *  数据类型
 */
@property (nonatomic, assign) kQuerySensorDataType dataType;

@end
