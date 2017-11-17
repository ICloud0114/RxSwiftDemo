//
//  HMAppSettingLanguage.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/4/28.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAppSettingLanguage : HMBaseModel

@property (nonatomic, strong) NSString *factoryId;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyContact;
@property (nonatomic, strong) NSString *companyTel;
@property (nonatomic, strong) NSString *companyMail;
@property (nonatomic, strong) NSString *emailCtx;
@property (nonatomic, strong) NSString *smsCtx;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *startTxt;
@property (nonatomic, strong) NSString *agreementUrl;
@property (nonatomic, strong) NSString *shopUrl;
@property (nonatomic, strong) NSString *adviceUrl;
@property (nonatomic, strong) NSString *sourceUrl;
@property (nonatomic, strong) NSString *updateHistoryUrl;

@end
