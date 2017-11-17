//
//  EnergySaveDeviceModel.h
//  HomeMate
//
//  Created by liuzhicai on 15/12/22.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMEnergySaveDeviceModel : HMBaseModel

@property (nonatomic, retain)NSString *   deviceId;

@property (nonatomic, retain)NSString *   userId;

/**
 *  是否需要提醒标识   1-不提醒； 0 - 提醒
 */
@property (nonatomic, assign)int energySaveFlag;

@end
