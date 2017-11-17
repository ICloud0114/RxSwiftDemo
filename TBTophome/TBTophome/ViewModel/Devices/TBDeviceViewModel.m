//
//  TBDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBDeviceViewModel.h"

@implementation TBDeviceViewModel
@synthesize device = _device;

- (UIImage *)deviceIcon {
    return nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KKNOTIFICATION_DATAUPLOAD object:nil];
}

- (instancetype)initWithDevice:(HMDevice *)device {
    self = [super init];
    if (self) {
        _device = device;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceUpdateStatus:) name:KKNOTIFICATION_DATAUPLOAD object:nil];
    }
    return self;
}

- (NSString *)deviceName {
    return _device.deviceName;
}

- (void)deviceUpdateStatus:(NSNotification *)notification {
    NSDictionary *reportedData = notification.object;
    NSString *macAdr = [reportedData objectForKey:@"uid"];
    if (![macAdr isEqualToString:_device.uid]) {
        return;
    }
    NSDictionary *payload = [reportedData objectForKey:@"payload"];
    NSInteger cmd = [[reportedData objectForKey:@"cmd"] integerValue];
    [self deviceReportedData:payload cmd:cmd];
}

- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {}

- (RACSignal *)dataToDevice:(NSDictionary *)payload {
    DataToDeviceCmd *cmd = [DataToDeviceCmd object];
    cmd.deviceId = _device.deviceId;
    cmd.uid = _device.uid;
    cmd.userName = userAccout().userName;
    cmd.sendToServer = YES;
    cmd.ackRequire = 0;
    cmd.payload = payload;
    return [[self class] sendCmd:cmd];
}

- (RACSignal *)modifyDeviceName:(NSString *)name {
    ServerModifyDeviceCmd *modifydevice = [ServerModifyDeviceCmd object];
    modifydevice.userName = userAccout().userName;
    modifydevice.uid = _device.uid;
    modifydevice.deviceId = _device.deviceId;
    modifydevice.deviceName = name;
    modifydevice.deviceType = _device.deviceType;
    modifydevice.roomId = _device.roomId;
    modifydevice.irDeviceId = _device.irDeviceId;
    modifydevice.sendToServer = YES;
    __weak typeof(self) weakSelf = self;
    return [[[self class] sendCmd:modifydevice]
            doNext:^(id  _Nullable x) {
        weakSelf.device.deviceName = modifydevice.deviceName;
        [HMDevice updateDeviceName:modifydevice.deviceName deviceId:weakSelf.device.deviceId];
    }];
}

- (NSMutableDictionary *)payloadWithTempletId:(NSInteger)tId cmdId:(NSInteger)cId subCmdId:(NSInteger)scId {
    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
    [payload setObject:@(cId) forKey:@"cmd"];
    [payload setObject:@(scId) forKey:@"subCmd"];
    [payload setObject:@(tId) forKey:@"templetId"];
    return payload;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBDeviceViewController");
}

@end
