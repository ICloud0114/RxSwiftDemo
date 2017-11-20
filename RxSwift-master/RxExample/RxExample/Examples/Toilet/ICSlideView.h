//
//  ICSlideView.h
//  SmartHomeSystem
//
//  Created by zhengyun on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICSlideView : UIControl

- (void)addSliderTitles:(NSArray *)titles;

- (void)setSectionIndex:(NSInteger )index animated:(BOOL)animated;

@property (nonatomic, assign) NSInteger sectionIndex;

@property (nonatomic, copy) void (^changeIndex)(NSInteger index);

@end
