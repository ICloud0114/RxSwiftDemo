//
//  HMWarningMemberModel.h
//  HomeMate
//
//  Created by orvibo on 16/6/30.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMWarningMemberModel : HMBaseModel

@property (nonatomic, retain) NSString *warningMemberId;
@property (nonatomic, retain) NSString *secWarningId;
@property (nonatomic, assign) int memberSortNum;
@property (nonatomic, retain) NSString *memberName;
@property (nonatomic, retain) NSString *memberPhone;

+ (NSMutableArray *)readTableWithSecWarningId:(NSString *)secWarningId;

+ (BOOL)existMemberWithWarningMemberId:(NSString *)memberId;

+ (NSUInteger)readMaxMemberSortNumWithSecWarningId:(NSString *)secWarningId;

+ (NSUInteger)readMemberCountWithSecWarningId:(NSString *)secWarningId;

@end
