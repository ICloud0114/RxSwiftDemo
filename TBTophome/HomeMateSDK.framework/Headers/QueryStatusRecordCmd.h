//
//  QueryStatusRecordCmd.h
//  HomeMate
//
//  Created by liuzhicai on 16/6/30.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface QueryStatusRecordCmd : BaseCmd

@property (nonatomic, strong)NSString * deviceId;

/*
   通过最大、最小序号，服务器就知道怎么返回数据：
 
   最大填-1，最小填数据库的最大序号 MaxDbSequence，则服务器倒序返回大于 MaxDbSequence 的数据
 
   最大填数据库的某一序号 sequence1，最小填-1，则服务器倒序返回大于 sequence1 的数据


 
 */


/**
 *  最小序号，没有或者不知道值时填-1
 */
@property (nonatomic, assign)int minSequence;

/**
 *  最大序号，没有或者不知道值时填-1
 */
@property (nonatomic, assign)int maxSequence;

/**
 *  每次上/下拉刷新时读取的数据条数，默认20条，最多50条
 */
@property (nonatomic, assign)int readCount;

@end
