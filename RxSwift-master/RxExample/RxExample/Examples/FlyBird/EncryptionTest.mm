//
//  EncryptionTest.m
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/14.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

#import "EncryptionTest.h"
#import "encryption.h"

@implementation EncryptionTest

- (NSArray *)createPassword:(NSString *)time hours:(int)hour{
    pswd_input input;
    input.mHours = hour;
    input.mTime = [time UTF8String];
    input.mUserId = "00112233445566778899aabbccddeeff";
    input.mDeviceId = "aabbccddeeff";
    
    pswd_output output;
    lockEncryptFunc(&input, &output);
    if (output.effective) {
        int index = arc4random_uniform(10);
        NSMutableArray *password = [NSMutableArray arrayWithCapacity:output.len];
        for (int i = 0; i < output.len; ++ i) {
            int p = output.mPassword[index][i];
            [password addObject: [NSNumber numberWithInt:p]];
        }
        return password;
    }else{
        return nil;
    }
}
@end
