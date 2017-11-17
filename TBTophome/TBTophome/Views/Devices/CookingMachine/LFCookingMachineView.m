//
//  LFCookingMachineView.m
//  CookingMachine
//
//  Created by Topband on 16/8/31.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LFCookingMachineView.h"
#import "CDCircle.h"
#import "CDCircleThumb.h"
#import "CDCircleGestureRecognizer.h"
#import "UIColor+Ex.h"

@interface LFCookingMachineView () <CDCircleDataSource, CDCircleDelegate> {
    CDCircle *circle;
    CALayer *progerssLayer;
    BOOL layoutFinish; //布局是否完成
}
@property (nonatomic, strong) UIImageView *circlePointer;
@property (weak, nonatomic) IBOutlet UIImageView *progress;
@property (weak, nonatomic) IBOutlet UIImageView *temperaturePointer;
@end

@interface LFCookingMachineView (Funcs)
- (IBAction)funcChange:(UIControl *)sender;
@end

@implementation LFCookingMachineView

- (void)circleMoveToSegmentIndex:(NSInteger)index {
    if (!layoutFinish) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.circlePointer.transform = CGAffineTransformMakeRotation((M_PI * (index * 30) / 180.0));
    }];
    circle.currentSegmentIndex = index;
}

- (void)setTemperatureProgress:(CGFloat)progress animated:(BOOL)animated {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.01];
    [CATransaction setDisableActions:!animated];
    CATransform3D transform = progerssLayer.transform;
    transform.m22 = progress;
    progerssLayer.transform = transform;
    CGFloat p = progress;
    if (p == 1.0) { p = 0.95; }
    self.temperaturePointer.transform = CGAffineTransformMakeTranslation(0, -p * CGRectGetHeight(self.progress.bounds));
    [CATransaction commit];
}
    
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.funcs[0] sendActionsForControlEvents:UIControlEventTouchUpInside];
//    [self funcChange:self.funcs[0]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
//    if (self.progress.layer.mask == nil) {
//        
//    }
//    //设置
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = (CGRect){.origin = CGPointZero, .size = self.progress.frame.size};
//    
//    progerssLayer = [CALayer layer];
//    progerssLayer.frame =(CGRect){.origin = CGPointZero, .size = self.progress.frame.size};;
//    progerssLayer.backgroundColor = [UIColor redColor].CGColor;
//    [maskLayer addSublayer:progerssLayer];
//    self.progress.layer.mask = maskLayer;
//    progerssLayer.anchorPoint = CGPointMake(0.5, 1.0);
//    progerssLayer.frame = (CGRect){.origin = CGPointZero, .size = self.progress.frame.size};
//    progerssLayer.transform = CATransform3DMakeScale(1, 0, 1);
}

- (void)drawRect:(CGRect)rect {
    layoutFinish = YES;
    //设置
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = (CGRect){.origin = CGPointZero, .size = self.progress.frame.size};
    
    progerssLayer = [CALayer layer];
    progerssLayer.frame =(CGRect){.origin = CGPointZero, .size = self.progress.frame.size};;
    progerssLayer.backgroundColor = [UIColor redColor].CGColor;
    [maskLayer addSublayer:progerssLayer];
    self.progress.layer.mask = maskLayer;
    progerssLayer.anchorPoint = CGPointMake(0.5, 1.0);
    progerssLayer.frame = (CGRect){.origin = CGPointZero, .size = self.progress.frame.size};
    progerssLayer.transform = CATransform3DMakeScale(1, 0, 1);
    
    if (circle == nil) {
        UIView *contentView = self.contentViews[0];
        CGFloat width = 187.f / 245.f * CGRectGetHeight(contentView.bounds);
        CGFloat ringWidth = 40.f / 245.f * CGRectGetHeight(contentView.bounds);
        CGRect frame = CGRectMake((CGRectGetWidth(contentView.bounds) - width) / 2.f, (CGRectGetHeight(contentView.bounds) - width) / 2.f, width, width);
        circle = [[CDCircle alloc] initWithFrame:frame numberOfSegments:12 ringWidth:ringWidth];
        circle.dataSource = self;
        circle.delegate = self;
        circle.circleBorderColor = [UIColor colorWithHexString:@"#d2d2d2"];
        [contentView addSubview:circle];
        [contentView addSubview:self.circlePointer];
        CGFloat pointerWidth = 115.f / 245.f * CGRectGetHeight(contentView.bounds);
        CGRect pointerFrame = CGRectMake((CGRectGetWidth(contentView.bounds) - pointerWidth) / 2.f, (CGRectGetHeight(contentView.bounds) - pointerWidth) / 2.f, pointerWidth, pointerWidth);
        self.circlePointer.frame = pointerFrame;
    }
    
    [self circleMoveToSegmentIndex:self.circleSegmentIndex];
    [self setTemperatureProgress:(1.f / 8.f) * self.temperatureIndex animated:YES];
}

