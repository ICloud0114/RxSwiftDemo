//
//  AddLinkageServiceCmd.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/2/9.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddLinkageServiceCmd : BaseCmd

@property (nonatomic, strong) NSString *familyId;

@property (nonatomic,strong)NSString *linkageName;

@property (nonatomic,strong)NSArray * linkageConditionList;
@property (nonatomic,strong)NSArray * linkageOutputList;

@end
