//
//  TBToiletDeviceViewModel.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBToiletDeviceViewModel.h"

@interface TBToiletDeviceViewModel(){
    
}

@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *operationMode;
@property (nonatomic, strong) RACCommand *stateChange;

@end

@interface TBToiletDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;

- (RACSignal *)startAction;

- (RACSignal *)flushAction;

- (RACSignal *)stopAction;

@end

@implementation TBToiletDeviceViewModel

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
//    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)   
    uint8 status = [[payload objectForKey:@"machStatus"] unsignedCharValue];
    uint8 wTemp = [[payload objectForKey:@"waterTemp"] unsignedCharValue];
    uint8 wPressure = [[payload objectForKey:@"waterPa"] unsignedCharValue];
    uint8 position = [[payload objectForKey:@"pipePosit"] unsignedCharValue];
    uint8 cTime = [[payload objectForKey:@"cleanTime"] unsignedCharValue];
    uint8 dLevel = [[payload objectForKey:@"dryStep"] unsignedCharValue];
    uint8 dTime = [[payload objectForKey:@"dryTime"] unsignedCharValue];
    uint16 remain = [[payload objectForKey:@"remainTime"] unsignedShortValue];
    uint8 pStatus = [[payload objectForKey:@"peopleStatus"] unsignedCharValue];
    
//    Unequal_Assign(machStatus, status)
//    Unequal_Assign(s_temperature, wTemp)
//    Unequal_Assign(s_pressure, wPressure)
//    Unequal_Assign(s_position, position)
//    Unequal_Assign(s_time, cTime)
//    Unequal_Assign(s_dryLevel, dLevel)
//    Unequal_Assign(s_dryTime, dTime)
//    Unequal_Assign(remainTime, remain)
//    Unequal_Assign(peopleStatus, pStatus)
    self.machStatus = status;
    self.s_temperature = wTemp;
    self.s_pressure = wPressure;
    self.s_position = position;
    self.s_time = cTime;
    self.s_dryLevel = dLevel;
    self.s_dryTime = dTime;
    self.remainTime = remain;
    self.peopleStatus = pStatus;
    
    Unequal_Assign(c_machStatus, status)
    Unequal_Assign(c_temperature, wTemp)
    Unequal_Assign(c_pressure, wPressure)
    Unequal_Assign(c_position, position)
    Unequal_Assign(c_time, cTime)
    Unequal_Assign(c_dryLevel, dLevel)
    Unequal_Assign(c_dryTime, dTime)
}

- (UIImage *)deviceIcon {
    return UIImage.toiletDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.toiletDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBToiletViewController");
}

#pragma mark - getter setter
- (RACCommand *)deviceState {
    if (!_deviceState) {
        @weakify(self)
        _deviceState = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self initializerState];
        }];
    }
    return _deviceState;
}

- (RACCommand *)operationMode {
    if (!_operationMode) {
        @weakify(self)
        _operationMode = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable sender) {
            @strongify(self)
            
            if (sender.isSelected) {
                return [RACSignal empty];
            }
            
            switch (sender.tag) {
                case 0://停止
                {
//                    self.machStatus = 0;
                    self.timeEnable = 1;
                   return [self stopAction];
                }
                    break;
                case 1://臀部
                {
                    self.c_machStatus = 1;
                    //默认
                    self.c_temperature = 3;
                    self.c_pressure = 2;
                    self.c_position = 2;
                    self.c_time = 180;
                    self.timeEnable = 1;
                    return [self startAction];
                }
                    break;
                case 2://女性洗净
                {
                    self.c_machStatus = 2;
                    self.c_temperature = 3;
                    self.c_pressure = 2;
                    self.c_position = 2;
                    self.c_time = 180;
                    self.timeEnable = 1;
                    return [self startAction];
                }
                    break;
                case 3://烘干
                {
                    self.c_machStatus = 3;
                    if (!self.c_dryLevel) {
                        self.c_dryLevel = 2;
                    }
                    self.c_dryTime = 240;
                    self.timeEnable = 1;
                    return [self startAction];
                }
                    break;
                case 4://儿童
                {
                    self.c_machStatus = 4;
                    self.c_temperature = 2;
                    self.c_pressure = 1;
                    self.c_position = 5;
                    self.c_dryLevel = 2;
                    self.c_time = 60;
                    self.c_dryTime = 120;
                    self.timeEnable = 1;
                    return [self startAction];
                }
                    break;
                case 5://男自动
                {
                    self.c_machStatus = 5;
                    self.c_temperature = 4;
                    self.c_pressure = 3;
                    self.c_position = 3;
                    self.c_dryLevel = 2;
                    self.c_time = 60;
                    self.c_dryTime = 240;
                    self.timeEnable = 1;
                    return [self startAction];
                }
                    break;
                case 6://女自动
                {
                    self.c_machStatus = 6;
                    self.c_temperature = 4;
                    self.c_pressure = 3;
                    self.c_position = 3;
                    self.c_dryLevel = 2;
                    self.c_time = 60;
                    self.c_dryTime = 240;
                    self.timeEnable = 1;
                    return [self startAction];
                }
                    break;
                case 7://冲水
                {
                    self.c_machStatus = 7;
                    self.timeEnable = 1;
                  return [self flushAction];
                }
                    break;
                    
                default:
                    break;
            }
            return [RACSignal empty];
        }];
    }
    return _operationMode;
}
- (RACCommand *)stateChange {
    if (!_stateChange) {
        @weakify(self)
        _stateChange = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self startAction];
        }];
    }
    return _stateChange;
}


@end
#pragma mark - DeviceOperatorSignal
@implementation TBToiletDeviceViewModel (DeviceOperatorSignal)

- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}
- (RACSignal *)startAction{

    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x2001];
    [payload setObject:@(self.c_machStatus) forKey:@"machControl"];
    [payload setObject:@(self.c_temperature) forKey:@"waterTemp"];
    [payload setObject:@(self.c_pressure) forKey:@"waterPa"];
    [payload setObject:@(self.c_position) forKey:@"pipePosit"];
    [payload setObject:@(self.c_time) forKey:@"cleanTime"];
    [payload setObject:@(self.c_dryLevel) forKey:@"dryStep"];
    [payload setObject:@(self.c_dryTime) forKey:@"dryTime"];
    [payload setObject:@(self.timeEnable) forKey:@"timeEnable"];
    
    TBLog(@"sendData--------------------->%@",payload);
    
    return [self dataToDevice:payload];
}

- (RACSignal *)flushAction{
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x2002];
    return [self dataToDevice:payload];
}

- (RACSignal *)stopAction{
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x2001];
    [payload setObject:@(0) forKey:@"machControl"];
    [payload setObject:@(0) forKey:@"waterTemp"];
    [payload setObject:@(0) forKey:@"waterPa"];
    [payload setObject:@(0) forKey:@"pipePosit"];
    [payload setObject:@(0) forKey:@"cleanTime"];
    [payload setObject:@(0) forKey:@"dryStep"];
    [payload setObject:@(0) forKey:@"dryTime"];
    [payload setObject:@(0) forKey:@"timeEnable"];
    return [self dataToDevice:payload];
}

@end
