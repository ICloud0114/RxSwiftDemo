//
//  SingletonClass.h
//  Vihome
//
//  Created by orvibo on 15-1-15.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Singleton() \
                    static id __singletion__;\
                    static dispatch_once_t onceToken;\
                    dispatch_once(&onceToken, ^{\
                    __singletion__ =[[self alloc] init];\
                    });\
                    return __singletion__

@interface SingletonClass : NSObject

+ (instancetype)shareInstance;

@end
