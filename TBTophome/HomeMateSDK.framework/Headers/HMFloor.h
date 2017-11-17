//
//  VihomeFloor.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMFloor : HMBaseModel

@property (nonatomic, retain)NSString *         floorId;

@property (nonatomic, retain)NSString *         floorName;

@property (nonatomic, assign)BOOL         hidden;

@property (nonatomic, assign)NSInteger    index;//顺序

@property (nonatomic, assign)BOOL               beSelected;


+(void)saveFloorAndRoom:(NSDictionary *)dic;
+(NSMutableArray *)selectAllFloor;
+(HMFloor *)selectFloorByFloorId:(NSString *)floorId;

+(NSMutableArray *)selectAllFloorWithFamilyId:(NSString *)familyId;

@end
