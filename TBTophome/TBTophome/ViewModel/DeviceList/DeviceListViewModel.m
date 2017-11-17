//
//  DeviceListViewModel.m
//  TBTophome
//
//  Created by Topband on 2016/12/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "DeviceListViewModel.h"
#import "RACBaseHelper.h"
#import "NSArray+HoF.h"

@interface DeviceListViewModel ()

@property (nonatomic, strong) RACCommand *deviceListCommand;
@property (nonatomic, copy) NSArray<TBDeviceViewModel *> *deviceList;

@end

@implementation DeviceListViewModel

- (RACSignal *)unbindDeviceAtIndex:(NSInteger)index {
    TBDeviceViewModel *viewModel = self.deviceList[index];
    DeleteDeviceCmd *dlCmd = deleteCmdWithDevice(viewModel.device);
    dlCmd.sendToServer = YES;
    return [[[self class] sendCmd:dlCmd] map:^id _Nullable(id  _Nullable value) {
        return @([viewModel.device deleteObjectAndRelatedObject]);
    }];
}

/**
 查询设备列表
 */
//5ccf7f20fd36
+ (RACSignal *)queryDeviceListForSignal {
    return [self signalMapAction:^id _Nonnull{
        NSMutableArray *devcieList = [NSMutableArray array];
        NSString *sql = [NSString stringWithFormat:@"select * from device where uid in (select uid from devicesBind where familyId in (select familyId from family where userId = '%@'))", userAccout().userId];
        queryDatabase(sql, ^(FMResultSet *rs) {
            HMDevice *deivce = [HMDevice object:rs];
            [devcieList addObject:deivce];
        });
        
        return [[devcieList map:^id _Nonnull(HMDevice * _Nonnull item) {
            return [DevicesViewModelFactory deviceViewModelWithDevice:item];
        }] sortedArrayUsingComparator:^NSComparisonResult(TBDeviceViewModel * _Nonnull obj1, TBDeviceViewModel * _Nonnull obj2) {
            if (obj1.online > obj2.online) {
                return NSOrderedAscending;
            } else if (obj1.online == obj2.online) {
                return NSOrderedSame;
            }
            return NSOrderedDescending;
        }];
    }];
}

- (void)bind {
    RAC(self, deviceList) =
    [self.deviceListCommand.executionSignals flattenMap:^__kindof RACSignal * _Nullable(RACSignal *  _Nullable subscribeSignal) {
        return [[[subscribeSignal materialize]
                filter:RACEventFilter(RACEventTypeNext)]
                map:RACEventValueIsKindOf([NSArray class])];
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self bind];
    }
    return self;
}

#pragma mark - getter setter
- (RACCommand *)deviceListCommand {
    if (!_deviceListCommand) {
        _deviceListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [DeviceListViewModel queryDeviceListForSignal];
        }];
    }
    
    return _deviceListCommand;
}
@end
