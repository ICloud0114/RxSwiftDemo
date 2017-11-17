//
//  TBAddRemotesTipView.m
//  TBTophome
//
//  Created by Topband on 2017/3/16.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAddRemotesTipView.h"

@interface TBAddRemotesTipView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@end

@implementation TBAddRemotesTipView

+ (instancetype)instanceAddRemotesTipView {
    UINib *nib = [UINib nibWithNibName:@"TBAddRemotesTipView" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

- (IBAction)closeAction:(id)sender {
    [self dismiss];
}

- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        self.top.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.top.constant = -30;
        [self layoutIfNeeded];
    }];
}

@end
