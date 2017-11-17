//
//  NSObject+Observer.h
//  Vihome
//
//  Created by Air on 15/7/21.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Observer)

- (void)hm_removeAllObserver;
- (void)hm_removeNotification:(NSString *)aName object:(id)anObject;
- (void)hm_addNotification:(NSString *)aName selector:(SEL)aSelector object:(id)anObject;
@end
