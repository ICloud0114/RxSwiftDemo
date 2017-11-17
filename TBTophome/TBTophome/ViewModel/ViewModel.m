//
//  ViewModel.m
//  Template
//
//  Created by Topband on 2016/12/14.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ViewModel.h"

NSString *const ViewModelErrorDomain = @"com.viewModel.errorDomain";

@implementation ViewModel

+ (RACSignal *)signalMapAction:(id (^)())action {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:action()];
        [subscriber sendCompleted];
        return nil;
    }];
}

+ (RACSignal *)sendCmd:(BaseCmd *)cmd {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
            if (returnValue == KReturnValueSuccess) {
                [subscriber sendNext:returnDic];
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:[NSError errorWithDomain:ViewModelErrorDomain code:returnValue userInfo:@{NSLocalizedDescriptionKey : @"操作失败"}]];
            }
        });
        return nil;
    }];
}

- (NSError *)errorCode:(KReturnValue)code toMap:(NSString * (^)(KReturnValue))map {
    return [NSError errorWithDomain:ViewModelErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: map(code)}];
}

@end
