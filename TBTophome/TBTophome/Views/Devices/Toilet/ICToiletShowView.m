//
//  ICToiletShowView.m
//  Humidifier
//
//  Created by zhengyun on 16/10/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICToiletShowView.h"
#import "UIColor+Ex.h"


@interface ICToiletShowView ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIImageView *connectOn;
@property (nonatomic, weak) IBOutlet UIImageView *temperatureIcon;
@property (nonatomic, weak) IBOutlet UIImageView *pressureIcon;
@property (nonatomic, weak) IBOutlet UIImageView *positionIcon;
@property (nonatomic, weak) IBOutlet UIImageView *timeIcon;
@property (nonatomic, weak) IBOutlet UIImageView *dryIcon;
@property (nonatomic, weak) IBOutlet UIImageView *loadingImageView;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ICToiletShowView


- (void)awakeFromNib
{
    [super awakeFromNib];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Function

- (void)showProgressView
{
    [self layoutIfNeeded];
    
    [self.layer addSublayer:self.backgroundLayer];
    
    [self.layer addSublayer:self.progressLayer];
}
- (void)removeProgressView{
    
    self.backgroundLayer.strokeEnd = 1;
    self.progressLayer.strokeEnd = 0;
    
    self.backgroundLayer.hidden = YES;
}

- (void)showCircleView{
    self.backgroundLayer.strokeEnd = 1;
    self.progressLayer.strokeEnd = 0;
    self.backgroundLayer.hidden = NO;
}

#pragma mark getter&&setter

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.backgroundColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor colorWithHexString:@"#61c23e"].CGColor;
        _progressLayer.strokeEnd = 0.0;
        _progressLayer.lineWidth = 3.5;
        CGPoint center = CGPointMake(CGRectGetMidX(self.loadingImageView.frame), CGRectGetMidY(self.loadingImageView.frame));
        CGFloat radius = CGRectGetWidth(self.loadingImageView.frame) / 2.f ;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:radius
                                                              startAngle:Radians(-90)
                                                                endAngle:Radians(270)
                                                               clockwise:YES];
        _progressLayer.path = bezierPath.CGPath;
    }
    return _progressLayer;
}

- (CAShapeLayer *)backgroundLayer
{
    if (!_backgroundLayer) {
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.lineWidth = 1.5;
        _backgroundLayer.strokeEnd = 0.0;
        _backgroundLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        _backgroundLayer.fillColor = [UIColor clearColor].CGColor;
        CGPoint center = CGPointMake(CGRectGetMidX(self.loadingImageView.frame), CGRectGetMidY(self.loadingImageView.frame));
        CGFloat radius = CGRectGetWidth(self.loadingImageView.frame) / 2.f;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:radius
                                                              startAngle:Radians(-90)
                                                                endAngle:Radians(270)
                                                               clockwise:YES];
        _backgroundLayer.path = bezierPath.CGPath;
    }
    return _backgroundLayer;
}

- (void)showOperationView:(NSInteger)type{
    if (!_backgroundLayer) {
        [self showProgressView];
    }
    switch (type) {
        case 0:
        {
            [self showDefaultView];
            [self removeProgressView];
        }
            break;
        case 1:
        {
            [self showNormalClean];
            [self removeProgressView];
            [self showCircleView];
        }
            break;
        case 2:
        {
            [self showFemaleClean];
            [self removeProgressView];
            [self showCircleView];
        }
            break;
        case 3:
        {
            [self showDry];
            [self removeProgressView];
            [self showCircleView];
        }
            break;
        case 4:
        {
            [self showChildClean];
            [self removeProgressView];
            [self showCircleView];
        }
            break;
        case 5:
        {
            [self showMaleAutoClean];
            [self removeProgressView];
            [self showCircleView];
        }
            break;
        case 6:
        {
            [self showFemaleAutoClean];
            [self removeProgressView];
            [self showCircleView];
        }
            break;
        case 7:
        {
//            [self showFlushing];
//            [self removeProgressView];
//            [self showCircleView];
        }
            break;
        default:
            break;
    }
}
- (void)showProgress:(CGFloat)p{
    self.progressLayer.strokeEnd = p;
}

- (void)showNormalClean{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;
    
    self.dryLabel.hidden = YES;
    self.dryIcon.hidden = YES;
    
    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"臀部洗净中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_1"];
    
    self.temperatureIcon.hidden = NO;
    self.temperatureIcon.image = [UIImage imageNamed:@"info_operate_temperature"];
    self.pressureIcon.hidden = NO;
    self.pressureIcon.image = [UIImage imageNamed:@"info_operate_pressure"];
    self.positionIcon.hidden = NO;
    self.timeIcon.hidden = NO;
    
    self.temperatureLabel.hidden = NO;
    self.pressureLabel.hidden = NO;
    self.positionLabel.hidden = NO;
    self.timeLabel.hidden = NO;
}

