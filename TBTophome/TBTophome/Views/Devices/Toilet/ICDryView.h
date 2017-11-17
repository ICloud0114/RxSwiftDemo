//
//  ICDryView.h
//  Humidifier
//
//  Created by zhengyun on 16/9/23.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface ICDryView : UIView

+ (ICDryView *)shareDryView;

@property (nonatomic, copy) void (^dismissComplete)();

@property (nonatomic, copy) void (^changeLevel)(NSInteger level);
- (void)showInView:(UIView *)view;

- (void)dismiss;

- (void)showProgressWithLevel:(NSInteger )level;
@end
NS_ASSUME_NONNULL_END
