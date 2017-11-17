//
//  LFInductionCookingPowerControlPanelView.h
//  InductionCooking
//
//  Created by Topband on 16/9/22.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFInductionCookingPowerControlPanelViewDelegate;
@interface LFInductionCookingPowerControlPanelView : UIView

@property (weak, nonatomic) IBOutlet id<LFInductionCookingPowerControlPanelViewDelegate> delegate;

@property (nonatomic, assign) NSInteger power;

@property (nonatomic, assign) BOOL disenabled;
@end

@protocol LFInductionCookingPowerControlPanelViewDelegate <NSObject>

- (void)didChangeGear:(NSInteger)gear;

@end
