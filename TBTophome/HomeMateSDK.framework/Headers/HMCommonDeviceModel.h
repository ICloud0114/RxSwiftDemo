//
//  CommonDeviceModel.h
//  
//
//  Created by Air on 15/12/4.
//
//

#import "HMBaseModel.h"

@interface HMCommonDeviceModel : HMBaseModel

@property (nonatomic, retain)NSString *   deviceId;
/**
 *  常用设备标识   1-常用； 0 - 不常用
 */
@property (nonatomic, assign)int commonFlag;

@end
