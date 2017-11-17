//
//  UIView+Hud.m
//  Template
//
//  Created by Topband on 2016/12/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "UIView+Hud.h"

@implementation UIView (Hud)

- (void)showMessage:(NSString *)msg {
    [self showMessage:msg hideDelay:1.5];
}

- (void)showMessage:(NSString *)msg hideDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:true];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    hud.label.lineBreakMode = NSLineBreakByWordWrapping;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (MBProgressHUD *)showHudWithLabel:(NSString *)label inView:(UIView *)view {
    return [self showHudWithLabel:label hudMode:MBProgressHUDModeIndeterminate inView:view];
}

+ (MBProgressHUD *)showHudWithLabel:(NSString *)label hudMode:(MBProgressHUDMode)mode inView:(UIView *)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = mode;
    hud.label.text = label;
    [hud showAnimated:YES];
    return hud;
}

+ (void)hideHudInView:(UIView *)view {
    [self hideHudInView:view afterDelay:0];
}

+ (void)hideHudInView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud != nil) {
        [hud hideAnimated:YES afterDelay:delay];
    }
}

@end
