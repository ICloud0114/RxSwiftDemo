//
//  TBHeaterBrightnessView.m
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBHeaterBrightnessView.h"

#define node_count (8)

@interface TBHeaterBrightnessView ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@end

@implementation TBHeaterBrightnessView

- (void)setNodeIndex:(NSInteger)index animated:(BOOL)animated {
    NSInteger nodeIndex = index;
    if (nodeIndex > node_count) {
        nodeIndex = node_count;
    }
    CGFloat nodeWidth = CGRectGetWidth(self.track.bounds) / node_count;
    CGPoint center = self.thumb.center;
    center.x = nodeWidth * nodeIndex + CGRectGetMinX(self.track.frame);
    [self setThumbCenter:center animated:NO];
}

- (void)setThumbCenter:(CGPoint)center animated:(BOOL)animated {
    CGFloat progress = (center.x - CGRectGetMinX(self.track.frame)) / CGRectGetWidth(self.track.frame);
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.thumb.center = center;
    self.trackLayer.strokeEnd = progress;
    [CATransaction commit];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pan];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.track.frame) / 2.f)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.track.frame), CGRectGetHeight(self.track.frame) / 2.f)];
    self.trackLayer.path = bezierPath.CGPath;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.track.bounds;
    [maskLayer addSublayer:self.trackLayer];
    self.track.layer.mask = maskLayer;
}

- (void)tapGesture:(UITapGestureRecognizer *)sender {
    CGPoint local = [sender locationInView:self];
    CGPoint center = self.thumb.center;
    if (local.x < CGRectGetMinX(self.track.frame)) {
        center.x = CGRectGetMinX(self.track.frame);
    } else if (local.x > CGRectGetMaxX(self.track.frame)) {
        center.x = CGRectGetMaxX(self.track.frame);
    } else {
        center.x = local.x;
    }
    CGFloat nodeWidth = CGRectGetWidth(self.track.bounds) / node_count;
    CGFloat offsetX = center.x - CGRectGetMinX(self.track.frame);
    NSInteger nodeIndex = (NSInteger)(offsetX / nodeWidth);
    if ((NSInteger)offsetX % (NSInteger)nodeWidth > nodeWidth / 2.f) {
        nodeIndex += 1;
    }
//    CGPoint center = self.thumb.center;
    center.x = nodeWidth * nodeIndex + CGRectGetMinX(self.track.frame);
    [self setThumbCenter:center animated:NO];
    
    if ([self.delegate respondsToSelector:@selector(heaterBrightnessView:didMoveToNodeIndex:)]) {
        [self.delegate heaterBrightnessView:self didMoveToNodeIndex:nodeIndex];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    static BOOL isMove = NO;
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint local = [sender locationInView:self];
        isMove = CGRectContainsPoint(CGRectInset(self.thumb.frame, -10, -10), local);
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        if (isMove) {
            CGPoint local = [sender locationInView:self];
            CGPoint center = self.thumb.center;
            if (local.x < CGRectGetMinX(self.track.frame)) {
                center.x = CGRectGetMinX(self.track.frame);
            } else if (local.x > CGRectGetMaxX(self.track.frame)) {
                center.x = CGRectGetMaxX(self.track.frame);
            } else {
                center.x = local.x;
            }
            [self setThumbCenter:center animated:NO];
        }
    } else {
        isMove = NO;
        CGFloat nodeWidth = CGRectGetWidth(self.track.bounds) / node_count;
        CGFloat offsetX = self.thumb.center.x - CGRectGetMinX(self.track.frame);
        NSInteger nodeIndex = (NSInteger)(offsetX / nodeWidth);
        if ((NSInteger)offsetX % (NSInteger)nodeWidth > nodeWidth / 2.f) {
            nodeIndex += 1;
        }
        CGPoint center = self.thumb.center;
        center.x = nodeWidth * nodeIndex + CGRectGetMinX(self.track.frame);
        [self setThumbCenter:center animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(heaterBrightnessView:didMoveToNodeIndex:)]) {
            [self.delegate heaterBrightnessView:self didMoveToNodeIndex:nodeIndex];
        }
    }
}

#pragma mark - getter setter
- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.track.layer.bounds;
        _trackLayer.strokeColor = [UIColor redColor].CGColor;
        _trackLayer.lineWidth = CGRectGetHeight(self.track.bounds);
        _trackLayer.strokeEnd = 0.0;
    }
    return _trackLayer;
}

@end
