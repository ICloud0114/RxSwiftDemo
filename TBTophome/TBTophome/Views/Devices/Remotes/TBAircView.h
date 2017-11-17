//
//  TBAircView.h
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBRemoteView.h"

@interface TBAircView : UIView <TBRemoteView>

@property (weak, nonatomic) IBOutlet UIButton *modeBt; //模式
@property (weak, nonatomic) IBOutlet UIButton *powerBt; //电源
@property (weak, nonatomic) IBOutlet UIButton *speedBt; //风速
@property (weak, nonatomic) IBOutlet UIButton *refBt; //制冷
@property (weak, nonatomic) IBOutlet UIButton *swwBt; //扫风
@property (weak, nonatomic) IBOutlet UIButton *heaBt; //制热
@property (weak, nonatomic) IBOutlet UIButton *fiwBt; //固定风
@property (weak, nonatomic) IBOutlet UIButton *addTempBt; //温度加
@property (weak, nonatomic) IBOutlet UIButton *redTempBt; //温度减

@property (weak, nonatomic) IBOutlet UIImageView *powerState; //开关状态
@property (weak, nonatomic) IBOutlet UIImageView *modeState; //模式
@property (weak, nonatomic) IBOutlet UIImageView *speedState; //风量状态
@property (weak, nonatomic) IBOutlet UIImageView *swwState; //扫风状态
@property (weak, nonatomic) IBOutlet UIImageView *directState; //风向状态
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (weak, nonatomic) IBOutlet UIButton *left;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIButton *right;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIButton *ok;

@property (nonatomic, weak) id<TBRemoteToolBarView> toolBarDelegate;

@property (nonatomic, assign) BOOL power;
@end
