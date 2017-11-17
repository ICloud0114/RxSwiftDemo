//
//  TBAircDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"
#import "TBInfrared.h"
#import "TBAddRemoteConfig.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBAircDeviceViewModel : TBDeviceViewModel

- (instancetype)initWithBrandId:(NSInteger)brandId;

@property (nonatomic, assign, readonly) NSInteger brandId; //品牌ID

@property (nonatomic, strong) TBAircModeModel *currentMode;

@property (nonatomic, strong) NSArray<NSNumber *> *rids;//当前红外id列表

@property (nonatomic, assign) NSInteger ridIndex; //当前所使用的红外下标

@property (nonatomic, assign) NSInteger modeIndex; //当前模式下标

@property (nonatomic, assign) BOOL power; //当前开关状态

@property (nonatomic, copy) NSNumber *currentDirect; //当前风向,最多只做1~3

@property (nonatomic, assign) NSInteger currentTemp; //当前温度

@property (nonatomic, assign) NSInteger currentModeValue; //当前模式

@property (nonatomic, assign) NSInteger currentSpeed; //当前风速


- (RACSignal<NSArray<NSNumber *> *> *)getInfraredCodes; //获取品牌下的红外码id列表

- (RACSignal<TBAircModeModel *> *)getAirModeWithRid:(NSInteger)rid; //获取某个红外码下的组合红外码

- (RACSignal *)controlWithParams:(NSDictionary *)params rid:(NSInteger)rid;

- (RACSignal *)controlWithCmdIndex:(NSInteger)index;

//保存当前遥控器
/**
 @param: 0-壁式,1-柜式
 */
- (RACSignal *)save:(NSInteger)style;
@end
NS_ASSUME_NONNULL_END
