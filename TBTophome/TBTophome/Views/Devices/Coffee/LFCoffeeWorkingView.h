//
//  LFCoffeeWorkingView.h
//  SmartHomeSystem
//
//  Created by Topband on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFCoffeeWorkingView : UIView

+ (instancetype)coffeeWorkingView;

@property (weak, nonatomic) IBOutlet UILabel *waterAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

- (void)workInView:(UIView *)view;

- (void)stop;
@end
