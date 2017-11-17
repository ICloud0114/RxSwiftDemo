//
//  NSData+AES.h
//  KeplerSDK
//
//  Created by Ned on 14-7-22.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

- (NSData *)hm_AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)hm_AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)hm_cipherData:(NSData *)data key:(NSString *)key;

- (NSData *)hm_decipherData:(NSData *)data key:(NSString *)key;

-(int)hm_protocolLength;

@end
