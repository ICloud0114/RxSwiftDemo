//
//  TBNickNameViewController.h
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBNickNameViewController : TBBaseViewController

+ (instancetype)instanceViewControllerWithNickName:(NSString *)nickname;

@property (nonatomic, copy) NSString *curNickname;

@end
NS_ASSUME_NONNULL_END
