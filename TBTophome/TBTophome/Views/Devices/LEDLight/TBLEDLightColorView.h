//
//  TBLEDLightColorView.h
//  TBTophome
//
//  Created by Topband on 2017/1/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TBLEDLightColorMode) {
    LEDEntertainmentMode,
    LEDLightingMode,
};

NS_ASSUME_NONNULL_BEGIN
@protocol TBLEDLightColorViewDelegate;
@interface TBLEDLightColorView : UIView

@property (weak, nonatomic) id<TBLEDLightColorViewDelegate> delegate;
@property (nonatomic, assign) TBLEDLightColorMode mode;
@property (nonatomic, strong, readonly) UIColor *currentColor;

@end

@protocol TBLEDLightColorViewDelegate <NSObject>

- (void)ledLightColorView:(TBLEDLightColorView *)view didChangeColor:(UIColor *)color;

@end
NS_ASSUME_NONNULL_END
