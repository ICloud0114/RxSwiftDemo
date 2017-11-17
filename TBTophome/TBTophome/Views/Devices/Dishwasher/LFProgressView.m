//
//  LFProgressView.m
//  Dishwasher
//
//  Created by Topband on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LFProgressView.h"
#import "UIColor+Ex.h"

@interface LFProgressView ()

@property (nonatomic, weak) CAShapeLayer *progressLayer;

@end

@implementation LFProgressView

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.progressLayer.strokeEnd = progress;
    [CATransaction commit];
}

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CAShapeLayer *selfLayer = (CAShapeLayer *)self.layer;
    selfLayer.lineWidth = 3;
    selfLayer.strokeColor = [UIColor colorWithHexString:@"#e6e6e6"].CGColor;
    selfLayer.fillColor = [UIColor clearColor].CGColor;
    selfLayer.strokeEnd = 1;
    
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.lineWidth = 7;
    progressLayer.strokeColor = [UIColor colorWithHexString:@"#61c23e"].CGColor;
    progressLayer.fillColor = [UIColor clearColor].CGColor;
    progressLayer.strokeEnd = 0;
    [selfLayer addSublayer:progressLayer];
    self.progressLayer = progressLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CAShapeLayer *selfLayer = (CAShapeLayer *)self.layer;
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetWidth(self.bounds) / 2.f);
    CGFloat radius = CGRectGetWidth(self.bounds) / 2.f - 3.5;
    CGFloat sAngle = Radians(-90);
    CGFloat eAngle = Radians(970);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:sAngle endAngle:eAngle clockwise:YES];
    selfLayer.path = path.CGPath;
    
    self.progressLayer.frame = self.bounds;
    self.progressLayer.path = path.CGPath;
}
@end