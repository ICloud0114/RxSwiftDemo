//
//  DeviceListViewModel.h
//  TBTophome
//
//  Created by Topband on 2016/12/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ViewModel.h"
#import "DevicesViewModelFactory.h"

NS_ASSUME_NONNULL_BEGIN
@interface DeviceListViewModel : ViewModel

/**
 设备列表
 */
@property (nonatomic, readonly, copy) NSArray<TBDeviceViewModel *> *deviceList;


/**
 获取设备列表
 */
@property (nonatomic, readonly, strong) RACCommand *deviceListCommand;

/**
 删除设备
 */
- (RACSignal *)unbindDeviceAtIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
