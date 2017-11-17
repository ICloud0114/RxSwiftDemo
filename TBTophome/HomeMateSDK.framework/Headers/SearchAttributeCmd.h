//
//  SearchAttributeCmd.h
//  HomeMate
//
//  Created by liuzhicai on 16/9/18.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface SearchAttributeCmd : BaseCmd

@property (nonatomic, strong)NSString * deviceId;

@property (nonatomic, assign)int attributeId;


@end
