//
//  ViewModel.h
//  Template
//
//  Created by Topband on 2016/12/14.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

extern NSString *const ViewModelErrorDomain;

NS_ASSUME_NONNULL_BEGIN
@interface ViewModel : NSObject

+ (RACSignal *)signalMapAction:(id (^)())action;

+ (RACSignal *)sendCmd:(BaseCmd *)cmd;

- (NSError *)errorCode:(KReturnValue)code toMap:(NSString * (^)(KReturnValue))map;

@end
NS_ASSUME_NONNULL_END
