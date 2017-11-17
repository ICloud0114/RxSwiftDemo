//
//  QueryClotheshorseStatusCmd.h
//  HomeMate
//
//  Created by Air on 15/11/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface QueryClotheshorseStatusCmd : BaseCmd

/**
 *  晾衣架设备列表 list 里面填写晾衣架的 deviceId
 */
@property (nonatomic, strong)NSArray * deviceList;
@end
