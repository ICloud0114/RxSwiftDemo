//
//  TBAddRemoteConfig.m
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddRemoteConfig.h"

static NSString *_xiaofang_uid = nil;

@implementation TBAddRemoteConfig

+ (NSString *)xiaofang_uid {
    return _xiaofang_uid;
}

+ (void)setXiaofang_uid:(NSString *)xiaofang_uid {
    _xiaofang_uid = xiaofang_uid;
}

@end
