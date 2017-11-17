//
//  LFCoffeeWorkingView.m
//  SmartHomeSystem
//
//  Created by Topband on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import "LFCoffeeWorkingView.h"
#import "UIView+Ex.h"

@interface LFCoffeeWorkingView ()

@property (weak, nonatomic) IBOutlet UIImageView *loading;

@end

@implementation LFCoffeeWorkingView

- (void)workInView:(UIView *)view {
    UIView *selfView = self;
    [view addSubview:selfView];
    selfView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[selfView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selfView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[selfView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selfView)]];
    [selfView layoutIfNeeded];
    [self.loading startRepeatRotate];
}

- (void)stop {
    [self.loading endRepeatRotate];
    [self removeFromSuperview];
}

+ (instancetype)coffeeWorkingView {
    UINib *nib = [UINib nibWithNibName:@"LFCoffeeWorkingView" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

@end
