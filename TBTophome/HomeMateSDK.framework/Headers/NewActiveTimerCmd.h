//
//  NewActiveTimerCmd.h
//  HomeMateSDK
//
//  Created by Feng on 2017/3/3.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface NewActiveTimerCmd : BaseCmd
@property (nonatomic, strong) NSString * timingId;
@property (nonatomic,assign) int isPause;
@end
