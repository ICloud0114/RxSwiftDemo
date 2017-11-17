//
//  UIView+HighlightedMessage.m
//  TBTophome
//
//  Created by Topband on 2017/1/4.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "UIView+HighlightedMessage.h"

@implementation UIView (HighlightedMessage)

- (void)showHightLightMessage:(NSString *)msg bgColor:(UIColor *)color {
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:msg];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    //行间距
    [paragraphStyle setLineSpacing:5.f];
    //字符间距
    [paragraphStyle setParagraphSpacing:2.f];
    
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [msg length])];
    
    UIView *hilight = [[UIView alloc]init];
    [hilight setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    hilight.backgroundColor = color;
    UILabel *label = [[UILabel alloc] initWithFrame:hilight.frame];
    label.attributedText = attributeStr;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [hilight addSubview:label];
    [self addSubview:hilight];
    
    hilight.layer.opacity = 0;
    [UIView animateWithDuration:0.2 animations:^{
        hilight.layer.opacity = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            hilight.layer.opacity = 0;
        } completion:^(BOOL finished) {
            [hilight removeFromSuperview];
        }];
//        [hilight removeFromSuperview];
    }];
}

@end
