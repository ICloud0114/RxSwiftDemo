//
//  DevicesViewModelFactory.h
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBDeviceViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface DevicesViewModelFactory : NSObject

+ (__kindof TBDeviceViewModel *)deviceViewModelWithDevice:(HMDevice *)device;

@end
NS_ASSUME_NONNULL_END
