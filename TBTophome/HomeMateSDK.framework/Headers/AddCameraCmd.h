//
//  AddCameraCmd.h
//  Vihome
//
//  Created by Air on 15-3-10.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddCameraCmd : BaseCmd

@property (nonatomic, assign)int type;  // 摄像头类型

@property (nonatomic, retain)NSString * cameraUID; // 摄像头uid

@property (nonatomic, retain)NSString * user; // 摄像头用户名

@property (nonatomic, retain)NSString * password; // 摄像头密码

@end
