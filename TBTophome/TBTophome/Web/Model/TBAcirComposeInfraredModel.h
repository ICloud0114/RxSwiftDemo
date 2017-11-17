//
//  TBAcirComposeInfraredModel.h
//  TBTophome
//
//  Created by Topband on 2017/3/14.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAcirComposeInfraredModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, strong) NSArray<NSNumber *> *pattern;

@property (nonatomic, assign) NSInteger fre;

@end
