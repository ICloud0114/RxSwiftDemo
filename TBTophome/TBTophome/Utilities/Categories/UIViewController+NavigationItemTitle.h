//
//  UIViewController+NavigationItemTitle.h
//  TBTophome
//
//  Created by Topband on 2016/12/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (NavigationItemTitle)
- (void)setTitle:(NSString *)title;
- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;
@end
NS_ASSUME_NONNULL_END
