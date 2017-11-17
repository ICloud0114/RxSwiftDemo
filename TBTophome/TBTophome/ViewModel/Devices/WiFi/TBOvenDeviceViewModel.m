//
//  TBOvenDeviceViewModel.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBOvenDeviceViewModel.h"
@interface TBOvenDeviceViewModel(){
    
}

@property (nonatomic, strong) RACCommand *ovenState;

@property (nonatomic, strong) RACCommand *powerControl;
@property (nonatomic, strong) RACCommand *lightControl;
@property (nonatomic, strong) RACCommand *screenLock;
@property (nonatomic, strong) RACCommand *preHeating;
@property (nonatomic, strong) RACCommand *startHeating;
@property (nonatomic, strong) RACCommand *pauseHeating;
@property (nonatomic, strong) RACCommand *stopHeating;
@property (nonatomic, strong) RACCommand *changeTime;
@property (nonatomic, strong) RACCommand *timekeeping;
@property (nonatomic, strong) RACCommand *alertTime;

@end

@interface TBOvenDeviceViewModel (DeviceOperatorSignal)
- (RACSignal *)initializerState;
- (RACSignal *)powerAction:(BOOL)state;
- (RACSignal *)preheatingAction:(NSInteger )temp;
- (RACSignal *)startAction:(NSDictionary *)data;
- (RACSignal *)stopAction;
- (RACSignal *)pauseAction:(BOOL)state;
- (RACSignal *)lightAction:(BOOL)state;
- (RACSignal *)lockScreenAction:(BOOL)state;

- (RACSignal *)alertTimeAction:(NSInteger)time;
- (RACSignal *)changeTimeAction:(NSInteger)time;
- (RACSignal *)timekeepingAction:(NSInteger)time;
@end

@implementation TBOvenDeviceViewModel


#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    TBLog(@"cmd: %d", cmd)
    TBLog(@"payload: %@", payload)

//    displayMode       显示模式
//    workMode          工作模式
//    setWorkTime       设置工作时间
//    remainingWorkTime 剩余工作时间
//    remindTime        提醒时间
//    setTemp           设置温度
//    preheatingFlag    预热标识
//    startWorkFlag     开始工作标识
//    stopFlag          停止标识
//    pauseFlag         暂停标识
//    changeTimeFlag    改时标识
//    increaseTimeFlag  补时标识
//    faultCode         故障码
//    statusLight       状态灯
    
    
    
    uint8 light= [[payload objectForKey:@"statusLight"] unsignedCharValue];
    
    self.startWorkFlag =  [[payload objectForKey:@"startWorkFlag"] unsignedCharValue];
    self.preheatingFlag = [[payload objectForKey:@"preheatingFlag"] unsignedCharValue];
    
    
    Unequal_Assign(lightStatus, light)
    
    self.pauseFlag = [[payload objectForKey:@"pauseFlag"] unsignedCharValue];
    self.stopFlag =  [[payload objectForKey:@"stopFlag"] unsignedCharValue];
    self.increaseTimeFlag = [[payload objectForKey:@"increaseTimeFlag"] unsignedCharValue];
    self.changeTimeFlag =  [[payload objectForKey:@"changeTimeFlag"] unsignedCharValue];
    
    self.workMode = [[payload objectForKey:@"workMode"] unsignedShortValue];
    self.displayMode =  [[payload objectForKey:@"displayMode"] unsignedShortValue];
    
    self.remindTime = [[payload objectForKey:@"remindTime"] unsignedShortValue];
    self.remainingWorkTime = [[payload objectForKey:@"remainingWorkTime"] unsignedShortValue];
    self.setWorkTime = [[payload objectForKey:@"setWorkTime"] unsignedShortValue];
    self.setTemp =  [[payload objectForKey:@"setTemp"] unsignedShortValue];
    
}

- (UIImage *)deviceIcon {
    return UIImage.ovenDeviceIconImage;
}

- (UIImage *)deviceOffIcon {
    return UIImage.ovenDeviceOffIconImage;
}

- (Class)viewControllerClass {
    return NSClassFromString(@"TBOvenViewController");
}
#pragma mark - getter setter
- (RACCommand *)ovenState {
    if (!_ovenState) {
        @weakify(self)
        _ovenState = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self initializerState];
        }];
    }
    return _ovenState;
}
- (RACCommand *)powerControl{
    if (!_powerControl) {
        @weakify(self)
        _powerControl = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            
            return [self powerAction:!input.selected];
        }];
    }
    return _powerControl;
}
- (RACCommand *)lightControl{
    if (!_lightControl) {
        @weakify(self)
        _lightControl = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            
            return [self lightAction:!input.selected];
        }];
    }
    return _lightControl;
}
- (RACCommand *)screenLock{
    if (!_screenLock) {
        @weakify(self)
        _screenLock = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(UIButton *  _Nullable input) {
            
            return [self lockScreenAction:!input.selected];
        }];
    }
    return _screenLock;
}

- (RACCommand *)preHeating{
    if (!_preHeating) {
        @weakify(self)
        _preHeating = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *_Nullable input) {
            
            return [self preheatingAction:[input integerValue]];
        }];
    }
    return _preHeating;
}

