//
//  AccountSingleton+Bind.h
//  HomeMateSDK
//
//  Created by Air on 16/11/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "AccountSingleton.h"

@interface AccountSingleton (Bind)

/**
 *  从服务器拿到最新的家庭信息和设备的绑定关系之后，更新本地数据库
 */
-(void)updateFamilyAndDeviceBind:(NSDictionary *)resultDic;

-(NSMutableArray *)zigbeeHostBindArray;

-(NSMutableArray *)allDeviceBindArray;

-(NSMutableArray *)wifiDeviceBindArray;

@end
