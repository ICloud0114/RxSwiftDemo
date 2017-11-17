//
//  HMChannelCollectionModel.h
//  HomeMate
//
//  Created by orvibo on 16/7/18.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMChannelCollectionModel : HMBaseModel

// uid 小方 UID
@property (nonatomic, strong) NSString *channelCollectionId;
@property (nonatomic, assign) int channelId;
@property (nonatomic, assign) int isHd; ///< 0:标清 1:高清
@property (nonatomic, strong) NSString *deviceId;   ///< 设备编号
@property (nonatomic, strong) NSString *countryId;  ///< 国家编号，与酷控sdk的countryId对应
@property (nonatomic, assign) int updateTimeSec;

- (NSArray *)readAllCollectChannelWithDeviceId:(NSString *)deviceId;
- (NSArray *)getAllCollectChannelId;

@end
