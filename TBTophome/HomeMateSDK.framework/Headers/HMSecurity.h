//
//  HMSecurity.h
//  HomeMate
//
//  Created by orvibo on 16/3/4.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMSecurity : HMBaseModel

@property (nonatomic, copy) NSString *securityId;

/**
 *  名称，1-16字节
 */
@property (nonatomic, copy) NSString *name;

/**
 *  0：表示布防 
 *  1：表示撤防，默认
 */
@property (nonatomic, assign) int  isArm;

/**
 *  0：表示联动条件表的相关条件是&&的关系，要全部真才有效
 *  1：表示联动条件表相关条件是||的关系，一个真就有效
 */
@property (nonatomic, assign) int type;

/**
 *  0：在家安防。布防的时候延时时间为0.
 *  1：外出安防。布防的时候delayTime为60.
 *  2：其他。布防的时候延时时间为0.
 */
@property (nonatomic, assign) int secType;

/**
 *  1:安防状态为报警状态，0:安防状态为正常状态
 */
@property (nonatomic, assign) int isOccurred;


+ (NSArray *)allSecurityArray;
+ (NSString*)getSecurityWithSecType:(int)secType;

@end
