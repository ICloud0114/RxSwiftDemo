//
//  SearchMdns+FindGateway.h
//  HomeMate
//
//  Created by Air on 16/6/30.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "SearchMdns.h"

@interface SearchMdns (FindGateway)

// 自动发现网关
-(void)autoFindGateway:(commonBlockWithObject)completion;

@end
