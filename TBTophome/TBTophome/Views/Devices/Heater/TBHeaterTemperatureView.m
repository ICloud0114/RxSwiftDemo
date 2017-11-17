//
//  TBHeaterTemperatureView.m
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBHeaterTemperatureView.h"
#import "MTTCircularSlider.h"

@interface TBHeaterTemperatureView ()

@property (weak, nonatomic) IBOutlet MTTCircularSlider *slider;

@end

@implementation TBHeaterTemperatureView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.slider.sliderStyle = MTTCircularSliderStyleImage;
    self.slider.selectImage = [UIImage imageNamed:@"heater_slide"];
    self.slider.unselectImage = [UIImage imageNamed:@"heater_slide_bg"];
    self.slider.indicatorImage = [UIImage imageNamed:@"heater_slide_btn"];
    self.slider.minAngle = 135;
    self.slider.maxAngle = 45;
    self.slider.lineWidth = 30;
    self.slider.contextPadding = 0;
    
    [self.slider addTarget:self action:@selector(sliderEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)sliderEditingDidEnd:(MTTCircularSlider *)slider {
    TBLog(@"%f", slider.value)
    if ([self.delegate respondsToSelector:@selector(heaterTemperatureView:didChangeValue:)]) {
        [self.delegate heaterTemperatureView:self didChangeValue:slider.value];
    }
}

#pragma mark - getter setter
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.slider.value = _progress;
}
@end
