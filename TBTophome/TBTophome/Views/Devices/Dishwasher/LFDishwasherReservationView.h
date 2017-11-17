//
//  LFInductionCookingCountdownView.h
//  SmartHomeSystem
//
//  Created by Topband on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFDishwasherReservationViewDelegate;
@interface LFDishwasherReservationView : UIControl
+ (instancetype)dishwasherReservationView;

@property (weak, nonatomic) id<LFDishwasherReservationViewDelegate> delegate;

- (void)showInView:(UIView *)view;
@end

@protocol LFDishwasherReservationViewDelegate <NSObject>

- (void)didSelectedReservationTime:(NSUInteger)hour;

@end