- (void)showFemaleClean{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;
    
    self.dryLabel.hidden = YES;
    self.dryIcon.hidden = YES;
    
    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"女性洗净中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_2"];
    
    self.temperatureIcon.hidden = NO;
    self.temperatureIcon.image = [UIImage imageNamed:@"info_operate_temperature"];
    self.pressureIcon.hidden = NO;
    self.pressureIcon.image = [UIImage imageNamed:@"info_operate_pressure"];
    self.positionIcon.hidden = NO;
    self.timeIcon.hidden = NO;
    
    self.temperatureLabel.hidden = NO;
    self.pressureLabel.hidden = NO;
    self.positionLabel.hidden = NO;
    self.timeLabel.hidden = NO;
}

- (void)showDry{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;

    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"烘干中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_3"];
    
    self.temperatureIcon.hidden = NO;
    self.temperatureIcon.image = [UIImage imageNamed:@"info_operate_wind"];
    self.pressureIcon.hidden = NO;
    self.pressureIcon.image = [UIImage imageNamed:@"info_operate_time"];
    
    self.positionIcon.hidden = YES;
    self.timeIcon.hidden = YES;
    self.dryLabel.hidden = YES;
    
    self.temperatureLabel.hidden = NO;
    self.pressureLabel.hidden = NO;
    self.pressureLabel.text = @"4 min";
    
    self.positionLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.dryIcon.hidden = YES;
}

- (void)showFlushing{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;
    
    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"冲水中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_4"];
    
    self.temperatureIcon.hidden = YES;
    self.pressureIcon.hidden = YES;
    self.positionIcon.hidden = YES;
    self.timeIcon.hidden = YES;
    self.dryIcon.hidden = YES;
    
    self.temperatureLabel.hidden = YES;
    self.pressureLabel.hidden = YES;
    self.positionLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.dryLabel.hidden = YES;
}

- (void)showChildClean{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;
    
    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"儿童专用中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_5"];
    
    self.temperatureIcon.hidden = NO;
    self.temperatureIcon.image = [UIImage imageNamed:@"info_operate_temperature"];
    self.pressureIcon.hidden = NO;
    self.pressureIcon.image = [UIImage imageNamed:@"info_operate_pressure"];
    self.positionIcon.hidden = NO;
    self.timeIcon.hidden = NO;
    self.dryIcon.hidden = NO;
    
    self.temperatureLabel.hidden = NO;
    self.pressureLabel.hidden = NO;
    self.positionLabel.hidden = NO;
    self.timeLabel.hidden = NO;
    self.dryLabel.hidden = NO;
}

- (void)showMaleAutoClean{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;
    
    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"男性全自动中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_6"];
    
    self.temperatureIcon.hidden = NO;
    self.temperatureIcon.image = [UIImage imageNamed:@"info_operate_buttock"];
    self.pressureIcon.hidden = NO;
    self.pressureIcon.image = [UIImage imageNamed:@"info_operate_dry"];
    
    self.positionIcon.hidden = YES;
    self.timeIcon.hidden = YES;
    self.dryIcon.hidden = YES;
    
    self.temperatureLabel.hidden = NO;
    self.pressureLabel.text = @"1 min";
    self.pressureLabel.hidden = NO;
    self.pressureLabel.text = @"4 min";
    
    self.positionLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.dryLabel.hidden = YES;
}

- (void)showFemaleAutoClean{
    self.logoImageView.hidden = YES;
    self.connectOn.hidden = YES;
    
    self.loadingImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"女性全自动中...";
    self.loadingImageView.image = [UIImage imageNamed:@"tolit_loading_7"];
    
    self.temperatureIcon.hidden = NO;
    self.temperatureIcon.image = [UIImage imageNamed:@"info_operate_woman"];
    self.pressureIcon.hidden = NO;
    self.pressureIcon.image = [UIImage imageNamed:@"info_operate_dry"];
    
    self.positionIcon.hidden = YES;
    self.timeIcon.hidden = YES;
    self.dryIcon.hidden = YES;
    
    self.temperatureLabel.hidden = NO;
    self.pressureLabel.text = @"1 min";
    self.pressureLabel.hidden = NO;
    self.pressureLabel.text = @"4 min";
    
    self.positionLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.dryLabel.hidden = YES;
}

- (void)showDefaultView{
    self.logoImageView.hidden = NO;
    self.connectOn.hidden = NO;
    
    self.loadingImageView.hidden = YES;
    self.titleLabel.hidden = YES;
    
    self.temperatureIcon.hidden = YES;
    self.pressureIcon.hidden = YES;
    self.positionIcon.hidden = YES;
    self.timeIcon.hidden = YES;
    self.dryIcon.hidden = YES;
    
    self.temperatureLabel.hidden = YES;
    self.pressureLabel.hidden = YES;
    self.positionLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.dryLabel.hidden = YES;
    
}

@end
