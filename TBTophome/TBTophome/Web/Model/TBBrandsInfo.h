//
//  TBBrandsInfo.h
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//
//品牌信息
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBBrandsInfo : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *initial;
@property (nonatomic, assign) NSInteger brandid;
@property (nonatomic, copy) NSString *ename;
@property (nonatomic, copy) NSString *cname;

@end
NS_ASSUME_NONNULL_END
