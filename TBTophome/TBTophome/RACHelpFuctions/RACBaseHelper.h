//
//  RACBaseHelper.h
//  MusicU
//
//  Created by Topband on 16/7/22.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef id(^RACVerifyFunction_1)(id);
typedef BOOL(^RACVerifyFunction_2)(id);

static inline RACVerifyFunction_1 RACEventValueIsKindOf(Class aClass) {
    return ^id(RACEvent *event) {
        if ([event.value isKindOfClass:aClass]) {
            return event.value;
        }
        return nil;
    };
}

static inline RACVerifyFunction_2 RACEventFilter(RACEventType type) {
    return ^BOOL(RACEvent *event) {
        return (event.eventType == type);
    };
}

static inline RACVerifyFunction_2 RACValueFilterEmpty() {
    return ^BOOL(id value) {
        return (value != nil);
    };
}
