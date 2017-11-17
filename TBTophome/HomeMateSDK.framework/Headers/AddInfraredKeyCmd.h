//
//  AddInfraredKeyCMD.h
//  Vihome
//
//  Created by Ned on 5/8/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddInfraredKeyCmd : BaseCmd

@property (nonatomic, copy) NSString * deviceId;

@property (nonatomic, copy) NSString * keyName;

/**
 *  0：普通的按键（现在还用不上，Allone2普通的按键直接发学习的接口就能够创建）
 *  1：绑定的按键
 */
@property (nonatomic, assign) int keyType;

/**
 *  设备表外键。
 *  当keyType为1的时候有效，此时rid和fid里面填写的也是绑定的device的值，其他的值都填空，需要用到这个红外码的时候需要重新去查。
 */
@property (nonatomic, copy) NSString *bindDeviceId;

@property (nonatomic, assign) int rid;

@property (nonatomic, assign) int fid;

@end
