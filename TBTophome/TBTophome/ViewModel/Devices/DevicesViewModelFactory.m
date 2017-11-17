//
//  DevicesViewModelFactory.m
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "DevicesViewModelFactory.h"
#import "TBAirPurifierDeviceViewModel.h"
#import "TBHeaterDeviceViewModel.h"
#import "TBLEDLightDeviceViewModel.h"
#import "TBHumidifierDeviceViewModel.h"
#import "TBWaterPurifierDevcieViewModel.h"
#import "TBRiceCookerDeviceViewModel.h"
#import "TBCoffeeDeviceViewModel.h"
#import "TBInductionCookingDeviceViewModel.h"
#import "TBToiletDeviceViewModel.h"
#import "TBOvenDeviceViewModel.h"
#import "TBCookingMachineDeviceViewModel.h"
#import "TBDishwasherViewModel.h"
#import "TBXiaoFangDeviceViewModel.h"
#import "TBAircDeviceViewModel.h"

@implementation DevicesViewModelFactory

+ (__kindof TBDeviceViewModel *)deviceViewModelWithDevice:(HMDevice *)device {
    TBDeviceViewModel *deviceViewModel = nil;
    switch (device.deviceType) {
        case 80: //空气净化器
            deviceViewModel = [[TBAirPurifierDeviceViewModel alloc] initWithDevice:device];
            break;
        case 83: //热水器
            deviceViewModel = [[TBHeaterDeviceViewModel alloc] initWithDevice:device];
            break;
        case 82: //情意灯
            deviceViewModel = [[TBLEDLightDeviceViewModel alloc] initWithDevice:device];
            break;
        case 84: //加湿器
            deviceViewModel = [[TBHumidifierDeviceViewModel alloc] initWithDevice:device];
            break;
        case 85: //马桶
            deviceViewModel = [[TBToiletDeviceViewModel alloc] initWithDevice:device];
            break;
        case 86: //净水器
            deviceViewModel = [[TBWaterPurifierDevcieViewModel alloc] initWithDevice:device];
            break;
        case 87: //电饭煲
            deviceViewModel = [[TBRiceCookerDeviceViewModel alloc] initWithDevice:device];
            break;
        case 88: //烤箱
            deviceViewModel = [[TBOvenDeviceViewModel alloc] initWithDevice:device];
            break;
        case 89: //咖啡机
            deviceViewModel = [[TBCoffeeDeviceViewModel alloc] initWithDevice:device];
            break;
        case 90: //料理机
            deviceViewModel = [[TBCookingMachineDeviceViewModel alloc] initWithDevice:device];
            break;
        case 91: //电磁炉
            deviceViewModel = [[TBInductionCookingDeviceViewModel alloc] initWithDevice:device];
            break;
        case 92: //洗碗机
            deviceViewModel = [[TBDishwasherViewModel alloc] initWithDevice:device];
            break;
        case KDeviceTypeAllone: //小方
            deviceViewModel = [[TBXiaoFangDeviceViewModel alloc] initWithDevice:device];
            break;
        case KDeviceTypeAirconditioner: //空调遥控器
            deviceViewModel = [[TBAircDeviceViewModel alloc] initWithDevice:device];
            break;
        default:
            deviceViewModel = [[TBDeviceViewModel alloc] initWithDevice:device];
            break;
    }
    //查询一下设备状态
    NSString *deviceId = deviceViewModel.device.deviceId;
    if ([deviceViewModel.device.irDeviceId integerValue] > 0) { //遥控器
        __block HMDevice *xiaofang = nil;
        NSString *sql2 = [NSString stringWithFormat:@"select * from device where uid = '%@' and deviceType = %@", deviceViewModel.device.uid, @(KDeviceTypeAllone)];
        queryDatabase(sql2, ^(FMResultSet *rs) {
            xiaofang = [HMDevice object:rs];
        });
        NSAssert(xiaofang != nil, @"未查到小方");
        deviceId = xiaofang.deviceId;
    }
    deviceViewModel.online = [self deviceStatusWithDeviceId:deviceId];
    return deviceViewModel;
}

//yes:设备在线,no:设备离线
+ (BOOL)deviceStatusWithDeviceId:(NSString *)deviceId {
    __block BOOL st = NO;
    NSString *deviceStatueSql = [NSString stringWithFormat:@"select * from deviceStatus where deviceId = '%@'", deviceId];
    queryDatabase(deviceStatueSql, ^(FMResultSet *rs) {
        HMDeviceStatus *status = [HMDeviceStatus object:rs];
        st = (status.online == 1);
    });
    return st;
}

@end
