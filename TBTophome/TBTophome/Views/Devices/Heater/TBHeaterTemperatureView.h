//
//  TBHeaterTemperatureView.h
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TBHeaterTemperatureViewDelegate;
@interface TBHeaterTemperatureView : UIView

@property (nonatomic, weak) id<TBHeaterTemperatureViewDelegate> delegate;
@property (nonatomic, assign) CGFloat progress;

@end

@protocol TBHeaterTemperatureViewDelegate <NSObject>

- (void)heaterTemperatureView:(TBHeaterTemperatureView *)view didChangeValue:(CGFloat)progress;

@end
NS_ASSUME_NONNULL_END
