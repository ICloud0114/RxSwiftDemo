//
//  LFInductionCookingCountdownView.h
//  SmartHomeSystem
//
//  Created by Topband on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFInductionCookingCountdownViewDelegate;
@interface LFInductionCookingCountdownView : UIControl
+ (instancetype)inductionCookingCountdownView;

@property (weak, nonatomic) id<LFInductionCookingCountdownViewDelegate> delegate;

- (void)showInView:(UIView *)view;
@end

@protocol LFInductionCookingCountdownViewDelegate <NSObject>

- (void)didSelectedCountdownTime:(NSUInteger)min;

@end
