//
//  LFInductionCookingPowerControlPanelView.m
//  InductionCooking
//
//  Created by Topband on 16/9/22.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LFInductionCookingPowerControlPanelView.h"

static CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return rads * 180.f / M_PI;//radiansToDegrees(rads);
}

@interface LFInductionCookingPowerControlPanelView () {
    CGPoint _line1StartPoint;
    NSInteger _currentIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UIView *panel;

@property (weak, nonatomic) CAShapeLayer *progressLayer;
@property (weak, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation LFInductionCookingPowerControlPanelView

- (void)setDisenabled:(BOOL)disenabled {
    _disenabled = disenabled;
    self.tap.enabled = !disenabled;
}

- (void)setPower:(NSInteger)power {
    if (_power != power) {
        _power = power;
        return;
    }
    [self setPower:_power animated:YES];
}

- (void)setPower:(NSInteger)power animated:(BOOL)animated {
    CGFloat degrees = power * 30.f;
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.thumbImageView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180.f);
    self.progressLayer.strokeEnd = degrees / 270.f;
    [CATransaction commit];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    //    CGPoint local = [tap locationInView:self.panel];
    //    CGPoint originPoint = CGPointMake(CGRectGetWidth(self.panel.bounds) / 2.f, CGRectGetWidth(self.panel.bounds) / 2.f);
    //    CGFloat degess = angleBetweenLines(_line1StartPoint, originPoint, local, originPoint);
    //    NSInteger power = (NSInteger)degess / 30;
    //    if ((NSInteger)degess % 30 > 15) {
    //        power += 1;
    //    }
    //    if (power > 8) { power = 8; }
    //    [self setPower:power];
    CGPoint center = CGPointMake(CGRectGetWidth(self.progressImageView.bounds) / 2.f,
                                 CGRectGetWidth(self.progressImageView.bounds) / 2.f);
    CGFloat degress = 0;
    CGPoint local = [tap locationInView:self.panel];
    if (local.x >= center.x) {
        //右半圈
        if (local.y <= center.y) {
            //右上
            CGFloat A = local.x - center.x;
            CGFloat B = center.y - local.y;
            degress = Degrees(atanf(A / B));
            degress += 135.f;
        } else {
            //右下
            CGFloat A = local.y - center.y;
            CGFloat B = local.x - center.x;
            degress = Degrees(atanf(A / B)) + 225.f;
            if (degress > 270.f) {
                degress = 270.f;
            }
        }
    } else {
        //左半圈
        if (local.y <= center.y) {
            //左上
            CGFloat A = center.y - local.y;
            CGFloat B = center.x - local.x;
            degress = Degrees(atanf(A / B)) + 45.f;
        } else {
            //左下
            CGFloat A = center.x - local.x;
            CGFloat B = local.y - center.y;
            degress = Degrees(atanf(A / B));
            if (degress < 45) {
                degress = 0;
            } else {
                degress -= 45.f;
            }
        }
    }
    NSInteger power = (NSInteger)degress / 30;
    if (((NSInteger)degress % 30) >= 15) {
        power += 1;
    }
    if (power > 9) { power = 9; }
//    [self setPower:power];
    [self setPower:power animated:NO];
    if ([self.delegate respondsToSelector:@selector(didChangeGear:)]) {
        [self.delegate didChangeGear:power];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.panel addGestureRecognizer:tap];
    self.tap = tap;
    //    self.progressImageView.backgroundColor = [UIColor blueColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.progressLayer.mask == nil) {
        CALayer *maskLayer = [CALayer layer];
        maskLayer.frame = self.progressImageView.bounds;
        maskLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        CAShapeLayer *progerssLayer = [CAShapeLayer layer];
        progerssLayer.frame = self.progressImageView.bounds;
        progerssLayer.fillColor = [UIColor clearColor].CGColor;
        progerssLayer.strokeColor = [UIColor redColor].CGColor;
        progerssLayer.strokeEnd = 0;
        progerssLayer.lineWidth = 40;
        
        CGPoint center = CGPointMake(CGRectGetWidth(self.panel.bounds) / 2.f, CGRectGetWidth(self.panel.bounds) / 2.f);
        CGFloat radius = CGRectGetWidth(self.panel.bounds) / 2.f - 20;
        CGFloat sAngle = Radians(-230);//-230.f * M_PI / 180.f;
        CGFloat eAngle = Radians(45);//45.f * M_PI / 180.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:sAngle endAngle:eAngle clockwise:YES];
        progerssLayer.path = path.CGPath;
        [maskLayer addSublayer:progerssLayer];
        self.progressImageView.layer.mask = progerssLayer;
        self.progressLayer = progerssLayer;
        
        //计算开始线的角度
        CGPoint line1StartPoint = CGPointZero;
        line1StartPoint.x = radius - 10 * cos(Radians(45.f));
        line1StartPoint.y = radius + 10 * sin(Radians(45.f));
        _line1StartPoint = line1StartPoint;
    }
}

@end
