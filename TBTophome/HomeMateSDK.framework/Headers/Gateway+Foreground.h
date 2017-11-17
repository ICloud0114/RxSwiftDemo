//
//  Gateway+Foreground.h
//  Vihome
//
//  Created by Air on 15-1-27.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "Gateway.h"

@interface Gateway (Foreground)

- (void)searchMdnsResult:(NSNotification *)notif;

-(void)readTable:(NSString *)tableName uid:(NSString *)uid completion:(commonBlock)completion;

@end
