//
//  SearchMdns.h
//  Vihome
//
//  Created by Air on 15-1-27.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "SingletonClass.h"

@interface SearchMdns : SingletonClass <NSNetServiceBrowserDelegate,NSNetServiceDelegate>

-(void)searchGatewaysAndPostResult;

-(void)searchGatewaysWtihCompletion:(SearhMdnsBlock)completion;

-(void)didFindGateway:(NSNetService *)sender udpInfo:(NSDictionary *)udpInfo;

@end
