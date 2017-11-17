//
//  LFPopoverView.m
//  TopHome
//
//  Created by 胡小宝 on 14-11-28.
//  Copyright (c) 2014年 Topband. All rights reserved.
//

#import "LFPopoverView.h"

static const CGFloat Edge = 5.f;

@interface LFPopoverView ()<CAAnimationDelegate>
{
    BOOL isHide;
}

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, strong) UIControl *blackOverlay;

@property (nonatomic, assign) CGRect contentViewFrame;

@property (nonatomic, assign) CGPoint arrowPoint;

@end

@implementation LFPopoverView

+ (instancetype)popoverView
{
    return [LFPopoverView new];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _arrowSize = CGSizeMake(10, 10);
        _contentBackgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    
    CGRect frame = self.contentViewFrame;
    if (self.arrowPoint.x <= (frame.size.width/2.f + Edge))
    {
        frame = (CGRect){.origin = CGPointMake(10, self.arrowPoint.y), .size = frame.size};
    } else if (self.arrowPoint.x >= (self.containerView.bounds.size.width - Edge - frame.size.width/2.f))
    {
        frame = (CGRect){.origin = CGPointMake(self.containerView.bounds.size.width - Edge - frame.size.width, self.arrowPoint.y),
            .size = frame.size};
    } else
    {
        frame = (CGRect){.origin = CGPointMake(self.arrowPoint.x - frame.size.width/2.f, self.arrowPoint.y), .size = frame.size};
    }
    
    self.frame = frame;
    
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowPoint toView:self];
    CGPoint anchorPoint = CGPointMake(arrowPoint.x/CGRectGetWidth(frame), 0);//锚点
    self.layer.anchorPoint = anchorPoint;
    self.layer.position = CGPointMake(arrowPoint.x + frame.origin.x, frame.origin.y);
    
    frame.size.height += self.arrowSize.height;
    self.frame = frame;
    
    //self.arrowPoint = [self.containerView convertPoint:self.arrowPoint toView:self];
}

#pragma mark - content view animation

- (CABasicAnimation *)contentViewShowAnimation
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.duration = .3f;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    return basicAnimation;
}

- (CABasicAnimation *)contentViewHideAnimation
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.duration = .3f;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    return basicAnimation;
}

#pragma mark ----------------------------------------
#pragma mark - black overlay animation

- (CABasicAnimation *)blackOverlayShowAnimation
{
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    baseAnimation.duration = .3f;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.fromValue = (__bridge id)([UIColor clearColor].CGColor);
    baseAnimation.toValue = (__bridge id)([UIColor colorWithWhite:0 alpha:.5f].CGColor);
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    baseAnimation.delegate = self;
    return baseAnimation;
}

- (CABasicAnimation *)blackOverlayHideAnimation
{
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    baseAnimation.duration = .3f;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.fromValue = (__bridge id)([UIColor colorWithWhite:0 alpha:.5f].CGColor);
    baseAnimation.toValue = (__bridge id)([UIColor clearColor].CGColor);
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    baseAnimation.delegate = self;
    return baseAnimation;
}

#pragma mark ----------------------------------------

#pragma mark - animation delegate

- (void)animationDidStart:(CAAnimation *)anim
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    if (isHide)
    {
        [self removeFromSuperview];
        [self.blackOverlay removeFromSuperview];
        [self.contentView removeFromSuperview];
        self.containerView = nil;
        self.blackOverlay = nil;
        self.contentView = nil;
        
        if (self.dismissHandle)
        {
            self.dismissHandle();
        }
    }
}

- (void)show
{
    self.backgroundColor = [UIColor redColor];
    isHide = NO;
    
    [self setNeedsDisplay];
    
    CGRect contentViewFrame = self.contentViewFrame;
    contentViewFrame.origin.y = 0;
    contentViewFrame.origin.x = 0;
    contentViewFrame.origin.y += self.arrowSize.height;
    
    self.contentView.frame = contentViewFrame;
    [self addSubview:self.contentView];
    [self.containerView addSubview:self];
    
    [self.layer addAnimation:[self contentViewShowAnimation] forKey:@"contentViewShowAnimation"];
    [self.blackOverlay.layer addAnimation:[self blackOverlayShowAnimation] forKey:@"blackOverlayShowAnimation"];
}

- (void)hide
{
    isHide = YES;
    
    [self.layer addAnimation:[self contentViewHideAnimation] forKey:@"contentViewHideAnimation"];
    [self.blackOverlay.layer addAnimation:[self blackOverlayHideAnimation] forKey:@"blackOverlayHideAnimation"];
}

- (void)touchHide
{
    [self hide];
}

- (void)showPopoverViewAtPoint:(CGPoint)point withContentView :(UIView *)contentView inView:(UIView *)containerView
{
    if (!self.blackOverlay)
    {
        self.blackOverlay = [[UIControl alloc] init];
        self.blackOverlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.blackOverlay addTarget:self action:@selector(touchHide) forControlEvents:UIControlEventTouchUpInside];
    }
    self.blackOverlay.frame = containerView.bounds;
    self.blackOverlay.layer.backgroundColor = [UIColor yellowColor].CGColor;
    [containerView addSubview:self.blackOverlay];
    
    self.containerView = containerView;
    self.contentView = contentView;
    self.contentViewFrame = [containerView convertRect:contentView.frame toView:containerView];
    self.arrowPoint = point;
    
    [self show];
}

- (void)dismiss
{
    [self hide];
}

- (void)layoutSubviews
{
    [self setup];
}

- (void)drawRect:(CGRect)rect
{
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowPoint toView:self];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineWidth = .5f;
    [_contentBackgroundColor setFill];
    
    [bezierPath moveToPoint:CGPointMake(4, self.arrowSize.height)];
    [bezierPath addLineToPoint:CGPointMake(arrowPoint.x - self.arrowSize.width/2.f, self.arrowSize.height)];
    [bezierPath addLineToPoint:CGPointMake(arrowPoint.x, 0)];
    [bezierPath addLineToPoint:CGPointMake(arrowPoint.x + self.arrowSize.width/2.f, self.arrowSize.height)];
    if (self.roundCorner) { //圆角
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - 4, self.arrowSize.height)];
        [bezierPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.bounds), self.arrowSize.height + 4)
                           controlPoint:CGPointMake(CGRectGetWidth(self.bounds), self.arrowSize.height)];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 4)];
        [bezierPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.bounds) - 4, CGRectGetHeight(self.bounds))
                           controlPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        [bezierPath addLineToPoint:CGPointMake(4, CGRectGetHeight(self.bounds))];
        [bezierPath addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds) - 4)
                           controlPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
        [bezierPath addLineToPoint:CGPointMake(0, self.arrowSize.height + 4)];
        [bezierPath addQuadCurveToPoint:CGPointMake(4, self.arrowSize.height)
                           controlPoint:CGPointMake(0, self.arrowSize.height)];
    } else {
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), self.arrowSize.height)];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        [bezierPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    }
    
//    [bezierPath moveToPoint:CGPointMake(0, self.arrowSize.height)];
//    [bezierPath addLineToPoint:CGPointMake(arrowPoint.x - self.arrowSize.width/2.f, self.arrowSize.height)];
//    [bezierPath addLineToPoint:CGPointMake(arrowPoint.x, 0)];
//    [bezierPath addLineToPoint:CGPointMake(arrowPoint.x + self.arrowSize.width/2.f, self.arrowSize.height)];
//    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), self.arrowSize.height)];
//    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
//    [bezierPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    
    [bezierPath closePath];
    [bezierPath fill];
}

@end
