//
//  ActivateLinkageServiceCmd.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/2/21.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ActivateLinkageServiceCmd : BaseCmd

@property (nonatomic, copy) NSString *linkageId;

@property (nonatomic, assign) int  isPause;

@end
