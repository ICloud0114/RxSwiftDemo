//
//  UIButton+EnlargeEdge.h
//  Vihome
//
//  Created by Ned on 6/5/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end


