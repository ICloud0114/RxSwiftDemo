//
//  TBIconImageView.m
//  TBTophome
//
//  Created by Topband on 2017/2/17.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBIconImageView.h"

@implementation TBIconImageView

- (void)setState:(TBIconState)state {
    _state = state;
    if (_state == normalState) {
        self.image = self.normalImage;
    } else if (_state == selectedState) {
        self.image = self.selectedImage;
    } else if (_state == disabledState) {
        self.image = self.disabledImage;
    }
}

@end
