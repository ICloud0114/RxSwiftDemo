//
//  ICHumidifyView.m
//  Humidifier
//
//  Created by zhengyun on 16/8/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBHumidifierHygrometerView.h"

@interface TBHumidifierHygrometerView()
@property (nonatomic, weak) IBOutlet UILabel *countLabel;

@end
@implementation TBHumidifierHygrometerView

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
    self.backgroundColor = [UIColor clearColor];
    
    _waveView.layer.cornerRadius = CGRectGetHeight(_waveView.frame)/2;
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)startWaveProgress:(NSInteger )progress
{
    [self layoutIfNeeded];
    self.countLabel.text = [NSString stringWithFormat:@"%ld",progress];
    _waveView.percent =(1 - progress * 1.0f / 100.f);
    
}

- (void)stopWaving
{
    [_waveView stopWave];
}
- (void)continueWaving
{
    [_waveView startWave];
}
@end
