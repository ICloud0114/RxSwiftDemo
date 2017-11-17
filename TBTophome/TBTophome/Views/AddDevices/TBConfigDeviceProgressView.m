//
//  TBConfigDeviceProgressView.m
//  TBTophome
//
//  Created by Topband on 2017/1/9.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBConfigDeviceProgressView.h"
#import "UIView+Rect.h"

@interface TBConfigDeviceProgressView ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@end

@implementation TBConfigDeviceProgressView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.trackLayer.strokeEnd = progress;
    [CATransaction commit];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CAShapeLayer *selfLayer = (CAShapeLayer *)self.layer;
    selfLayer.lineWidth = 3;
    selfLayer.strokeColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    selfLayer.fillColor = [UIColor clearColor].CGColor;
    selfLayer.strokeEnd = 1;
    [self.layer addSublayer:self.trackLayer];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CAShapeLayer *selfLayer = (CAShapeLayer *)self.layer;
    selfLayer.bounds = self.bounds;
    self.trackLayer.frame = self.bounds;
    CGPoint center = CGPointMake(self.width / 2.f, self.height / 2.f);
    CGFloat radius = self.width / 2.f - 1.5;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:Radians(-90) endAngle:Radians(270) clockwise:YES];
    selfLayer.path = path.CGPath;
    self.trackLayer.path = path.CGPath;
}

- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.lineWidth = 3;
        _trackLayer.strokeColor = [UIColor whiteColor].CGColor;
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
        _trackLayer.strokeEnd = 0;
    }
    return _trackLayer;
}

@end
