//
//  HMDeviceConfig+RAC.m
//  TBTophome
//
//  Created by Topband on 2017/1/5.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "HMDeviceConfig+RAC.h"

@interface HMDeviceConfig ()<VhAPConfigDelegate>

@end

@implementation HMDeviceConfig (RAC)

//- (RACSignal *)configResultSignal {
//    self.delegate = self;
//    
//    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
//    if (signal) {
//        return signal;
//    }
//    
//    signal = [[self rac_signalForSelector:@selector(vhApConfigResult:) fromProtocol:@protocol(VhAPConfigDelegate)] map:^id(RACTuple *tuple) {
//        return tuple.first;
//    }];
//    
//    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    return signal;
//}

@end