- (RACCommand *)startHeating{
    if (!_startHeating) {
        @weakify(self)
        _startHeating = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *_Nullable input) {
            
            return [self startAction:input];
        }];
    }
    return _startHeating;
}

- (RACCommand *)pauseHeating{
    if (!_pauseHeating) {
        @weakify(self)
        _pauseHeating = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(UIButton * _Nullable input) {
            
            return [self pauseAction:input.selected];
        }];
    }
    return _pauseHeating;
}
- (RACCommand *)stopHeating{
    if (!_stopHeating) {
        @weakify(self)
        _stopHeating = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
            
            return [self stopAction];
        }];
    }
    return _stopHeating;
}

- (RACCommand *)changeTime{
    if (!_changeTime) {
        @weakify(self)
        _changeTime = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
            
            return [self changeTimeAction:[input integerValue]];
        }];
    }
    return _changeTime;
}
- (RACCommand *)timekeeping{
    if (!_timekeeping) {
        @weakify(self)
        _timekeeping = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
            
            return [self timekeepingAction:[input integerValue]];
        }];
    }
    return _timekeeping;
}

- (RACCommand *)alertTime{
    if (!_alertTime) {
        @weakify(self)
        _alertTime = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
            
            return [self alertTimeAction:[input integerValue]];
        }];
    }
    return _alertTime;
}


@end


#pragma mark - DeviceOperatorSignal
@implementation TBOvenDeviceViewModel (DeviceOperatorSignal)
//查询状态
- (RACSignal *)initializerState {
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1001];
    return [self dataToDevice:payload];
}
//电源开关
- (RACSignal *)powerAction:(BOOL)state{
    
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x1002];

    if (state) {
        [payload setObject:@(2) forKey:@"param"];
    }else{
        [payload setObject:@(3) forKey:@"param"];
    }
    return [self dataToDevice:payload];
}
//预热
- (RACSignal *)preheatingAction:(NSInteger )temp{
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x1003];
    [payload setObject:@(temp) forKey:@"param"];
    
    return [self dataToDevice:payload];
}
//开始烘烤
- (RACSignal *)startAction:(NSDictionary *)data{
    NSMutableDictionary * payload = [self payloadWithTempletId:4 cmdId:0x0001 subCmdId:0x1004];
    [payload setObject:data[@"displayMode"] forKey:@"displayMode"];
    [payload setObject:data[@"workMode"] forKey:@"workMode"];
    [payload setObject:data[@"setWorkTime"] forKey:@"setWorkTime"];
    [payload setObject:data[@"setTemp"] forKey:@"setTemp"];
    
    TBLog(@"send data---->%@",payload);
    return [self dataToDevice:payload];
}
//停止烘烤
- (RACSignal *)stopAction{
    NSMutableDictionary * payload = [self payloadWithTempletId:1 cmdId:0x0001 subCmdId:0x1005];
    return [self dataToDevice:payload];
}
//暂停烘烤
- (RACSignal *)pauseAction:(BOOL)state{
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x1006];
    if (state) {
        [payload setObject:@(1) forKey:@"param"];
    }else{
        [payload setObject:@(0) forKey:@"param"];
    }
    
    
    return [self dataToDevice:payload];
}

//炉灯控制
- (RACSignal *)lightAction:(BOOL) state{
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x1009];
    light_status_t light;
    int a = self.lightStatus;
    memcpy(&light, &a, sizeof(light_status_t));
    if (state) {
        light.oven_lamp = OVEN_OPERATION_ON;
    }else{
        light.oven_lamp = OVEN_OPERATION_OFF;
    }
    
    memcpy(&a, &light, 1);
    self.lightStatus = a;
    [payload setObject:@(a) forKey:@"param"];
    return [self dataToDevice:payload];
}
//锁屏
- (RACSignal *)lockScreenAction:(BOOL) state{
    NSMutableDictionary * payload = [self payloadWithTempletId:2 cmdId:0x0001 subCmdId:0x100a];
    light_status_t light;
    int a = self.lightStatus;
    memcpy(&light, &a, sizeof(light_status_t));
    if (state) {
        light.screen_lock = OVEN_OPERATION_ON;
    }else{
        light.screen_lock = OVEN_OPERATION_OFF;
    }
    
    memcpy(&a, &light, 1);
    self.lightStatus = a;
    [payload setObject:@(a) forKey:@"param"];
    return [self dataToDevice:payload];
}
//设置提醒时间
- (RACSignal *)alertTimeAction:(NSInteger)time{
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x100b];
    [payload setObject:@(time) forKey:@"param"];
    
    return [self dataToDevice:payload];
}

//更改烘烤时间
- (RACSignal *)changeTimeAction:(NSInteger)time{
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x1007];
    [payload setObject:@(time) forKey:@"param"];
    return [self dataToDevice:payload];
}
//烘烤补时
- (RACSignal *)timekeepingAction:(NSInteger)time{
    NSMutableDictionary * payload = [self payloadWithTempletId:3 cmdId:0x0001 subCmdId:0x1008];
    [payload setObject:@(time) forKey:@"param"];
    
    return [self dataToDevice:payload];
}
@end

