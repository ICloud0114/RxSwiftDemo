//
//  ICHumidifyView.h
//  Humidifier
//
//  Created by zhengyun on 16/8/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBWaterProgressView.h"
NS_ASSUME_NONNULL_BEGIN
@interface TBHumidifierHygrometerView : UIView

@property (nonatomic, weak) IBOutlet TBWaterProgressView *waveView;

- (void)startWaveProgress:(NSInteger )progress;

- (void)stopWaving;

- (void)continueWaving;
@end
NS_ASSUME_NONNULL_END
