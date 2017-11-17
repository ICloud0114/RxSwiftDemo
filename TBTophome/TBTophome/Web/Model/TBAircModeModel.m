//
//  TBAircModeModel.m
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAircModeModel.h"
#import "NSArray+HoF.h"

@implementation TBAircModeModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _direct = [dic objectForKey:@"direct"];
        _modes = [dic objectForKey:@"modes"];
        _modeValues = [_modes map:^id _Nonnull(NSNumber * _Nonnull mode) {
            return [[TBAricMode alloc] initWithDictionary:[dic objectForKey:[NSString stringWithFormat:@"mode%@", mode]]];
        }];
    }
    return self;
}

@end

@implementation TBAricMode

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _speed = [dic objectForKey:@"speed"];
        _temp = [dic objectForKey:@"temp"];
    }
    return self;
}

@end
