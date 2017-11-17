//
//  SetDeviceParamCmd.h
//  HomeMateSDK
//
//  Created by Air on 17/3/7.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface SetDeviceParamCmd : BaseCmd

@property (nonatomic, strong)NSString * deviceId;
@property (nonatomic, strong)NSString * paramId;
@property (nonatomic, assign)int paramType;
@property (nonatomic, retain)NSString * paramValue;

@end
