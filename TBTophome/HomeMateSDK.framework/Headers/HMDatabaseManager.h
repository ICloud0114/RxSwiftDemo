//
//  BLDatabaseMgr.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMBaseModel.h"


typedef void(^FMBlock)(FMResultSet * rs);

typedef void(^FMSBlock)(FMResultSet * rs , BOOL *stop);

BOOL queryDatabase(NSString *sql , FMBlock queryBlock);
BOOL queryDatabaseStop(NSString *sql, FMSBlock stopBlock);


BOOL updateInsertDatabase(NSString *sql);
BOOL executeUpdate(NSString*sql, ...);
FMResultSet *executeQuery(NSString*sql, ...);

@interface HMDatabaseManager : NSObject


- (void)initDatabase;

+ (HMDatabaseManager *)shareDatabase;

/**查询数据库 - 主线程*/
- (FMResultSet *)executeQuery:(NSString*)sql, ...;

- (BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName;
- (BOOL)tableExists:(NSString*)tableName;
- (sqlite3*)sqliteHandle;

/**更新数据库 - 主线程*/
- (BOOL)executeUpdate:(NSString*)sql, ...;
/**更新数据库(可用?占位符) - 主线程*/
- (BOOL)executeUpdate:(NSString *)sql withVAList:(va_list)args;

/**数据库操作 - 子线程*/
- (void)inDatabase:(void (^)(FMDatabase *db))block;
/**数据库事务 - 子线程*/
- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

/**数据库操作 - 子线程*/
- (void)inSerialQueue:(void (^)(void))block;

- (NSMutableArray *)selectAllRecord:(Class<DBProtocol>)aClass withCondition:(NSString *)condition;
/**
 *  返回所有需要存储的数据表对应的类和表名键值对{tableName：class}
 *
 *  @return 数据表类和表名字典
 */

-(NSDictionary *)tableDic;

/**
 *  根据表的userId删除所有数据
 *
 *  @param userId 帐号唯一的Id
 *
 */
-(void)deleteAllWithUserId:(NSString *)userId;

/**
 *  根据表的uid删除所有数据
 *
 *  @param uid 主机/WiFi设备的uid
 *
 */
-(void)deleteAllWithUid:(NSString *)uid;

@end
