//
//  UIView+Ex.m
//  BluetoothLamp
//
//  Created by Lemon on 15-4-9.
//  Copyright (c) 2015年 拓邦软件中心. All rights reserved.
//

#import "UIView+Ex.h"

@implementation UIView (Ex)

- (UIImage *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)snapshot:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef clipImage = CGImageCreateWithImageInRect(theImage.CGImage, rect);
    theImage = [UIImage imageWithCGImage:clipImage];
    CGImageRelease(clipImage);
    return theImage;
}

@end

@implementation UIView (Animation)

- (BOOL)startRepeatRotate:(CGFloat)timeInterval
{
    if ([self.layer animationForKey:@"startRepeatRotateAnimation"] == nil)
    {
        CABasicAnimation *animation = [self repeatRotateAnimation:timeInterval];
        [self.layer addAnimation:animation forKey:@"startRepeatRotateAnimation"];
        return YES;
    }
    return NO;
}

- (BOOL)startRepeatRotate
{
    return [self startRepeatRotate:1.f];
}

- (BOOL)endRepeatRotate
{
    if ([self.layer animationForKey:@"startRepeatRotateAnimation"])
    {
        [self.layer removeAnimationForKey:@"startRepeatRotateAnimation"];
    }
    
    if ([self.layer animationForKey:@"endRepeatRotateAnimation"] == nil)
    {
        CABasicAnimation *animation = [self stopRepeatRotateAnimation];
        [self.layer addAnimation:animation forKey:@"endRepeatRotateAnimation"];
        return YES;
    }
    return NO;
}

- (CABasicAnimation*)repeatRotateAnimation:(CGFloat)timeInterval
{
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    rotateAni.duration = timeInterval;
    rotateAni.cumulative = YES;
    rotateAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAni.toValue = [NSNumber numberWithFloat:Radians(360)];
    rotateAni.repeatCount = INT_MAX;
    
    return rotateAni;
}

- (CABasicAnimation *)stopRepeatRotateAnimation
{
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    rotateAni.duration = 1.f;
    rotateAni.cumulative = YES;
    rotateAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAni.toValue = [NSNumber numberWithFloat:Radians(0)];
    rotateAni.repeatCount = 1;
    return rotateAni;
}

@end
