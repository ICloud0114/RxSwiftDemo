//
//  UIImage+color.h
//  BluetoothLamp
//
//  Created by Lemon on 15-4-9.
//  Copyright (c) 2015年 拓邦软件中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)

- (UIColor *)colorWithPoint:(CGPoint)point;

- (UIImage *)scaleToSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color InRect:(CGRect)rect;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageFromView:(UIView *)view;
@end
