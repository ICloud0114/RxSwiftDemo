//
//  DoorUserModel.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "HMBaseModel.h"

@interface HMDoorUserModel : HMBaseModel

@property (nonatomic, strong) NSString * doorUserId;

/**
 *  门锁编号
 */
@property (nonatomic, strong) NSString * deviceId;

/**
 *  授权id
 */
@property (nonatomic, assign) int authorizedId;

/**
 *  1指纹开锁
    2密码开锁（包含永久密码和临时密码，如果临时密码失效了必须在这张表里面也删除）
    3刷卡开锁
 */
@property (nonatomic, assign) int type;

/**
 *  用户名称，默认为空
 */
@property (nonatomic, strong) NSString * name;

/**
 *  获取当前门锁的成员数
 *
 *  @param device
 *
 *  @return
 */
+(int)memberNumForDevice:(HMDevice *)device;
/**
 *  获得对应名称 查临时授权人员
 *
 *  @param deviceID
 *
 *  @return
 */
+(NSArray *)selectNameWith:(NSString *)deviceID WithCeateTime:(NSString *)createTime WithUpdateTime:(NSString *)updateTime;

/**
 *  全部有开门权限的成员
 *
 *  @param deviceID authorId
 *
 *  @return
 */
+(NSMutableArray *)selectAllWith:(NSString *)deviceID;


/**
 *  拍过序的全体成员
 *
 *  @param deviceID authorId
 *
 *  @return
 */
+(NSMutableArray *)selectAllWithOrder:(NSString *)deviceID;


/**
 *  获得对应名称 查非临时用户
 *
 *  @param deviceID authorId
 *
 *  @return
 */
+(NSArray *)selectNameWith:(NSString *)deviceID WithAuthorId:(int )authorId;
/**
 *  获得对应名称 查最近一次开锁用户
 *
 *  @param deviceID authorId
 *
 *  @return
 */
+(NSString *)selectNameWith:(NSString *)deviceID With:(NSString *)createTime;

/**
 *  通过doorUserId来查询
 *
 *  @param doorUserId
 *
 *  @return
 */
+(HMDoorUserModel *)selectUserWithDoorUserId:(NSString *)doorUserId;
@end
