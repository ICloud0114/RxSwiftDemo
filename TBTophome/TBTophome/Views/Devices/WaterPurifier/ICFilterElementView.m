//
//  ICFilterElementView.m
//  Humidifier
//
//  Created by zhengyun on 16/8/31.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICFilterElementView.h"

@interface ICFilterElementView()


@property (nonatomic, weak) IBOutlet UILabel *percentLabel;
@property (nonatomic, weak) IBOutlet UIImageView *bottleImageView;
@property (nonatomic, weak) IBOutlet UIImageView *filterBackground;
@property (nonatomic, weak) IBOutlet UIImageView *filterImageView;
@property (nonatomic, strong) CALayer *percentLayer;

//@property (nonatomic, assign) NSInteger filterPercent;

@end

@implementation ICFilterElementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.masksToBounds  = YES;
    self.backgroundColor = [UIColor clearColor];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.filterImageView.bounds;
    
    self.percentLayer = [CALayer layer];
    //    _temperatureLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.temperatureImageView.frame), 0);
    _percentLayer.backgroundColor = [UIColor redColor].CGColor;
    [maskLayer addSublayer:_percentLayer];
    
    self.filterImageView.layer.mask = maskLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)showFilterDamagePercent:(NSInteger )percent
{
    [self layoutIfNeeded];
//    _filterPercent = percent;
    self.percentLabel.text = [NSString stringWithFormat:@"%ld%%",percent];
    CGFloat ratio = 1 / 29.f;
    
    CGFloat progress = (percent *1.f) / 10.f *2;
    
    CGFloat space = (percent / 10)  * 1.f;
    
    CGRect rect = self.filterImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = rect.size.height ;
    rect.size.height = (progress + space)*ratio * rect.size.height;
    
    self.percentLayer.frame = rect;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CGRect aRect = self.percentLayer.frame;
        aRect.origin.y -= aRect.size.height;
        self.percentLayer.frame = aRect;
        
    }];
   
}
- (void)changeFilterImageState:(BOOL)isNormal
{
    if (isNormal) {
        self.filterBackground.image = [UIImage imageNamed:@"filter_slidebg_normal"];
        self.filterImageView.image = [UIImage imageNamed:@"filter_slide_normal"];
        self.bottleImageView.image = [UIImage imageNamed:@"filter_normal"];
    }
    else
    {
        self.filterBackground.image = [UIImage imageNamed:@"filter_slidebg_disable"];
        self.filterImageView.image = [UIImage imageNamed:@"filter_slide_disable"];
        self.bottleImageView.image = [UIImage imageNamed:@"filter_disable"];
    }
}


@end