- (IBAction)temperatureSlider:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    CGFloat scale = translation.y / sender.view.bounds.size.height;
    static CGFloat orValue = 0;
    if (sender.state == UIGestureRecognizerStateBegan) {
        orValue = progerssLayer.transform.m22;
    } else if(sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        CGFloat progress = 0;
        if (translation.y < 0) { //上滑
            progress= orValue + ABS(scale);
        } else { //下滑
            progress = orValue - ABS(scale);
        }
//        if (progress < 0) { progress = 0; }
//        else if (progress > 1) { progress = 1; }
        
        CGFloat space = 1.f / 8.f;
        CGFloat spaceHalf = space / 2.f;
        NSInteger index;
        for (index = 0; index < 8; ++index) {
            if (progress < spaceHalf) {
                break;
            } else if ((progress >= spaceHalf + (space * (index - 1))) &&
                       progress < (space * index + spaceHalf)) {
                break;
            }
        }
        progress = index * space;
        [self setTemperatureProgress:progress animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(didMoveTemperatureGearIndex:)]) {
            [self.delegate didMoveTemperatureGearIndex:index];
        }
    }
}

#pragma mark - CDCircleDataSource
-(id) circle: (CDCircle *) circle iconForThumbAtRow: (NSInteger) row {
    if (row == 11) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"blender_speed_kneading"];
        imageView.highlightedImage = [UIImage imageNamed:@"blender_speed_kneading_select"];
        return imageView;
    } else {
        return [@(row) stringValue];
    }
}

#pragma mark - CDCircleDelegate
-(void) circle: (CDCircle *) circle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb {
    _circleSegmentIndex = segment;
    [UIView animateWithDuration:0.2 animations:^{
        self.circlePointer.transform = CGAffineTransformMakeRotation((M_PI * (segment * 30) / 180.0));
    }];
    if ([self.delegate respondsToSelector:@selector(didMoveGearIndex:)]) {
        [self.delegate didMoveGearIndex:segment];
    }
}

#pragma mark - getter setter
- (UIImageView *)circlePointer {
    if (_circlePointer == nil) {
        _circlePointer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blender_speed_point"]];
    }
    return _circlePointer;
}

- (void)setCircleSegmentIndex:(NSInteger)circleSegmentIndex {
    if (_circleSegmentIndex != circleSegmentIndex) {
        _circleSegmentIndex = circleSegmentIndex;
        [self circleMoveToSegmentIndex:_circleSegmentIndex];
    }
}

- (void)setTemperatureIndex:(NSInteger)temperatureIndex {
    if (_temperatureIndex != temperatureIndex) {
        _temperatureIndex = temperatureIndex;
        if (layoutFinish) {
            [self setTemperatureProgress:(1.f / 8.f) * _temperatureIndex animated:YES];
        }
    }
}
@end
@implementation LFCookingMachineView (Funcs)

- (IBAction)funcChange:(UIControl *)sender {
    if (sender.selected) { return; }
    for (NSInteger index = 0; index < self.funcs.count; index++) {
        UIControl *ctl = self.funcs[index];
        UIImageView *line = self.lines[index];
        UIImageView *btThumbs = self.funcThumbs[index];
        UIView *contentView = self.contentViews[index];
        
        contentView.hidden = ctl != sender;
        btThumbs.highlighted = ctl == sender;
        ctl.selected = ctl == sender;
        ctl.backgroundColor = ctl.selected ? [UIColor clearColor] : [UIColor colorWithRed:245.f / 255.f green:245.f / 255.f blue:245.f / 255.f alpha:1.f];
        line.hidden = ctl == sender;
    }
}

@end
