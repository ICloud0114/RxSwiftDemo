//
//  RegisterViewModel.h
//  Template
//
//  Created by Topband on 2016/12/14.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"

typedef void(^GetCodeCompletionHandle)(NSError *);
typedef void(^RegisterCompletionHandle)(NSError *);
@interface RegisterViewModel : ViewModel

- (void)getCodeWithPhone:(NSString *)phone
              completion:(GetCodeCompletionHandle)handle;

- (void)registerWithPhone:(NSString *)phone
                     code:(NSString *)code
                 password:(NSString *)password
               completion:(RegisterCompletionHandle)handle;
@end
