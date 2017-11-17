//
//  NSArray+HoF.m
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "NSArray+HoF.h"

@implementation NSArray (HoF)

- (NSArray *)map:(id  _Nonnull (^)(id _Nonnull))transform {
    NSMutableArray *mAry = [NSMutableArray arrayWithCapacity:self.count];
    for (id item in self) {
        [mAry addObject:transform(item)];
    }
    return mAry;
}

- (NSArray *)filter:(BOOL (NS_NOESCAPE ^)(id _Nonnull))transform {
    NSMutableArray *mAry = [NSMutableArray array];
    for (id item in self) {
        if (transform(item)) {
            [mAry addObject:item];
        }
    }
    return mAry;
}

@end
