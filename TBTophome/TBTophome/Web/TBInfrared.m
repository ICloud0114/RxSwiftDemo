//
//  TBInfrared.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBInfrared.h"
#import "TBWebInterface.h"
#import "NSArray+HoF.h"

NSString *const TBInfraredErrorDomain = @"_TBInfraredErrorDomain";

@implementation TBInfrared

+ (void)getBrandsListWithDeviceType:(NSInteger)type completeHandle:(void (^)(NSArray<TBBrandsInfo *> * _Nullable, NSError * _Nullable))handle {
    [[TBWebInterface interface] getTaskWithParams:@{@"deviceType": @(type)} method:@"getBrandsList" completionHandler:^(id  _Nullable object, NSError * _Nullable error) {
        if (error) {
            handle(nil, error);
            return;
        }
        NSDictionary *dic = object;
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        if (status == 0) {
            NSArray<NSDictionary *> *brandList = [dic objectForKey:@"brandList"];
            NSArray<TBBrandsInfo *> *brandsInfos = [brandList map:^id _Nonnull(NSDictionary * _Nonnull dic) {
                return [[TBBrandsInfo alloc] initWithDictionary:dic];
            }];
            handle(brandsInfos, nil);
        } else {
            NSError *error = [NSError errorWithDomain:TBInfraredErrorDomain code:status userInfo:@{NSLocalizedDescriptionKey: @"获取品牌列表失败"}];
            handle(nil, error);
        }
        
    }];
}

+ (void)getRidsWithDeviceId:(NSInteger)did brandId:(NSInteger)bid completeHandle:(void (^)(NSArray * _Nullable, NSError * _Nullable))handle {
    [[TBWebInterface interface] getTaskWithParams:@{@"did": @(did),
                                                    @"bid": @(bid)}
                                           method:@"remotes"
                                completionHandler:^(id  _Nullable object, NSError * _Nullable error) {
                                    if (error) {
                                        handle(nil, error);
                                        return;
                                    }
                                    NSDictionary *dic = object;
                                    NSInteger status = [[dic objectForKey:@"status"] integerValue];
                                    if (status == 0) {
                                        NSArray *rids = [dic objectForKey:@"rids"];
                                        handle(rids, nil);
                                    } else {
                                        NSError *error = [NSError errorWithDomain:TBInfraredErrorDomain code:status userInfo:@{NSLocalizedDescriptionKey: @"获取红外码列表失败"}];
                                        handle(nil, error);
                                    }
                                }];
}

+ (void)getAcirModeWithRid:(NSInteger)rid completeHandle:(void (^)(TBAircModeModel * _Nullable, NSError * _Nullable))handle {
    [[TBWebInterface interface] getTaskWithParams:@{@"rid": @(rid)}
                                           method:@"acirmodel"
                                completionHandler:^(id  _Nullable object, NSError * _Nullable error) {
                                    if (error) {
                                        handle(nil, error);
                                        return;
                                    }
                                    NSDictionary *dic = object;
                                    NSInteger status = [[dic objectForKey:@"status"] integerValue];
                                    if (status == 0) {
                                        TBAircModeModel *mode = [[TBAircModeModel alloc] initWithDictionary:dic];
                                        handle(mode, nil);
                                    } else {
                                        NSError *error = [NSError errorWithDomain:TBInfraredErrorDomain code:status userInfo:@{NSLocalizedDescriptionKey: @"获取空调模式失败"}];
                                        handle(nil, error);
                                    }
                                }];
}

+ (void)getAcirComposeInfraredWithRid:(NSInteger)rid
                         composeParam:(NSDictionary *)param
                       completeHandle:(void (^)(TBAcirComposeInfraredModel * _Nullable, NSError * _Nullable))handle {
    NSMutableDictionary *par = [NSMutableDictionary dictionaryWithObject:@(rid) forKey:@"rid"];
    [par addEntriesFromDictionary:param];
    [[TBWebInterface interface] getTaskWithParams:par
                                           method:@"acir"
                                completionHandler:^(id  _Nullable object, NSError * _Nullable error) {
                                    if (error) {
                                        handle(nil, error);
                                        return;
                                    }
                                    NSDictionary *dic = object;
                                    NSInteger status = [[dic objectForKey:@"status"] integerValue];
                                    if (status == 0) {
                                        TBAcirComposeInfraredModel *model = [[TBAcirComposeInfraredModel alloc] initWithDictionary:dic];
                                        handle(model, nil);
                                    } else {
                                        NSError *error = [NSError errorWithDomain:TBInfraredErrorDomain code:status userInfo:@{NSLocalizedDescriptionKey: @"获取空调组合红外码失败"}];
                                        handle(nil, error);
                                    }
                                }];
}

@end
