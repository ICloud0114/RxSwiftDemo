//
//  ICRiceTimeProgresssView.m
//  SmartHomeSystem
//
//  Created by 张雷 on 16/9/27.
//  Copyright © 2016年 topband. All rights reserved.
//

#import "ICRiceTimeProgresssView.h"
#import "UIColor+Ex.h"
#import "UIView+Ex.h"


@interface ICRiceTimeProgresssView()
{
    NSArray *modeArr;
    
}
@property (nonatomic, weak) IBOutlet UILabel *modeLabel;

@property (nonatomic, weak) IBOutlet UIImageView *circleImageView;

@end

@implementation ICRiceTimeProgresssView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (void)awakeFromNib
{
    modeArr = @[@"少量煮",@"煲汤",@"蒸煮",@"蛋糕",@"柴火饭",@"煮粥",@"稀饭"];
}

- (void)setTimeUI
{
    if (self.cookMin) {
        NSInteger hour = self.cookMin / 60;
        NSInteger min = self.cookMin % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", hour, min];
    }else{
        self.timeLabel.text = @"--:--";
        
        
    }
    self.modeLabel.text = modeArr[self.cookMode -1];
    
}
- (void)startLoading{
    
    [self setTimeUI];
    [self.circleImageView startRepeatRotate];
}

- (void)endLoading{
    [self.circleImageView endRepeatRotate];
}

@end
