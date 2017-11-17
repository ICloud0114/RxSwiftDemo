//
//  TBLEDLightColorView.m
//  TBTophome
//
//  Created by Topband on 2017/1/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBLEDLightColorView.h"
#import "UIImage+color.h"
#import "UIView+Ex.h"

@interface TBLEDLightColorView ()

@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UIImageView *colorView;
@property (weak, nonatomic) IBOutlet UIView *colorIndicator;

@property (nonatomic, strong) UIImage *colorImage;
@end

@implementation TBLEDLightColorView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self addGestureRecognizer:pan];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tap];
    
    self.colorIndicator.layer.borderWidth = 1.5;
    self.colorIndicator.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.colorIndicator.layer.cornerRadius = CGRectGetWidth(self.colorIndicator.bounds) / 2.f;
    [self adjustCursorWithLocalPoint:self.thumb.center state:UIGestureRecognizerStatePossible];
}

- (void)adjustColorAtPoint:(CGPoint)point {
    UIColor *color = [self.colorImage colorWithPoint:point];
    self.colorIndicator.backgroundColor = color;
}

- (void)adjustCursor:(CGPoint)center angle:(double)angle
{
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationDuration:0.25f];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:@"easeInEaseOut"]];
    
    self.thumb.center = center;
    self.thumb.transform = CGAffineTransformMakeRotation(Radians(450.f) - angle);
    // self.paletteImageView.transform = CGAffineTransformMakeRotation(radians(450.f) - angle);
    [CATransaction commit];
    
}

- (double)angleCenterWithLocalPoint:(CGPoint)localPoint
{
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CGFloat dx = ABS(centerPoint.x - localPoint.x);
    CGFloat dy = ABS(centerPoint.y - localPoint.y);
    
    double angle = atan(dy / dx);
    if (isnan(angle))
        angle = 0.0;
    
    if (localPoint.x < centerPoint.x)
        angle = M_PI - angle;
    
    if (localPoint.y > centerPoint.y)
        angle = 2.0 * M_PI - angle;
    
    return angle;
}

- (void)adjustCursorWithLocalPoint:(CGPoint)localPoint state:(UIGestureRecognizerState)state
{
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat localRadius = CGRectGetWidth(self.colorView.bounds) / 2.f + CGRectGetHeight(self.thumb.bounds) / 2.f;
    CGFloat colorRadius = CGRectGetWidth(self.colorView.bounds) / 2.f - 5 ;
    
    double angle = [self angleCenterWithLocalPoint:localPoint];
    
    CGFloat x = centerPoint.x + cosf(angle) * localRadius;
    CGFloat y = centerPoint.y - sinf(angle) * localRadius;
    
    CGFloat colorX = centerPoint.x + cosf(angle) * colorRadius;
    CGFloat colorY = centerPoint.y - sinf(angle) * colorRadius;
    
    CGPoint colorPoint = [self convertPoint:CGPointMake(colorX, colorY) toView:self.colorView];
    [self adjustColorAtPoint:colorPoint];
    [self adjustCursor:CGPointMake(x, y) angle:angle];
    
    if (state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(ledLightColorView:didChangeColor:)]) {
            [self.delegate ledLightColorView:self didChangeColor:self.colorIndicator.backgroundColor];
        }
    }
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    CGPoint local = [gesture locationInView:self];
    [self adjustCursorWithLocalPoint:local state:gesture.state];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)gesture {
    CGPoint local = [gesture locationInView:self];
    [self adjustCursorWithLocalPoint:local state:gesture.state];
}

#pragma mark - getter setter 
- (UIColor *)currentColor {
    return self.colorIndicator.backgroundColor;
}

- (UIImage *)colorImage {
    if (!_colorImage) {
        _colorImage = [self.colorView snapshot];
    }
    return _colorImage;
}

- (void)setMode:(TBLEDLightColorMode)mode {
    if (_mode != mode) {
        _mode = mode;
        _colorImage = nil;
        self.colorView.highlighted = (_mode == LEDLightingMode);
        [self adjustCursorWithLocalPoint:self.thumb.center state:UIGestureRecognizerStateEnded];
    }
}
@end
