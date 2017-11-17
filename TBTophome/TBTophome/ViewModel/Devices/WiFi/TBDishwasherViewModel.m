//
//  TBDishwasherViewModel.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/23.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDishwasherViewModel.h"
@interface TBDishwasherViewModel(){
    
}
@property (nonatomic, strong) RACCommand *deviceState;
@property (nonatomic, strong) RACCommand *startWork;
@property (nonatomic, strong) RACCommand *selectCleanMode;
@property (nonatomic, strong) RACCommand *power;

@property (nonatomic, strong) RACCommand *mix3IN1;
@property (nonatomic, strong) RACCommand *lockCommand;

@property (nonatomic, strong) RACCommand *reservationCommand;

@end

@interface TBDishwasherViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;

- (RACSignal *)startAction;

@end
@implementation TBDishwasherViewModel

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)
    
    
    self.cleanMode = [[payload objectForKey:@"washingProgram"] unsignedCharValue];
    self.mixMode = [[payload objectForKey:@"3IN1"] unsignedCharValue];
    self.appointmentHour = [[payload objectForKey:@"appointmentHour"] unsignedCharValue];
    self.remainingMinute = [[payload objectForKey:@"appointmentRemainingMinute"] unsignedShortValue];
    self.childLock = [[payload objectForKey:@"childLock"] unsignedCharValue];
    self.faultCode = [[payload objectForKey:@"faultCode"] unsignedCharValue];
    
    self.warning = [[payload objectForKey:@"warning"] unsignedCharValue];
    
    self.status = [[payload objectForKey:@"switch"] unsignedCharValue];
}

- (UIImage *)deviceIcon {
    return UIImage.dishwasherIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.dishwasherOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBDishwasherViewController");
}


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


- (RACCommand *)startWork{
    if (!_startWork) {
        @weakify(self)
        _startWork = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            if (input.selected) {
                self.status = 4;
            }else{
                self.status = 3;
            }
            return [self startAction];
        }];
    }
    return _startWork;
}

- (RACCommand *)selectCleanMode{
    if (!_selectCleanMode) {
        @weakify(self)
        _selectCleanMode = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            self.appointmentHour = 0;
            return [self startAction];
        }];
    }
    return _selectCleanMode;
}

- (RACCommand *)power{
    if (!_power) {
        @weakify(self)
        _power = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            
            if (input.selected) {
                self.status = 1;
            }else{
                self.status = 2;
            }
            
            return [self startAction];
        }];
    }
    return _power;
}

- (RACCommand *)mix3IN1{
    if (!_mix3IN1) {
        @weakify(self)
        _mix3IN1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            
            if (input.selected) {
                self.mixMode = 1;
            }else{
                self.mixMode = 2;
            }
            
            return [self startAction];
        }];
    }
    return _mix3IN1;
}

- (RACCommand *)lockCommand{
    if (!_lockCommand) {
        @weakify(self)
        _lockCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            @strongify(self)
            
            if (input.selected) {
                self.childLock = 1;
            }else{
                self.childLock = 2;
            }
            
            return [self startAction];
        }];
    }
    return _lockCommand;
}


- (RACCommand *)reservationCommand{
    if (!_reservationCommand) {
        @weakify(self)
        _reservationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *  _Nullable input) {
            @strongify(self)
            self.appointmentHour = [input integerValue];
            return [self startAction];
        }];
    }
    return _reservationCommand;
}



@end
@implementation TBDishwasherViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState{
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}

- (RACSignal *)startAction{
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x1002];
    
    [payload setObject:@(self.status) forKey:@"switch"];
    [payload setObject:@(self.cleanMode) forKey:@"washingProgram"];
    [payload setObject:@(self.mixMode) forKey:@"3IN1"];
    [payload setObject:@(self.childLock) forKey:@"childLock"];
    [payload setObject:@(self.appointmentHour) forKey:@"appointmentHour"];
  
    TBLog(@"sendData--------------------->%@",payload);
    
    return [self dataToDevice:payload];
}

@end
