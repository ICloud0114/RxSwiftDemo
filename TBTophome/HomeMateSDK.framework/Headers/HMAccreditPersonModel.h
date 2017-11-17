//
//  HMAccreditPersonModel.h
//  HomeMate
//
//  Created by orvibo on 15/12/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMAccreditPersonModel : HMBaseModel

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *deviceId;
@property(nonatomic,copy)NSString *time;
/**
 *  最近授权过的成员
 *
 *  @param deviceID
 *
 *  @return
 */
+(NSMutableArray *)selectAllWith:(NSString *)deviceID;
@end
