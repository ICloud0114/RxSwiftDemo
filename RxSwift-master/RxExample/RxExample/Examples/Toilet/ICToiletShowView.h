//
//  ICToiletShowView.h
//  Humidifier
//
//  Created by zhengyun on 16/10/12.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface ICToiletShowView : UIView

@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *pressureLabel;
@property (nonatomic, weak) IBOutlet UILabel *positionLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *dryLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (void)showProgressView;

- (void)showProgress:(CGFloat)p;

- (void)showOperationView:(NSInteger)type;

@end
NS_ASSUME_NONNULL_END
