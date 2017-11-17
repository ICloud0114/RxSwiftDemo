//
//  HMSecurityWarningModel.h
//  HomeMate
//
//  Created by orvibo on 16/6/30.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMSecurityWarningModel : HMBaseModel

@property (nonatomic, retain) NSString *secWarningId;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *securityId;

// 0:app通知（默认）    1：app通知并电话提醒  
@property (nonatomic, assign) int warningType;

+ (HMSecurityWarningModel *)readTableWithSecurityId:(NSString *)securityId;

@end
