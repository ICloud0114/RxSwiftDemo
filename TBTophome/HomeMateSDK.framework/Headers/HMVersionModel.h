//
//  VersionModel.h
//  HomeMate
//
//  Created by Air on 15/8/25.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMVersionModel : HMBaseModel

@property (nonatomic,strong) NSString *     dbVersion;

+ (BOOL)saveCurrentDbVersion;

+ (HMVersionModel *)oldVersion;


@end
