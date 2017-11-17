//
//  ICWarmProgressView.m
//  TBTophome
//
//  Created by zhengyun on 2017/2/22.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "ICWarmProgressView.h"
#import "UIView+Ex.h"
@implementation ICWarmProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)startLoading{
    
    [self.loadingImageView startRepeatRotate];
}

- (void)endLoading{
    [self.loadingImageView endRepeatRotate];
}
@end
