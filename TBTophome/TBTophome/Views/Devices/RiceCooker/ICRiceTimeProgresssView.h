//
//  ICRiceTimeProgresssView.h
//  SmartHomeSystem
//
//  Created by 张雷 on 16/9/27.
//  Copyright © 2016年 topband. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface ICRiceTimeProgresssView : UIView

@property (nonatomic, assign) NSInteger cookMin;
@property (nonatomic, assign) NSInteger cookMode;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

- (void)startLoading;
- (void)endLoading;
@end

NS_ASSUME_NONNULL_END
