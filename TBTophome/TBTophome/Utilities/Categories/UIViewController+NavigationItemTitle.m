//
//  UIViewController+NavigationItemTitle.m
//  TBTophome
//
//  Created by Topband on 2016/12/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "UIViewController+NavigationItemTitle.h"

@implementation UIViewController (NavigationItemTitle)

- (void)setTitle:(NSString *)title {
    [self setTitle:title font:[UIFont boldSystemFontOfSize:17.f] color:[UIColor whiteColor]];
}

- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    UILabel *navigationItemTitleLabel = [[UILabel alloc] init];
    navigationItemTitleLabel.textAlignment = NSTextAlignmentCenter;
    navigationItemTitleLabel.text = title;
    navigationItemTitleLabel.font = font;
    navigationItemTitleLabel.textColor = color;
    navigationItemTitleLabel.backgroundColor = [UIColor clearColor];
    navigationItemTitleLabel.minimumScaleFactor = 0.5;
    navigationItemTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.navigationItem.titleView = navigationItemTitleLabel;
    [navigationItemTitleLabel sizeToFit];
}

@end
