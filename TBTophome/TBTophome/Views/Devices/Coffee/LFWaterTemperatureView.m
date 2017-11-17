//
//  LFWaterTemperatureView.m
//  CoffeeMachine
//
//  Created by Topband on 16/9/23.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LFWaterTemperatureView.h"

@interface LFWaterTemperatureView () {
    CALayer *progerssLayer;
    BOOL _isLayoutFinished;
}

@property (weak, nonatomic) IBOutlet UIImageView *progress;
@property (weak, nonatomic) IBOutlet UIImageView *temperaturePointer;
@end

@implementation LFWaterTemperatureView
@synthesize gear = _gear;

- (void)setTemperatureProgress:(CGFloat)progress animated:(BOOL)animated {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.2];
    [CATransaction setDisableActions:!animated];
    CATransform3D transform = progerssLayer.transform;
    transform.m22 = progress;
    progerssLayer.transform = transform;
    CGFloat p = progress;
    if (p == 1.0) { p = 0.95; }
    self.temperaturePointer.transform = CGAffineTransformMakeTranslation(0, -p * CGRectGetHeight(self.progress.bounds));
    [CATransaction commit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.progress.bounds;
    
    progerssLayer = [CALayer layer];
    progerssLayer.frame = self.progress.bounds;
    progerssLayer.backgroundColor = [UIColor redColor].CGColor;
    [maskLayer addSublayer:progerssLayer];
    self.progress.layer.mask = maskLayer;
    progerssLayer.anchorPoint = CGPointMake(0.5, 1.0);
    progerssLayer.frame = self.progress.bounds;
    progerssLayer.transform = CATransform3DMakeScale(1, 0, 1);
    
    _isLayoutFinished = YES;
}

- (IBAction)temperatureSlider:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    CGFloat scale = translation.y / sender.view.bounds.size.height;
    static CGFloat orValue = 0;
    if (sender.state == UIGestureRecognizerStateBegan) {
        orValue = progerssLayer.transform.m22;
    } else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        CGFloat progress = 0;
        if (translation.y < 0) { //上滑
            progress= orValue + ABS(scale);
        } else { //下滑
            progress = orValue - ABS(scale);
        }
        
        NSInteger g = 0;
        if (progress < 0.25) {
            progress = 0;
            g = 3;
        } else if (progress >=0.25 && progress < 0.75) {
            progress = 0.465;
            g = 2;
        } else {
            progress = 1;
            g = 1;
        }
        [self setTemperatureProgress:progress animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(didChangeTemperatureGear:)]) {
            [self.delegate didChangeTemperatureGear:g];
        }
    }
}

- (NSInteger)gear {
    CGFloat progress = progerssLayer.transform.m22;
    NSInteger g = 0;
    if (progress < 0.25) {
        progress = 0;
        g = 3;
    } else if (progress >=0.25 && progress < 0.75) {
        progress = 0.465;
        g = 2;
    } else {
        progress = 1;
        g = 1;
    }
    return g;
}

- (void)setGear:(NSInteger)gear {
    _gear = gear;
    CGFloat progress = 0;
    if (_gear == 1) {
        progress = 1;
    } else if (_gear == 2) {
        progress = 0.465;
    } else {
        progress = 0;
    }
    if (_isLayoutFinished) {
        [self setTemperatureProgress:progress animated:NO];
    }
}
@end
