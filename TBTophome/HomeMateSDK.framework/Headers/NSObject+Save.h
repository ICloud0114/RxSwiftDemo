//
//  NSObject+Save.h
//  Vihome
//
//  Created by Air on 15/6/29.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Save)

-(id)objectWithKey:(NSString *)key;
-(void)saveObject:(id)obj withKey:(NSString *)key;
-(void)removeObjectWithKey:(NSString *)key;
@end
