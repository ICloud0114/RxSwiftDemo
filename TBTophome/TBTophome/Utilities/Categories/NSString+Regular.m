//
//  NSString+Regular.m
//  Template
//
//  Created by Topband on 2016/12/20.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)isNumber {
    return [self matches:^NSString *{
        return @"[0-9]+";
    }];
}

- (BOOL)isPhoneNumber {
    return [self matches:^NSString *{
        return @"^((13[0-9])|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}$";
    }];
}

- (BOOL)matches:(NSString *(^)())regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex()];
    return [predicate evaluateWithObject:self];
}
@end
