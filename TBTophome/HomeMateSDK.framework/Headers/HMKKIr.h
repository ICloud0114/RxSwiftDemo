//
//  HMKKIr.h
//  HomeMate
//
//  Created by orvibo on 16/4/11.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMKKIr : HMBaseModel

/**
 *  酷控红外码表id
 */
@property (nonatomic, copy) NSString *kkIrId;

/**
 *  遥控器id
 */
@property (nonatomic, assign) int rid;

/**
 *  按键id
 */
@property (nonatomic, assign) int fid;

/**
 *  键码key，如：power
 */
@property (nonatomic, copy) NSString *fKey;

/**
 *  键码名称，如：电源
 */
@property (nonatomic, copy) NSString *fName;

/**
 *  系统码，如：0E0E
 */
@property (nonatomic, copy) NSString *sCode;

/**
 *  键码，如：0C
 */
@property (nonatomic, copy) NSString *dCode;

/**
 *  格式码
 */
@property (nonatomic, assign) int format;

/**
 *  红外码序列
 */
@property (nonatomic, copy) NSString *pluse;

/**
 *  载波频率
 */
@property (nonatomic, assign) int freq;

/**
 *  设备id
 */
@property (nonatomic, copy) NSString *deviceId;

/**
 *  0：普通的按键
 *  1：绑定的按键, 对于绑定的按键，只需要根据当前设备deviceId和绑定按键的fid和keyType==1找到bindDeviceId，再从kkIr中根据获取到的bindDeviceId即被绑定设备的deviceId得到按键信息
 */
@property (nonatomic, assign) int keyType;

/**
 *  设备表外键deviceId
 *  当keyType为1的时候有效，此时rid和fid里面填写的也是绑定的device的值，其他的值都填空，需要用到这个红外码的时候需要重新去查。
 */
@property (nonatomic, copy) NSString *bindDeviceId;


+ (BOOL)deleteObjectWithKKIrId:(NSString *)kkIrId;

+ (BOOL)deletePluseWithKKIrId:(NSString *)kkIrId;

+ (NSArray *)irArrayWithDeviceId:(NSString *)deviceId;

/**
 *  找到当前设备某个绑定按键所属的设备
 *
 *  @param deviceId 当前设备的deviceId
 *  @param uid      当前设备的uid
 *  @param fid      绑定按键的fid
 *
 *  @return
 */
+ (HMDevice *)bindDeviceWithDeviceId:(NSString *)deviceId uid:(NSString *)uid fid:(int)fid;

/**
 *  获取绑定按键的HMKKIr对象
 *
 *  @param deviceId 设备的deviceId
 *  @param fid      按键id
 *
 *  @return
 */
+ (HMKKIr *)bindKKIrWithDeviceId:(NSString *)deviceId fid:(int)fid;

/**
 *  获取设备的指定按键信息
 *
 *  @param deviceId
 *  @param rid
 *  @param fid
 *
 *  @return
 */
+ (instancetype)objectWithDeviceId:(NSString *)deviceId rid:(int)rid fid:(int)fid;

/**
 *  更新按键的名称
 */
+ (BOOL)updatefNameAndKeyName:(NSString *)name kkIrId:(NSString *)kkIrId;

/**
 *  根据deviceId删除kkIr数据
 */
+ (BOOL)deleteWithDeviceId:(NSString *)deviceId;

@end



























