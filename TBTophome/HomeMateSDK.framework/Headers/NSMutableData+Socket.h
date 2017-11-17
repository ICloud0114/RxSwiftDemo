//
//  NSMutableData+Socket.h
//  ABB
//
//  Created by orvibo on 14-3-10.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ONE_BYTE 1
#define TWO_BYTE 2
#define THREE_BYTE 3
#define FOUR_BYTE 4

@interface NSMutableData (Socket)

-(NSMutableData *)appendDataWithInt:(NSUInteger)data length:(NSUInteger)length;
-(NSMutableData *)appendDataWithIntReverse:(NSUInteger)data length:(NSUInteger)length;
-(NSMutableData *)appendDataWithString:(NSString *)string;
-(NSMutableData *)fillWithInt:(int)data length:(NSUInteger)length;
@end
