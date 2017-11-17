//
//  SetPowerConfigureSortList.h
//  HomeMate
//
//  Created by liuzhicai on 16/7/27.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

/**
 *  3.4.60	设置配电箱排序
 */
@interface SetPowerConfigureSortList : BaseCmd


/**
 *  排序后的deviceId数组
 */
@property (nonatomic, strong)NSArray *deviceIdList;

@end
