//
//  LFCookingMachineTimeView.h
//  CookingMachine
//
//  Created by Topband on 16/9/1.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFCookingMachineTimeViewDelegate;
NS_ASSUME_NONNULL_BEGIN
@interface LFCookingMachineTimeView : UIView

@property (weak, nonatomic) IBOutlet id<LFCookingMachineTimeViewDelegate> delegate;
@property (nonatomic, assign) NSInteger seconds;

@end

@protocol LFCookingMachineTimeViewDelegate <NSObject>

- (void)didSelected:(NSInteger)min second:(NSInteger)second;

@end
NS_ASSUME_NONNULL_END
