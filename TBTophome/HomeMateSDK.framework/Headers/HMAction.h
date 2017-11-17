//
//  VihomeAction.h
//  Vihome
//
//  Created by Ned on 4/21/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAction : HMBaseModel <OrderProtocol>

@property (nonatomic, strong) NSString *       bindOrder;

@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;

@property (nonatomic, assign)int                hue;

@property (nonatomic, assign)int                saturation;

@property (nonatomic, strong) NSString *       deviceId;

- (void)copyValueFromCommonObject:(id)value;

- (void)fillValueToCommonObject:(id)value;

@end
