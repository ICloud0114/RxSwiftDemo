//
//  TBAircView.m
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBAircView.h"

@interface TBAircView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (assign, nonatomic) RemotePanelType panelType;

@end

@implementation TBAircView

- (void)showToolBar {
    [self.toolBarDelegate didShow];
    [UIView animateWithDuration:0.2f animations:^{
        self.bottomConstraint.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)hideToolBar {
    [UIView animateWithDuration:0.2f animations:^{
        self.bottomConstraint.constant = 49;
        [self layoutIfNeeded];
    }];
}

- (UIButton *)leftBt {
    return self.left;
}

- (UILabel *)leftTitle {
    return self.leftLabel;
}

- (UIButton *)rightBt {
    return self.right;
}

- (UILabel *)rightTitle {
    return self.rightLabel;
}

- (UIButton *)okBt {
    return self.ok;
}

#pragma mark - setup

+ (instancetype)RemoteViewPanelType:(RemotePanelType)type {
    UINib *nib = nil;
    if (type == RemoteWallAirType) {
        nib = [UINib nibWithNibName:@"TBAircView" bundle:nil];
    } else if (type == RemoteCabinetAirType) {
        nib = [UINib nibWithNibName:@"TBCAircView" bundle:nil];
    }
    TBAircView *aircView = [[nib instantiateWithOwner:nil options:nil] lastObject];
    aircView.panelType = type;
    return aircView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - getter setter
- (void)setPower:(BOOL)power {
    _power = power;
    if (self.panelType == RemoteWallAirType) {
        self.powerState.image = _power ? [UIImage imageNamed:@"conditioner_bg4.png"] : [UIImage imageNamed:@"conditioner_bg2.png"];
    } else {
        self.powerState.hidden = power;
    }
}

@end
