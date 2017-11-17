//
//  GlobalFunc.h
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef BOOL(^NotEmpty)(id);
static inline NotEmpty ArrayIsNotEmpty() {
    return ^(NSArray *array){
        if (!(array != nil && ((NSNull *)array) != [NSNull null] && array.count > 0))
            return NO;
        return YES;
    };
}

static inline NotEmpty StringIsNotEmpty() {
    return ^BOOL(NSString *str){
        return (str != nil && ((NSNull *)str) != [NSNull null] && str.length > 0);
    };
}

static inline void dispatch_main_async(dispatch_block_t block) {
    if ([NSThread currentThread].isMainThread) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline void dispatch_main_delay(NSTimeInterval delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

static inline float Radians(double degrees) { return degrees * M_PI / 180.f; }

static inline float Degrees(double radians) { return radians * 180.f / M_PI; }
