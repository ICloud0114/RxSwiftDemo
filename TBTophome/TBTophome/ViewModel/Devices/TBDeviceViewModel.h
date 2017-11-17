//
//  TBDeviceViewModel.h
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBDeviceViewModel : ViewModel {
@protected
    HMDevice *_device;
}

- (instancetype)initWithDevice:(HMDevice *)device;

@property (nonatomic, readonly, strong) HMDevice *device;

/**
 设备是否在线
 */
@property (nonatomic, assign) BOOL online;

/**
 设备图标
 */
@property (nullable, nonatomic, readonly) UIImage *deviceIcon;

/**
 设备离线图标
 */
@property (nullable, nonatomic, readonly) UIImage *deviceOffIcon;

/**
 设备名字
 */
@property (nonatomic, copy, readonly) NSString *deviceName;


/**
 透传数据到设备
 */
- (RACSignal *)dataToDevice:(NSDictionary *)payload;

/**
 修改设备名字
 */
- (RACSignal *)modifyDeviceName:(NSString *)name;


/**
 获取payload

 @param tId  模板id
 @param cId  命令id
 @param scId 子命令id

 @return 返回payload
 */
- (NSMutableDictionary *)payloadWithTempletId:(NSInteger)tId cmdId:(NSInteger)cId subCmdId:(NSInteger)scId;


/**
 设备上报数据

 @param payload 负载数据
 @param cmd     命令id
 */
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd;
/**
 获取当前视图控制器对应的视图控制器类
 */
- (Class)viewControllerClass;
@end
NS_ASSUME_NONNULL_END
