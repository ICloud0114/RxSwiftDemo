//
//  DoorLockRecordModel.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "HMBaseModel.h"

@interface HMDoorLockRecordModel : HMBaseModel

@property (nonatomic, strong) NSString * doorLockRecordId;

/**
 *  门锁编号
 */
@property (nonatomic, strong) NSString * deviceId;

/**
 *  开关锁的用户id，
    钥匙开锁的时候这里填0，
    锁门的时候填0
 */
@property (nonatomic, assign) int authorizedId;

/**
 *  1指纹开锁
    2密码开锁（包含永久密码和临时密码，如果临时密码失效了必须在这张表里面也删除）
    3刷卡开锁
    4 钥匙开锁
 */
@property (nonatomic, assign) int type;

/**
 *  单位，分钟 UTC时间
 */
@property (nonatomic, assign) int time;


@property (nonatomic, strong) NSString * name;

/**
 *  获得开锁总记录(allrecord为0是个人的开锁记录,否则则是总开锁记录)
 *
 *  @param deviceID authorId
 *
 *  @return
 */
+(NSMutableArray *)selectObjectWith:(NSString *)deviceID andLastMinTime:(int)time;

/**
 *  获得最新一次的开锁记录
 *
 *  @param deviceID
 *
 *  @return
 */
+(HMDoorLockRecordModel *)selectLastObjectWith:(NSString *)deviceID withAuthorizedId:(int )authorizedId;

/**
 *  清空开锁记录
 *
 *  @param deviceID
 *
 *  @return
 */
+(BOOL )deleteRecordWithDeviceId:(NSString *)deviceID;
@end
