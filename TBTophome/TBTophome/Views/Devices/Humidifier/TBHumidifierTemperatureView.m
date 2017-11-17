//
//  ICTemperatureView.m.
//  Humidifier
//
//  Created by zhengyun on 16/8/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBHumidifierTemperatureView.h"

@interface TBHumidifierTemperatureView() {
    BOOL _isLayoutComplete;
    BOOL _isAction;
    CGFloat _cacheTemperature;
    BOOL _cacheAnimated;
}

@property (nonatomic, weak) IBOutlet UIImageView *temperatureBackground;
@property (nonatomic, weak) IBOutlet UIImageView *temperatureImageView;
@property (nonatomic, weak) IBOutlet UILabel * temperatureLabel;

@property (nonatomic, strong) CALayer *temperatureLayer;
@end
@implementation TBHumidifierTemperatureView

- (void)setTemperature:(CGFloat)temp animated:(BOOL)animated {
    if (!_isLayoutComplete) {
        _isAction = YES;
        _cacheTemperature = temp;
        _cacheAnimated = animated;
        return;
    }
    [self _setTemperature:temp animated:animated];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _isAction = NO;
    _isLayoutComplete = NO;
    self.layer.masksToBounds  = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _isLayoutComplete = YES;
    if (self.temperatureImageView.layer.mask == nil) {
        CALayer *maskLayer = [CALayer layer];
        maskLayer.frame = self.temperatureImageView.bounds;
        
        self.temperatureLayer = [CALayer layer];
        _temperatureLayer.backgroundColor = [UIColor redColor].CGColor;
        [maskLayer addSublayer:_temperatureLayer];
        self.temperatureImageView.layer.mask = maskLayer;
        
        self.temperatureLayer.frame = [self rectWithTemperature:-10];
        if (_isAction) {
            [self _setTemperature:_cacheTemperature animated:_cacheAnimated];
        }
    }
}

- (void)_setTemperature:(CGFloat)temp animated:(BOOL)animated {
    _isAction = NO;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%1.0f",temp];
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.temperatureLayer.frame = [self rectWithTemperature:temp];
    [CATransaction commit];
}

- (CGRect)rectWithTemperature:(CGFloat)temp {
    CGFloat ratio = (temp + 10) / 60.f; //温度控制在 －10 －－ 50度之间
    CGRect rect = self.temperatureImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = rect.size.height;
    rect.size.height = ratio * (rect.size.height - rect.size.width) + rect.size.width;
    rect.origin.y -= rect.size.height;
    return rect;
}
@end
