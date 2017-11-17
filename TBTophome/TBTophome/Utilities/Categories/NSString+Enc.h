//
//  NSString+Enc.h
//  TBTophome
//
//  Created by Topband on 2017/3/9.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Enc)

- (NSString *)sha1;

@end
