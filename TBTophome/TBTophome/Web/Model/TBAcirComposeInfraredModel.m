//
//  TBAcirComposeInfraredModel.m
//  TBTophome
//
//  Created by Topband on 2017/3/14.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAcirComposeInfraredModel.h"

@implementation TBAcirComposeInfraredModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _pattern = [dic objectForKey:@"pattern"];
        _fre = [[dic objectForKey:@"fre"] integerValue];
    }
    return self;
}

@end
