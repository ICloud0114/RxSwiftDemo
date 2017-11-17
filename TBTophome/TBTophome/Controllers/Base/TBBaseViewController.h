//
//  TBBaseViewController.h
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBNavigationController.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBBaseViewController : UIViewController

@property (nullable, nonatomic, readonly, strong) TBNavigationController *tbNavigationController;


/**
 是否能够手势返回

 @return 默认返回YES
 */
- (BOOL)isInteractivePop;


/**
 返回标题

 @return 模式为空
 */
- (nullable NSString *)backTitle;

- (void)backAction;

@end
NS_ASSUME_NONNULL_END
