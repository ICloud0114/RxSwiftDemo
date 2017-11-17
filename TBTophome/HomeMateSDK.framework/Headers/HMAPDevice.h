//
//  VHAPDevice.h
//  HomeMate
//
//  Created by Orvibo on 15/8/11.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HMAPDevice : NSObject
/**
 *  设备名称
 *  E10：COCO插线板（汉枫模块版本）, CoCo：COCO插线板
 *
 */
@property (nonatomic, copy) NSString * deviceName;


/**
 * 12字节数据,设备的MAC地址(小写,无分割符)
 */
@property (nonatomic, copy) NSString * mac;


/**
 *  配网协议版本 从1开始
 */
@property (nonatomic, copy) NSString * protocolVersion;



/**
 *  固件版本号
 */
@property (nonatomic, copy) NSString * softwareVersion;


/**
 *  硬件版本号
 */
@property (nonatomic, copy) NSString * hardwareVersion;


/*
COCO插线板（汉枫版本）：
7f831d28984a456698dce9372964caf3

COCO插线板（乐鑫版本）：
2a9131f335684966a86c54ca784520d7

一栋WiFi插座：
9cddfe4851ee47348e6e2df06fb9e945

飞雕COCO插线板：
22a70be5d60944f7b50d26b78eeebf01

紫程晾衣架：
5e9ccae98b1b47f6935072d8c6e36be3

奥科晾衣架：
68bb3f1a74284e2189227bc0259d3363

S20c：
56d124ba95474fc98aafdb830e933789
 */
@property (nonatomic, copy) NSString * modelId;


@end
