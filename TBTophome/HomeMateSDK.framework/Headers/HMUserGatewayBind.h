//
//  VihomeUserGatewayBind.h
//  Vihome
//
//  Created by Air on 15/7/24.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMUserGatewayBind : HMBaseModel

@property (nonatomic, retain)NSString *             bindId;

@property (nonatomic, retain)NSString *             userId;
@property (nonatomic, retain)NSString *             saveTime;


@property (nonatomic, assign)int                    userType;
#ifdef __YDHome__

@property (nonatomic, copy) NSString *             longitude;
@property (nonatomic, copy) NSString *             latotide;
@property (nonatomic, copy) NSString *             country;
@property (nonatomic, copy) NSString *             city;
@property (nonatomic, copy) NSString *             state;

#endif
/**
 *  是否存在特定userType的COCO，只有userType为0才有该COCO的所有权限，包括分享给其他人
 *
 *  @param userType 0：超级用户，1：管理员；2：普通用户。
 *
 *  @return YES:存在， NO:不存在
 */
+(BOOL)hasBindCOCOUserType:(int)userType;


/**
 *  是否存在特定userType特定uid的COCO，只有userType为0才有该COCO的所有权限，包括分享给其他人
 *
 *  @param userType 0：超级用户，1：管理员；2：普通用户。
 *  @param uid      COCO uid
 *
 *  @return YES:存在， NO:不存在
 */
+(BOOL)hasBindCOCOWithUid:(NSString *)uid UserType:(int)userType;

// 查询当前账户是否有指定uid的操作权限
+(BOOL)hasAuthority:(NSString *)uid;


#ifdef __YDHome__

/**
 *  获取设备对应的国家
 *
 *  @param device
 *
 *  @return
 */
+ (HMUserGatewayBind *)getCountryDevice:(HMDevice *)device;

#endif


/**
 *  查找某一台设备是否属于该用户还是被分享而来
 *
 *  @param uid      wifi设备 uid
 *
 *  @return 0:属于该用户  其它:被分享得到
 */
+(NSInteger )selectUserTypeByUid:(NSString *)uid;

@end
