//
//  TBWaterProgressView.m
//  TYWaveProgressDemo
//
//  Created by zhengyun on 16/6/2.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "TBWaterProgressView.h"

@interface TBWaterProgressView()

{
    CGFloat waveAmplitude;  // 波纹振幅
    CGFloat waveCycle;      // 波纹周期
    CGFloat waveSpeed;      // 波纹速度
    CGFloat waveGrowth;     // 波纹上升速度
    
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;           // 波浪x位移
    CGFloat currentWavePointY; // 当前波浪上市高度Y（高度从大到小 坐标系向下增长）
    
    float variable;     //可变参数 更加真实 模拟波纹
    BOOL increase;      // 增减变化
    BOOL isFirst;
}
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;

@property (nonatomic, strong) CAShapeLayer  *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer  *secondWaveLayer;

@property (nonatomic, strong) NSTimer *fallDownTimer;

@property (nonatomic, assign) CGFloat heightPercent;

@end
@implementation TBWaterProgressView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc{
    [self reset];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.masksToBounds  = YES;
    self.backgroundColor = [UIColor clearColor];
    [self startWave];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    waterWaveHeight = self.frame.size.height;
    waterWaveWidth  = self.frame.size.width;
    _firstWaveColor = [UIColor colorWithRed:1/255.0 green:164/255.0 blue:245/255.0 alpha:0.8];
    _secondWaveColor = [UIColor colorWithRed:1/255.0 green:164/255.0 blue:245/255.0 alpha:0.5];
    
    waveGrowth = 0.85;
    waveSpeed = 0.25/M_PI;
    if (waterWaveWidth > 0) {
        waveCycle =  1.29 * M_PI / waterWaveWidth;
    }
    [self resetProperty];
    
}

- (void)setFirstWaveColor:(UIColor *)firstWaveColor
{
    _firstWaveColor = firstWaveColor;
    _firstWaveLayer.fillColor = firstWaveColor.CGColor;
}

- (void)setSecondWaveColor:(UIColor *)secondWaveColor
{
    _secondWaveColor = secondWaveColor;
    _secondWaveLayer.fillColor = secondWaveColor.CGColor;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    if (!_heightPercent) {
        _heightPercent = _percent;
//        [self getCurrentWave:nil];
    }else{
        if (!isFirst) {
            isFirst = YES;
            _heightPercent = _percent;
            
            [self getCurrentWave:nil];
        }else{
           [self waveFallDown];
        }
    }
}

-(void)startWave{
    
    [self layoutIfNeeded];
    
    if (_firstWaveLayer == nil) {
        // 创建第一个波浪Layer
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    if (_secondWaveLayer == nil) {
        // 创建第二个波浪Layer
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    
    if (!_waveDisplaylink) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
        
        self.waveDisplaylink = link;
        [self.waveDisplaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    self.waveDisplaylink.paused = NO;
    
    
   
}
- (void) stopWave{

    self.waveDisplaylink.paused = YES;
}

- (void)reset
{
    [_waveDisplaylink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
    [_firstWaveLayer removeFromSuperlayer];
    _firstWaveLayer = nil;
    [_secondWaveLayer removeFromSuperlayer];
    _secondWaveLayer = nil;
    [_fallDownTimer invalidate];
    _fallDownTimer = nil;
}

#pragma mark -Function
- (void)resetProperty
{
    variable = 1.6;
    increase = NO;
    offsetX = 0;
    
}
-(void)animateWave
{
    if (increase) {
        variable += 0.001;
    }else{
        variable -= 0.001;
    }
    
    
    if (variable<=1) {
        increase = YES;
    }
    
    if (variable>=1.6) {
        increase = NO;
    }
    
    waveAmplitude = variable * 5;
}

-(void)getCurrentWave:(CADisplayLink *)displayLink{
    
    [self animateWave];
    currentWavePointY = waterWaveHeight * _heightPercent;
    // 波浪位移
    offsetX += waveSpeed;
    
    [self setCurrentFirstWaveLayerPath];
    
    [self setCurrentSecondWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = waveAmplitude * sin(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
     CGPathRelease(path);
}

-(void)setCurrentSecondWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = waveAmplitude * cos(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _secondWaveLayer.path = path;
    CGPathRelease(path);
}

- (void)waveFallDownAction
{
    
    if (_percent > _heightPercent) {
        _heightPercent += 0.01;
        if (_heightPercent >= _percent) {
             [self.fallDownTimer setFireDate:[NSDate distantFuture]];

        }
    }else if (_percent < _heightPercent){
        _heightPercent -= 0.01;
        if (_heightPercent <= _percent) {
            
            [self.fallDownTimer setFireDate:[NSDate distantFuture]];
            
        }
        
    }else{
        _heightPercent = _percent;
         [self.fallDownTimer setFireDate:[NSDate distantFuture]];

    }
    [self getCurrentWave:nil];

    
}
- (void) waveFallDown
{
    [self.fallDownTimer setFireDate:[NSDate date]];
}


- (NSTimer *)fallDownTimer
{
    if (!_fallDownTimer) {
        
        _fallDownTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(waveFallDownAction) userInfo:nil repeats:YES];
    }
    return _fallDownTimer;
}
@end
