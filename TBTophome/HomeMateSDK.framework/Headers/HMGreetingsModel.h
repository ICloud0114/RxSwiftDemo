//
//  GreetingsModel.h
//  
//
//  Created by Air on 15/12/1.
//
//

#import "HMBaseModel.h"

@interface HMGreetingsModel : HMBaseModel

@property (nonatomic, assign) int greentingId;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, assign) int week;
@property (nonatomic, strong) NSString * language;
@property (nonatomic, assign) int greetingVersion;

/**
 *  从数据库里面查询保存在本地的问候语
 *
 *  @return
 */
+(NSString *)greetings;

/**
 *  异步获取问候语，获取问候语成功之后，finishBlock在主线程执行
 *
 *  @param finishBlock
 *
 *  @return
 */
+(void)getGreetingsFromServerWithCompletion:(VoidBlock)finishBlock;

@end
