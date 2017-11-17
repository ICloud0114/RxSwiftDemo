//
//  TBWaterProgressView.h
//  TYWaveProgressDemo
//
//  Created by zhengyun on 16/6/2.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBWaterProgressView : UIView

@property (nonatomic, assign)   CGFloat percent;            // 百分比

@property (nonatomic, strong)   UIColor *firstWaveColor;    // 第一个波浪颜色
@property (nonatomic, strong)   UIColor *secondWaveColor;   // 第二个波浪颜色


- (void) startWave;
- (void) stopWave;
- (void) pauseWave;
- (void) reset;
- (void) waveFallDown;
@end
