//
//  HMAppMyCenter.h
//  HomeMateSDK
//
//  Created by liqiang on 17/5/10.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface HMAppMyCenter : HMBaseModel
@property (nonatomic, strong) NSString *myCenterId;
@property (nonatomic, strong) NSString *factoryId;
@property (nonatomic, assign) int sequence;
@property (nonatomic, assign) int verCode;
@property (nonatomic, assign) int groupIndex;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *viewId;
@end
