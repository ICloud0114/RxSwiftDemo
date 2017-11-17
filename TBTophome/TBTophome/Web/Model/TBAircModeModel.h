//
//  TBAircModeModel.h
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//
//空调模式

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TBAricMode;
@interface TBAircModeModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nullable ,nonatomic, copy) NSArray<NSNumber *> *direct; //风向
@property (nullable, nonatomic, copy) NSArray<NSNumber *> *modes; //模式
@property (nullable, nonatomic, copy) NSArray<TBAricMode *> *modeValues; //模式下的风速和温度
@end

@interface TBAricMode : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, assign) NSInteger speedIndex;
@property (nonatomic, copy) NSArray<NSNumber *> *speed;
@property (nonatomic, assign) NSInteger tempIndex;
@property (nonatomic, copy) NSArray<NSNumber *> *temp;

@end
NS_ASSUME_NONNULL_END
