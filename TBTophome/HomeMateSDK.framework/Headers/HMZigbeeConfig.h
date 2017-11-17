//
//  HMZigbeeConfig.h
//  HomeMateSDK
//
//  Created by Air on 16/3/14.
//  Copyright © 2016年 orvibo. All rights reserved.
//

typedef NS_ENUM(NSInteger, HMZigbeeConfigResult) {
    
// 绑定主机用到的回调结果
    ZigbeeResult_NotInWIFIStatus,            //非wifi环境
    ZigbeeResult_NotFindHost,               // 局域网未搜索到主机
    ZigbeeResult_AllHostHasBeenBinded,      // 局域网索到的主机都已经被其他账号绑定
    ZigbeeResult_BindHostSuccess,           // 绑定主机成功
    ZigbeeResult_BindHostFailed,            // 绑定主机失败
    ZigbeeResult_BindDidntLoss,            //绑定信息未失效，可直接添加设备
    ZigbeeResult_HostHasBeenBinded,        //该主机已经被其他账号绑定

// 添加设备用到的回调结果
    ZigbeeResult_DeviceIsNotInConfigureMode,   //设备未处于配置模式
    
    ZigbeeResult_HostAndMobileIsNotInSameWifi,  // 主机跟手机并不处于同一wifi
    
    
    ZigbeeResult_HostHasInSearchMode,  // 主机已经处于组网模式
    
    ZigbeeResult_HostBindRelationshipHasLost,  // 主机绑定关系已失效
    
    ZigbeeResult_DidCanAddDevices,    // 一切验证通过，能添加设备，（用来开启倒计时）

    ZigbeeResult_AddDeviceFailOther,  // 其他原因导致的添加设备失败
    
    
    ZigbeeResult_SuccessAddedDevices,  // 成功添加一些设备
    
    ZigbeeResult_deletHostSuccess,      //删除主机成功
    ZigbeeResult_deletHostfailed,       //删除主机失败
    ZigbeeResult_HostNotOnline,         //设备不在线
};



typedef BOOL(^HMZigbeeConfigResultBlock)(HMZigbeeConfigResult result);

/**
 *  添加设备完成后的回调
 *
 *  @param result  返回添加结果，有可能失败
 *  @param devices 添加的设备
 */
typedef void (^HMAddDeviceFinishBlock)(HMZigbeeConfigResult result, NSArray *devices);

typedef void (^HMDeletHostResultBlock)(HMZigbeeConfigResult result);

@interface HMZigbeeConfig : SingletonClass



/**
 *  绑定zigbee主机
 *
 *  @param resultBlock 绑定结果
 */
+(void)bindZigbeeHost:(HMZigbeeConfigResultBlock)resultBlock;

+(void)DeleteZigbeeHost:(HMDeletHostResultBlock)resultBlock;

/**
 *  搜索zigbee设备
 *
 *  @param searchTime    自定义开启zigbee组网搜索设备的时间，最长250s
 *  @param addDevicesBlock 添加设备完成后返回 HMZigbeeConfigResult 和 已添加的设备devices
 *  
 *   HMZigbeeConfigResult 可能情况已在枚举中列明
 *   devies 可能情况为 nil 与 非nil
 *
 *
 *
 *   注：1.当且仅当 HMZigbeeConfigResult == ZigbeeResult_SuccessAddedDevices 时，devices参数才会返回非nil,  其他HMZigbeeConfigResult的情况，devices 都为nil
 *
 *   2.如果满足添加设备的条件:
 *    此方法会先返回   addDevicesBlock(ZigbeeResult_DidCanAddDevices,nil)，
 *    倒计时结束再返回  addDevicesBlock(ZigbeeResult_SuccessAddedDevices,devices)
 *
 */
- (void)searchZigbeeDeviceWithTime:(NSTimeInterval)searchTime completion:(HMAddDeviceFinishBlock)addDevicesBlock;


@end
