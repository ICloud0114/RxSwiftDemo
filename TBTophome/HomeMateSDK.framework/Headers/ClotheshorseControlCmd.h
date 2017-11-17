//
//  ClotheshorseControlCmd.h
//  HomeMate
//
//  Created by Air on 15/11/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ClotheshorseControlCmd : BaseCmd

@property (nonatomic, strong)NSString * deviceId;

/**
 *  电机控制,需要控制才带入此项,与其他选项互斥 up down stop
 */
@property (nonatomic, strong)NSString * motorCtrl;

/**
 *  照明控制,需要控制才带入此项,与其他选项互斥 on off
 */
@property (nonatomic, strong)NSString * lightingCtrl;

/**
 *  消毒控制,需要控制才带入此项,与其他选项互斥  on off
 */
@property (nonatomic, strong)NSString * sterilizingCtrl;

/**
 *  烘干控制,需要控制才带入此项,与其他选项互斥  on off
 */
@property (nonatomic, strong)NSString * heatDryingCtrl;

/**
 *  风干控制,需要控制才带入此项,与其他选项互斥  on off
 */
@property (nonatomic, strong)NSString * windDryingCtrl;

/**
 *  总控开关,需要控制才带入此项,与其他选项互斥
 */
@property (nonatomic, strong)NSString * mainSwitchCtrl;

/**
 *  查询状态,需要控制才带入此项,与其他选项互斥 on
 */
@property (nonatomic, strong)NSString * queryState;

/**
 *  客户端SessionId
 */
@property (nonatomic, strong)NSString * clientSessionId;

@end
