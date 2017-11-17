//
//  TBInfrared.h
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//
//红外码获取
#import <Foundation/Foundation.h>
#import "TBBrandsInfo.h"
#import "TBAircModeModel.h"
#import "TBAcirComposeInfraredModel.h"

/**
 //格力
 brandid: 97
 */
extern NSString *const TBInfraredErrorDomain;
NS_ASSUME_NONNULL_BEGIN
@interface TBInfrared : NSObject

+ (void)getBrandsListWithDeviceType:(NSInteger)type completeHandle:(void (^)(NSArray<TBBrandsInfo *> * _Nullable, NSError * _Nullable error))handle;

//获取某个品牌下的某款产品的红外id列表
+ (void)getRidsWithDeviceId:(NSInteger)did brandId:(NSInteger)bid completeHandle:(void (^)(NSArray * _Nullable, NSError * _Nullable error)) handle;

//获取某个空调遥控器下的模式
+ (void)getAcirModeWithRid:(NSInteger)rid completeHandle:(void (^)(TBAircModeModel * _Nullable, NSError * _Nullable error)) handle;

+ (void)getAcirComposeInfraredWithRid:(NSInteger)rid
                         composeParam:(NSDictionary *)param
                       completeHandle:(void (^)(TBAcirComposeInfraredModel * _Nullable, NSError * _Nullable error)) handle;
@end
NS_ASSUME_NONNULL_END
