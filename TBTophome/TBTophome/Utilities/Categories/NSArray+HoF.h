//
//  NSArray+HoF.h
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
//数组一些高阶函数
NS_ASSUME_NONNULL_BEGIN
@interface NSArray<ObjectType> (HoF)

- (NSArray *)map:(id (NS_NOESCAPE ^)(ObjectType))transform;

- (NSArray<ObjectType> *)filter:(BOOL (NS_NOESCAPE ^)(ObjectType))transform;

@end
NS_ASSUME_NONNULL_END
