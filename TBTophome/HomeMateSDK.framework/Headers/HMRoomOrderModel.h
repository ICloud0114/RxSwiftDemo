//
//  HMRoomOrderModel.h
//  HomeMate
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMRoomOrderModel : HMBaseModel

@property (nonatomic, assign) NSInteger sequence;//房间排序
@property (nonatomic, copy) NSString *roomId;//房间ID
@property (nonatomic, copy) NSString *imgUrl;//图片URL

//+(NSInteger)readIndexByRoomId:(NSString *)roomId;
+(HMRoomOrderModel *)readObjectByRoomId:(NSString *)roomId AndIndex:(NSInteger )index;

+(NSString *)imgUrlWithRoomId:(NSString *)roomId;
@end
