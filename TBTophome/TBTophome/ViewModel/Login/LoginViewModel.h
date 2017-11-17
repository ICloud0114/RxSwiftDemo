//
//  LoginViewModel.h
//  Template
//
//  Created by Topband on 2016/12/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"

/**
 登录回调handle

 @param NSError 如果为nil则登录成功, 否则报错
 */
typedef void(^LoginCompletionHandle)(NSError *);

@interface LoginViewModel : ViewModel


- (void)loginWithAccount:(NSString *)account password:(NSString *)password completion:(LoginCompletionHandle)handle;

@end
