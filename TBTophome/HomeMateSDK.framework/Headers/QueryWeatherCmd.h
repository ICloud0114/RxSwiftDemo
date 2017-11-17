//
//  QueryWeatherCmd.h
//  HomeMate
//
//  Created by Air on 15/11/19.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface QueryWeatherCmd : BaseCmd

/**
 *  城市名称。如果用此字段获取天气信息，则经纬度填空字符串。@""
 */
@property (nonatomic, strong)NSString * cityName;

/**
 *  客户端如果没有定位到经纬度，则此处填写空字符串。@""
 */
@property (nonatomic, strong)NSString * longitude;


/**
 *  客户端如果没有定位到经纬度，则此处填写空字符串。@""
 */
@property (nonatomic, strong)NSString * latotide;

@end
