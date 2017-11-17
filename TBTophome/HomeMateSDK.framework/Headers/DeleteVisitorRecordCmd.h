//
//  DeleteVisitorRecordCmd.h
//  HomeMate
//
//  Created by orvibo on 15/12/28.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface DeleteVisitorRecordCmd : BaseCmd

@property (nonatomic,assign)int type;

@property (nonatomic,strong)NSString * deviceId;

@end
