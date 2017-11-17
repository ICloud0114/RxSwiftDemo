//
//  LFWaterTemperatureView.h
//  CoffeeMachine
//
//  Created by Topband on 16/9/23.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFWaterTemperatureViewDelegate;
@interface LFWaterTemperatureView : UIView

@property (weak, nonatomic) IBOutlet id<LFWaterTemperatureViewDelegate> delegate;

@property (nonatomic, assign) NSInteger gear;
@end

@protocol LFWaterTemperatureViewDelegate <NSObject>

- (void)didChangeTemperatureGear:(NSInteger)tGear;

@end
