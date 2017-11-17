//
//  HMMessageSecurityModel.h
//  HomeMateSDK
//
//  Created by user on 16/10/11.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface HMMessageSecurityModel : HMBaseModel

@property (nonatomic, strong)NSString *messageSecurityId;

@property (nonatomic, strong)NSString *userId;

@property (nonatomic, strong)NSString *deviceId;

@property (nonatomic, strong)NSString *text;

@property (nonatomic, strong)NSString *params;

/**
 *  是否已读     0:未读   1：已读
 */
@property (nonatomic, assign)int readType;

@property (nonatomic, assign) int time;

@property (nonatomic, assign) int deviceType;

@property (nonatomic, assign) int value1;
@property (nonatomic, assign) int value2;
@property (nonatomic, assign) int value3;
@property (nonatomic, assign) int value4;

@property (nonatomic, assign) int sequence;

@property (nonatomic, assign) int isPush;

+(NSMutableArray *)selectDataByUserIdLimitCount:(NSInteger )count;
+ (int)getMaxSequenceNum;
+ (int)getMinSequenceNum;

+ (BOOL)isHasUnreadData;
+ (void)updateMessageSecuritySetReadType1;

+(int )selectAllDataCount;
+ (BOOL)hasUreadDataWithFamilyId:(NSString *)familyId;

+ (int)getMaxSequenceNumWithFamilyld:(NSString *)familyld;


@end
