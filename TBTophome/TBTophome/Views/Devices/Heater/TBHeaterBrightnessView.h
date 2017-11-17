//
//  TBHeaterBrightnessView.h
//  TBTophome
//
//  Created by Topband on 2017/1/11.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TBHeaterBrightnessViewDelegate;
@interface TBHeaterBrightnessView : UIView

@property (weak, nonatomic) id<TBHeaterBrightnessViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UIImageView *track;

- (void)setNodeIndex:(NSInteger)index animated:(BOOL)animated;
@end

@protocol TBHeaterBrightnessViewDelegate <NSObject>

- (void)heaterBrightnessView:(TBHeaterBrightnessView *)view didMoveToNodeIndex:(NSInteger)index;

@end
NS_ASSUME_NONNULL_END
