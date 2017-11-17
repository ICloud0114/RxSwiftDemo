//
//  TextField.m
//  Template
//
//  Created by Topband on 2016/12/19.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TextField.h"

@implementation TextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat textLeading = self.textLeading;
    CGRect textFrame = bounds;
    textFrame.origin.x = self.leftView.bounds.size.width + textLeading;
    textFrame.size.width = bounds.size.width - textFrame.origin.x - self.textTrailing - self.rightView.bounds.size.width;
    return textFrame;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    if (self.rightView == nil && !self.rightViewAutoResize) {
        return CGRectZero;
    }
    CGFloat height = CGRectGetHeight(bounds);
    return CGRectMake(CGRectGetWidth(bounds) - height, 0, height, height);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
