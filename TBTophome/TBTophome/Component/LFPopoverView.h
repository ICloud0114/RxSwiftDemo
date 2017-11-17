//
//  LFPopoverView.h
//  TopHome
//
//  Created by 胡小宝 on 14-11-28.
//  Copyright (c) 2014年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFPopoverView : UIView

+ (instancetype)popoverView;

@property (nonatomic, assign) CGSize arrowSize; //arrow size. Default is {10, 10}

@property (nonatomic, assign) BOOL roundCorner; //default: NO

@property (nonatomic, strong) UIColor *contentBackgroundColor;

@property (nonatomic, copy) dispatch_block_t dismissHandle;

- (void)showPopoverViewAtPoint:(CGPoint)point withContentView:(UIView *)contentView inView:(UIView *)containerView;

- (void)dismiss;

@end
