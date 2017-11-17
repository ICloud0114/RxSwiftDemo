//
//  TBRiceCookerDeviceViewModel.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBRiceCookerDeviceViewModel.h"

@interface TBRiceCookerDeviceViewModel()
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *startCook;
@property (nonatomic, strong) RACCommand *stopCook;
@property (nonatomic, strong) RACCommand *warm;
@property (nonatomic, strong) RACCommand *reservation;
@property (nonatomic, strong) RACCommand *cookTiming;
@property (nonatomic, strong) RACCommand *timeAdjust;
@property (nonatomic, strong) RACCommand *cookMode;

@end

@interface TBRiceCookerDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;

- (RACSignal *)startAction;
- (RACSignal *)stopAction;
- (RACSignal *)warmAction;
- (RACSignal *)reservationAction;
@end

@implementation TBRiceCookerDeviceViewModel


#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
//    TBLog(@"cmd: %d", cmd)
//    工作状态 1byte：
//    01H 启动02H 取消-进入待机03H 打开保温 04h 预约
//    工作模式 1byte：
//    01H少量煮	 02H煲汤03H蒸煮04H蛋糕05H柴火饭06H 煮粥07H 稀饭
//    工作时间小时 1byte：
//    工作时间分钟 1byte：
//    
//    预约时间小时 1byte：
//    预约时间分钟 1byte：
//    TBLog(@"状态---->%@",payload);
    self.reservationTime = [payload[@"appointmentTimeHour"] unsignedCharValue] * 60 + [payload[@"appointmentTimeMinute"] unsignedCharValue];
    self.workTime = [payload[@"workTimeHour"] unsignedCharValue] * 60 + [payload[@"workTimeMinute"] unsignedCharValue];
    
    
    self.workMode = [payload[@"workMode"] unsignedCharValue];
    
    self.workStatus = [payload[@"workStatus"] unsignedCharValue];
    
    if (self.workStatus == 4) {
        self.showTime = self.reservationTime;
    }else if(self.workStatus == 1){
        self.showTime = self.workTime;
    }else{
        self.showTime = 0;
    }

    self.isReservation = NO;
    self.isCookTiming = NO;
    self.timeSetting = 0;

}

