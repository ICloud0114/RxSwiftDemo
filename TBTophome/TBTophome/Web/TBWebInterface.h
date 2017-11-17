//
//  TBWebInterface.h
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBWebInterface : NSObject

+ (instancetype)interface;

- (void)getTaskWithParams:(NSDictionary *)params method:(NSString *)method completionHandler:(void (^)(id _Nullable object, NSError * _Nullable error))handler;

- (void)taskWithReqeust:(NSURLRequest *)request completionHandler:(void (^)(id _Nullable object, NSError * _Nullable error))handler;
@end
NS_ASSUME_NONNULL_END
