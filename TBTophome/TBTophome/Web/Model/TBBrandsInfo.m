//
//  TBBrandsInfo.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBBrandsInfo.h"

@implementation TBBrandsInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _initial = [dic objectForKey:@"initial"];
        _brandid = [[dic objectForKey:@"brandId"] integerValue];
        _cname = [dic objectForKey:@"cname"];
        _ename = [dic objectForKey:@"ename"];
    }
    return self;
}

@end