- (UIImage *)deviceIcon {
    return UIImage.riceCookerIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.riceCookerOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBRiceCookerViewController");
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

- (RACCommand *)startCook {
    if (!_startCook) {
        @weakify(self)
        _startCook = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            if (self.reservationTime) {
                self.isReservation = NO;
                self.isCookTiming = NO;
                self.showTime = self.reservationTime;
                return [self reservationAction];
            }
            self.isReservation = NO;
            self.isCookTiming = NO;
            self.showTime = self.workTime;
            return [self startAction];
        }];
    }
    return _startCook;
}
- (RACCommand *)stopCook {
    if (!_stopCook) {
        @weakify(self)
        _stopCook = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            self.isReservation = NO;
            self.isCookTiming = NO;
            self.timeSetting = 0;
            self.reservationTime = 0;
            self.showTime = 0;
            return [self stopAction];
        }];
    }
    return _stopCook;
}
- (RACCommand *)warm {
    if (!_warm) {
        @weakify(self)
        _warm = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self warmAction];
        }];
    }
    return _warm;
}
- (RACCommand *)reservation {
    if (!_reservation) {
        @weakify(self)
        _reservation = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            self.isReservation = YES;
            self.timeSetting = 1;
            self.showTime = self.reservationTime;
            return [RACSignal empty];
        }];
    }
    return _reservation;
}
- (RACCommand *)cookTiming {
    if (!_cookTiming) {
        @weakify(self)
        _cookTiming = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            self.timeSetting = 2;
            self.isCookTiming = YES;
            self.showTime = self.workTime;
            return [RACSignal empty];
        }];
    }
    return _cookTiming;
}
- (RACCommand *)cookMode {
    if (!_cookMode) {
        @weakify(self)
        _cookMode = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton * _Nullable input) {
            @strongify(self)
            if (self.workMode != input.tag) {
                self.workMode = input.tag;
                self.timeSetting = 0;
                self.isCookTiming = NO;
                self.isReservation = NO;
                self.reservationTime = 0;
            }else{
                return  [RACSignal empty];
            }
            switch (self.workMode) {
                case 1:
                {
                    self.workTime = 0;
                }
                    break;
                case 2:
                {
                    self.workTime = 120;
                }
                    break;
                case 3:
                {
                    self.workTime = 60;
                }
                    break;
                case 4:
                {
                    self.workTime = 50;
                }
                    break;
                case 5:
                {
                    self.workTime = 0;
                }
                    break;
                case 6:
                {
                    self.workTime = 60;
                }
                    break;
                case 7:
                {
                    self.workTime = 60;
                }
                    break;
                    
                default:
                    break;
            }
            self.showTime = self.workTime;
            return [RACSignal empty];
            
        }];
    }
    return _cookMode;
}
- (RACCommand *)timeAdjust {
    if (!_timeAdjust) {
        @weakify(self)
        _timeAdjust = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            
            if (self.timeSetting == 1)//预约
            {
                NSInteger reservation = self.reservationTime;
                if ([input boolValue]) {//增加
                    reservation += 10;
                    
                } else {
                    reservation -= 10;
                    
                }
                if (reservation > 1440) {
                    reservation = 0;
                }else if(reservation < 0)
                {
                    reservation = 1440;
                }
                self.reservationTime = reservation;
                self.showTime = self.reservationTime;
            }else if(self.timeSetting == 2)
            {
                NSInteger workTime = self.workTime;
                if ([input boolValue]) {//增加
                    workTime += 1;
                    
                } else {
                    workTime -= 1;
                }
                if (self.workMode == 2) {
                    if (workTime< 90) {
                        workTime = 90;
                    }else if(workTime > 180){
                        workTime = 180;
                    }
                    
                }else if(self.workMode == 3){
                    if (workTime< 30) {
                        workTime = 30;
                    }else if(workTime > 90){
                        workTime = 90;
                    }
                    
                }else if(self.workMode == 6){
                    if (workTime< 60) {
                        workTime = 60;
                    }else if(workTime > 120){
                        workTime = 120;
                    }
                    
                }else if(self.workMode == 7){
                    if (workTime< 45) {
                        workTime = 45;
                    }else if(workTime > 75){
                        workTime = 75;
                    }
                    
                }
                self.workTime = workTime;
                self.showTime = self.workTime;
                
            }
            return [RACSignal empty];
        }];
    }
    return _timeAdjust;
}
@end

@implementation TBRiceCookerDeviceViewModel (DeviceOperatorSignal)
//获取设备初始状态
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}


- (RACSignal *)startAction;
{
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x1002];
    [payload setObject:@(self.workMode) forKey:@"workMode"];
    [payload setObject:@(self.workTime / 60) forKey:@"workTimeHour"];
    [payload setObject:@(self.workTime % 60) forKey:@"workTimeMinute"];
    TBLog(@"send Data-->%@",payload);
     return [self dataToDevice:payload];
}
- (RACSignal *)stopAction;
{
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1003];
    TBLog(@"send Data-->%@",payload);
     return [self dataToDevice:payload];
}
- (RACSignal *)warmAction;
{
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1004];
    TBLog(@"send Data-->%@",payload);
     return [self dataToDevice:payload];
}
- (RACSignal *)reservationAction;
{
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x1005];
    [payload setObject:@(1) forKey:@"appointmentAction"];
    [payload setObject:@(self.workMode) forKey:@"workMode"];
    [payload setObject:@(self.workTime / 60) forKey:@"workTimeHour"];
    [payload setObject:@(self.workTime % 60) forKey:@"workTimeMinute"];
    [payload setObject:@(self.reservationTime / 60) forKey:@"appointmentTimeHour"];
    [payload setObject:@(self.reservationTime % 60) forKey:@"appointmentTimeMinute"];
    
    TBLog(@"send Data-->%@",payload);
     return [self dataToDevice:payload];
}


@end
