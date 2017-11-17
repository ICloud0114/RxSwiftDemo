//
//  UIView+Hud.h
//  Template
//
//  Created by Topband on 2016/12/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (Hud)

- (void)showMessage:(NSString *)msg;

- (void)showMessage:(NSString *)msg hideDelay:(NSTimeInterval)delay;

+ (MBProgressHUD *)showHudWithLabel:(NSString *)label inView:(UIView *)view;

+ (MBProgressHUD *)showHudWithLabel:(NSString *)label hudMode:(MBProgressHUDMode)mode inView:(UIView *)view;

+ (void)hideHudInView:(UIView *)view;
@end
NS_ASSUME_NONNULL_END
