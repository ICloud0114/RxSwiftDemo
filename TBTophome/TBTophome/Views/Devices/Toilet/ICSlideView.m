//
//  ICSlideView.m
//  SmartHomeSystem
//
//  Created by zhengyun on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import "ICSlideView.h"
#import "UIColor+Ex.h"
#define CenterImage_W 16
#define SliderLine_W self.bounds.size.width

#define tip_width 30
#define tip_height 12
#define tip_bottom_margin 0
@interface ICSlideView ()

@property (nonatomic, weak) IBOutlet UIImageView *trackImageView;
@property (nonatomic, weak) IBOutlet UIButton *thumbBt;

@property (nonatomic, assign) CGFloat pointX;
@property (nonatomic, assign) CGFloat sectionLength;

@property (nonatomic, assign) NSInteger titleCount;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign, readonly) CGFloat progressTotalLength;


@end

@implementation ICSlideView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.trackImageView.frame) / 2.f)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.trackImageView.frame), CGRectGetHeight(self.trackImageView.frame) / 2.f)];
    self.progressLayer.path = bezierPath.CGPath;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.trackImageView.bounds;
    [maskLayer addSublayer:self.progressLayer];
    
    self.trackImageView.layer.mask = maskLayer;
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.progressLayer.lineWidth = CGRectGetHeight(self.trackImageView.frame);
    
    [self setSectionIndex:_sectionIndex animated:YES];
}

- (void)addSliderTitles:(NSArray *)titles
{
    _titleCount = titles.count;
    _sectionLength = self.trackImageView.frame.size.width / (_titleCount -1);
    
    for (NSInteger index = 0; index < _titleCount; ++ index) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor colorWithHexString:@"#828282"];
        label.text = titles[index];
        if (!index) {
            [label setFrame:CGRectMake(self.trackImageView.frame.origin.x, self.bounds.size.height - tip_height - tip_bottom_margin, tip_width, tip_height)];
            label.textAlignment = NSTextAlignmentLeft;
        }
        else if(index == _titleCount -1)
        {
            [label setFrame:CGRectMake(self.trackImageView.frame.origin.x + self.trackImageView.frame.size.width - tip_width, self.bounds.size.height - tip_height - tip_bottom_margin, tip_width, tip_height)];
            label.textAlignment = NSTextAlignmentRight;
            
        }
        else
        {
            [label setFrame:CGRectMake(index * _sectionLength - tip_width / 2, self.bounds.size.height - tip_height - tip_bottom_margin, tip_width, tip_height)];
            [label setCenter:CGPointMake(self.trackImageView.frame.origin.x + _sectionLength * index, label.center.y)];
            label.textAlignment = NSTextAlignmentCenter;
            
        }
        [self addSubview:label];
    }
}

#pragma mark --- Touch

//-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//    
//
//    [self moveSlideView:touch];
//    
//    return YES;
//}

//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//    
//    
//    [self moveSlideView:touch];
//    
//    return YES;
//}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [self checkPointX:touch];
    
    [self layoutIfNeeded];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}


#pragma mark -Function

- (void)setSectionIndex:(NSInteger)index animated:(BOOL)animated
{
    _sectionIndex = index;
    
    CGFloat p = (index * 1.f)/ (_titleCount -1);
    
    if (animated)
    {
        CGPoint thumbCenter = self.thumbBt.center;
        thumbCenter.x = self.trackImageView.frame.origin.x + _sectionLength * index;
        [CATransaction begin];
        [CATransaction setDisableActions:NO];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:.5f];
        _progressLayer.strokeEnd = p;
        self.thumbBt.center = thumbCenter;
        [CATransaction commit];
    } else
    {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:.25f];
        _progressLayer.strokeEnd = p;
        [CATransaction commit];
    }
    
}


- (void)moveSlideView:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    
    if (point.x < self.trackImageView.frame.origin.x) {
        point.x = self.trackImageView.frame.origin.x;
    }else if (point.x > self.trackImageView.frame.origin.x + self.trackImageView.frame.size.width){
        point.x = self.trackImageView.frame.origin.x + self.trackImageView.frame.size.width;
    }
    CGFloat p = (point.x - self.trackImageView.frame.origin.x)/ self.trackImageView.frame.size.width;
    
    CGPoint thumbCenter = self.thumbBt.center;
    
    thumbCenter.x = point.x;
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:.15f];
    _progressLayer.strokeEnd = p;
    self.thumbBt.center = thumbCenter;
    [CATransaction commit];
    
    
}
-(void)checkPointX:(UITouch *)touch{
    
    NSInteger oldIndex = _sectionIndex;
    CGPoint point = [touch locationInView:self];
    _pointX = point.x;
    if (point.x<0) {
        _pointX = self.trackImageView.frame.origin.x;
    }else if (point.x > self.trackImageView.frame.origin.x + self.trackImageView.frame.size.width){
        _pointX = self.trackImageView.frame.origin.x + self.trackImageView.frame.size.width;
    }
    //四舍五入计算选择的节点
    NSInteger index = (int)roundf((point.x - self.trackImageView.frame.origin.x)/_sectionLength);
//    NSLog(@"pointx=(%f),(%ld),(%f)",point.x,(long)_sectionIndex,_pointX);
    if (oldIndex != index) {
        if (self.changeIndex) {
            self.changeIndex(index);
        }
        
    }
    
    [self setSectionIndex:index animated:YES];
    
}

#pragma mark getter & setter

- (CGFloat)progressTotalLength
{
    return CGRectGetWidth(self.trackImageView.bounds) - CGRectGetWidth(self.thumbBt.bounds) / 4.f * 2.f;
}

- (CAShapeLayer *)progressLayer
{
    if (_progressLayer == nil)
    {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.speed = 5;
        _progressLayer.frame = self.trackImageView.layer.bounds;
        _progressLayer.strokeColor = [UIColor redColor].CGColor;
        _progressLayer.lineJoin = kCALineJoinRound;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeStart = 0.f;
        
    }
    return _progressLayer;
}


@end
