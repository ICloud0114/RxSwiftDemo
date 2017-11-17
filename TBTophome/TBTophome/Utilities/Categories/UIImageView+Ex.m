//
//  UIImageView+Ex.m
//  TBTophome
//
//  Created by Topband on 2017/1/4.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "UIImageView+Ex.h"

@implementation UIImageView (Ex)

- (void)transitionImage:(UIImage *)image {
    [UIView transitionWithView:self duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseIn animations:^{
        self.image = image;
        [self setNeedsLayout];
    } completion:nil];
}

@end
