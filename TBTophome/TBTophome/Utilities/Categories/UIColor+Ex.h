//
//  UIColor+Ex.h
//  BluetoothLamp
//
//  Created by Lemon on 15-4-17.
//  Copyright (c) 2015年 拓邦软件中心. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline UIColor * UIRGB(CGFloat r, CGFloat g, CGFloat b) {
    return [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f];
}

@interface UIColor (Ex)

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
