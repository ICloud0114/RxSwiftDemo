//
//  HMCustomPicture.h
//  HomeMate
//
//  Created by liqiang on 16/9/12.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMCustomPicture : HMBaseModel
@property (nonatomic, copy) NSString * imageInfoId;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * customId;
@property (nonatomic, copy) NSString * imageURL;

+ (HMCustomPicture *)objectFromDictionary:(NSDictionary *)dict;
@end
