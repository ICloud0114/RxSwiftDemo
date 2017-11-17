//
//  HMDescConfig.h
//  HomeMate
//
//  Created by Air on 16/9/23.
//  Copyright © 2016年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMDescConfig : NSObject

// 内置数据版本号变化了
+(BOOL)isBuiltInDataVersionChanged;

+(NSArray *)localConfigSQL;

+(void)getDeviceInfoFromServer;

@end
