//
//  ICShowOvenProgressView.m
//  Humidifier
//
//  Created by zhengyun on 16/9/9.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICShowOvenProgressView.h"
#import "UIColor+Ex.h"
#import "UIView+Ex.h"

@interface ICShowOvenProgressView()
{
}



@end
@implementation ICShowOvenProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)startLoading{
    
    [self.circleImageView startRepeatRotate];
}

- (void)endLoading{
    [self.circleImageView endRepeatRotate];
}
@end
