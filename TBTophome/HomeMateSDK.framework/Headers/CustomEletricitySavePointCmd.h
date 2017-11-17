//
//  CustomEletricitySavePointCmd.h
//  HomeMate
//
//  Created by liuzhicai on 16/7/27.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

/**
 *  3.4.62	自定义配电箱电流保护点
 */
@interface CustomEletricitySavePointCmd : BaseCmd

@property (nonatomic, copy)NSString *deviceId;

/**
 *  True:开启自定义
 *  False:默认
 */
@property (nonatomic, assign)BOOL isEnable;

/**
 *  电流值
 */
@property (nonatomic, assign)int protectVal;

/**
 *  保护电流持续时间(s)
 */
@property (nonatomic, assign)int protectTime;

@end
