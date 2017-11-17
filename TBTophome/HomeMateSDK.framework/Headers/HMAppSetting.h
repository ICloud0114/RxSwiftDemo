//
//  HMAppSetting.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/4/28.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAppSetting : HMBaseModel


@property (nonatomic, strong) NSString *factoryId;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *bgColor;
@property (nonatomic, strong) NSString *fontColor;
@property (nonatomic, strong) NSString *topicColor;
@property (nonatomic, strong) NSString *securityBgColor;
@property (nonatomic, assign) int startSec;
@property (nonatomic, strong) NSString *qqAuth;
@property (nonatomic, strong) NSString *wechatAuth;
@property (nonatomic, strong) NSString *weiboAuth;
@property (nonatomic, strong) NSString *xiaoFAuthority;
@property (nonatomic, strong) NSString *daLaCoreCode;
@property (nonatomic, strong) NSString *scanBarEnable;
@property (nonatomic, assign) int smsRegisterEnable;
@property (nonatomic, assign) int emailRegisterEnable;


@property (nonatomic, strong) UIColor *controllerBgColor;
@property (nonatomic, strong) UIColor *lableFontColor;
@property (nonatomic, strong) UIColor *appTopicColor;
@property (nonatomic, strong) UIColor *securityColor;
@end
