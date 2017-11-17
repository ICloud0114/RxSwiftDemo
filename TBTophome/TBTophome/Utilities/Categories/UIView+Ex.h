//
//  UIView+Ex.h
//  BluetoothLamp
//
//  Created by Lemon on 15-4-9.
//  Copyright (c) 2015年 拓邦软件中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ex)

- (UIImage *)snapshot;

- (UIImage *)snapshot:(CGRect)rect;

@end

@interface UIView (Animation)

- (BOOL)startRepeatRotate:(CGFloat)timeInterval;

- (BOOL)startRepeatRotate;

- (BOOL)endRepeatRotate;

@end
