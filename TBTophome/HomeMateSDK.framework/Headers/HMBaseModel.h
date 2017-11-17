//
//  DBModel.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderProtocol

@optional
@property (nonatomic, strong) NSString *       deviceId;
@property (nonatomic, strong) NSString *       actionName;
@property (nonatomic, assign) int freq;
@property (nonatomic, assign) int pluseNum;
@property (nonatomic, copy) NSString * pluseData;


@required
@property (nonatomic, strong)NSString *         bindOrder;

@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;

@end


@protocol SceneEditProtocol <OrderProtocol>

@optional

@property (nonatomic, strong)NSString *          sceneBindId;       // 情景绑定
@property (nonatomic, strong)NSString *          linkageOutputId;   // 联动output

@property (nonatomic, strong)NSString *          model;         // 设备的model
@property (nonatomic, retain)NSString *         company;        // 厂商
@property (nonatomic, assign)KDeviceID          appDeviceId;    // 设备的appDeviceId
@property (nonatomic, assign)int                endPoint;
@property (nonatomic, strong)NSString *         extAddr;

+ (instancetype)deviceObject:(FMResultSet *)rs;

// 情景编辑设备时使用
+ (instancetype)bindObject:(FMResultSet *)rs;

- (id)copy;

@required

@property (nonatomic, strong) NSString *        uid;
@property (nonatomic, assign)int                delayTime;
@property (nonatomic, strong)NSString *         deviceId;

@property (nonatomic, strong)NSString *         deviceName;
@property (nonatomic, strong)NSString *         floorRoom;
@property (nonatomic, strong)NSString *         roomId;
@property (nonatomic, assign)int                deviceType;



@property (nonatomic, assign) BOOL              selected;
@property (nonatomic, assign,readonly) BOOL     isLearnedIR;
@property (nonatomic, assign,readonly) BOOL     changed;




@end


@protocol DBProtocol

@required

/**
 *  从数据库查询出记录结果后生成对象
 *
 *  @param set 记录集
 *
 *  @return 实例对象
 */
+ (instancetype)object:(FMResultSet *)rs;

/**
 *  从网络获取json数据后生成对象
 *
 *  @param dic 字典
 *
 *  @return 实例对象
 */
+ (instancetype)objectFromDictionary:(NSDictionary *)dic;

/**  建表 */
+ (BOOL)createTable;
- (BOOL)insertObject;

- (BOOL)updateObject;

- (BOOL)deleteObject;

+ (NSString *)tableName;

/** 更新/插入数据库数据的sql语句 - 支持事务 */
- (NSString *)updateStatement;



/**更新数据库 - 主线程*/
- (BOOL)executeUpdate:(NSString*)sql, ...;
+ (BOOL)executeUpdate:(NSString*)sql, ...;
- (BOOL)executeUpdateWithPlaceHolder:(NSString *)sql, ...;

/**查询数据库 - 主线程*/
- (FMResultSet *)executeQuery:(NSString*)sql, ...;
+ (FMResultSet *)executeQuery:(NSString*)sql, ...;

+ (BOOL)columnExists:(NSString*)columnName;

@optional
/**
 *  根据网关 uid 和 表记录的主键来查找对应的记录，返回个实例对象
 *
 *  @param UID      zigbee 网关uid 或 wifi设备自己的uid
 *  @param recordID
 *
 *  @return
 */
+ (instancetype)objectFromUID:(NSString *)UID recordID:(NSString *)recordID;

/** 创建内建有关联的触发器 */
+ (BOOL)createTrigger;

- (NSDictionary *)dictionaryFromObject;

/** 插入数据 - 支持事务 */
- (void)setInsertWithDb:(FMDatabase *)db;
@end

@interface HMBaseModel : NSObject<DBProtocol>

@property (nonatomic, strong) NSString *             uid;
@property (nonatomic, strong) NSString *             familyId;
//@property (nonatomic, strong) NSString *             userId;
@property (nonatomic, strong) NSString *             updateTime;
@property (nonatomic, strong) NSString *             createTime;

/** 删除标志 */
@property (nonatomic, assign)int                delFlag;

/** 事务操作时的更新/插入语句 */
@property (nonatomic, strong)NSString *         sql;

@end
