//
//  VihomeCameraInfo.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMCameraInfo : HMBaseModel

/**
*  主键、自增长
*/
@property (nonatomic, retain)NSString *        cameraInfoId;

/**
 *  摄像头在设备信息表的编号
 */
@property (nonatomic, retain)NSString *        deviceId;

/**
 *  摄像头地址
 */
@property (nonatomic, retain)NSString *         url;

/**
 *  端口号
 */
@property (nonatomic, assign)int                port;

/**
 *  0x00:530系列摄像头
 */
@property (nonatomic, assign)int                type;
/**
 *  摄像头UID
 */
@property (nonatomic, retain)NSString *         cameraUid;

/**
 *  用户名
 */
@property (nonatomic, retain)NSString *         user;

/**
 *  密码
 */
@property (nonatomic, retain)NSString *         password;


+ (int )selectTypeByDeviceId:(NSString *)deviceId;

+ (NSArray *)deviceIdArrayWithType:(int)type;
+ (NSArray *)UIDArrayWithType:(int)type;

@end
