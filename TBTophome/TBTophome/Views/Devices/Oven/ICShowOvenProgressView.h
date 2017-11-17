//
//  ICShowOvenProgressView.h
//  Humidifier
//
//  Created by zhengyun on 16/9/9.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICShowOvenProgressView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *circleImageView;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

- (void)startLoading;
- (void)endLoading;
@end
