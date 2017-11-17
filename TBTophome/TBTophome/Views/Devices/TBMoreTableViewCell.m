//
//  TBMoreTableViewCell.m
//  TBTophome
//
//  Created by Topband on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBMoreTableViewCell.h"

@implementation TBMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)modifyNameAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didModifyName)]) {
        [self.delegate didModifyName];
    }
}

- (IBAction)upgradeAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didUpgrade)]) {
        [self.delegate didUpgrade];
    }
}
@end
