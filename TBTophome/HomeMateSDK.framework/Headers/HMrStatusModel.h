//
//  HMrStatusModel.h
//  HomeMate
//
//  Created by Air on 16/3/2.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMrStatusModel : HMBaseModel

@property (nonatomic, retain)   NSString *   rStatusId;
@property (nonatomic, retain)   NSString *   deviceId;

//对于开关型的设备，value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
@property (nonatomic, assign)int                value1;
@property (nonatomic, assign)int                value2;
@property (nonatomic, assign)int                value3;
@property (nonatomic, assign)int                value4;

+ (NSMutableArray *)readTableWithDeviceId:(NSString *)deviceId;

@end
