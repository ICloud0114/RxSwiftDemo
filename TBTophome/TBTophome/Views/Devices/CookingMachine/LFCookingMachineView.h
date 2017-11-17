//
//  LFCookingMachineView.h
//  CookingMachine
//
//  Created by Topband on 16/8/31.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBIconImageView.h"

@protocol LFCookingMachineViewDelegate;
NS_ASSUME_NONNULL_BEGIN
@interface LFCookingMachineView : UIView
@property (weak, nonatomic) id<LFCookingMachineViewDelegate> delegate;
@property (assign, nonatomic) NSInteger circleSegmentIndex; //档位下标
@property (assign, nonatomic) NSInteger temperatureIndex; //温度下标

@property (strong, nonatomic) IBOutletCollection(UIControl) NSArray<UIControl *> *funcs;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *lines;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *funcThumbs;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray<UIView *> *contentViews;

@property (weak, nonatomic) IBOutlet UILabel *gearLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *controlPanelView;

//点动
@property (weak, nonatomic) IBOutlet UIButton *rollMaxBts;
@property (weak, nonatomic) IBOutlet TBIconImageView *rollMaxIcon;
@property (weak, nonatomic) IBOutlet UIView *rollMaxBgView;
@property (weak, nonatomic) IBOutlet UILabel *rollMaxLabel;

//反转
@property (weak, nonatomic) IBOutlet UIImageView *reverseState;
@property (weak, nonatomic) IBOutlet UIButton *reverseBts;
@property (weak, nonatomic) IBOutlet TBIconImageView *reverseIcon;
@property (weak, nonatomic) IBOutlet UIView *reverseBgView;
@property (weak, nonatomic) IBOutlet UILabel *reverseLabel;

//称重
@property (weak, nonatomic) IBOutlet UIImageView *weightState;
@property (weak, nonatomic) IBOutlet UILabel *weightValue;
@property (weak, nonatomic) IBOutlet UIButton *weightBts;
@property (weak, nonatomic) IBOutlet TBIconImageView *weightIcon;
@property (weak, nonatomic) IBOutlet UIView *weightBgView;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

//开始/暂停
@property (weak, nonatomic) IBOutlet UIButton *playPauseBts;
@property (weak, nonatomic) IBOutlet TBIconImageView *playPauseIcon;
@property (weak, nonatomic) IBOutlet UIView *playPauseBgView;
@property (weak, nonatomic) IBOutlet UILabel *playPauseLabel;

//停止
@property (weak, nonatomic) IBOutlet UIButton *stopBts;
@property (weak, nonatomic) IBOutlet TBIconImageView *stopIcon;
@property (weak, nonatomic) IBOutlet UIView *stopBgView;
@property (weak, nonatomic) IBOutlet UILabel *stopLabel;
@end

@protocol LFCookingMachineViewDelegate <NSObject>

- (void)didMoveGearIndex:(NSInteger)index;

- (void)didMoveTemperatureGearIndex:(NSInteger)index;

@end
NS_ASSUME_NONNULL_END
