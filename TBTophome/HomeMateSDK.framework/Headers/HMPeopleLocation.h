//
//  VihomePeopleLocation.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMPeopleLocation : HMBaseModel

@property (nonatomic, retain)NSString *                locationId;

@property (nonatomic, retain)NSString *                roomId;

@property (nonatomic, assign)int                peopleNum;

@property (nonatomic, assign)int                status;

@end
