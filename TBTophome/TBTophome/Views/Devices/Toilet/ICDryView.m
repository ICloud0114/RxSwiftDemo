//
//  ICDryView.m
//  Humidifier
//
//  Created by zhengyun on 16/9/23.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICDryView.h"
#import "ICSlideView.h"
@interface ICDryView ()

@property (weak, nonatomic) IBOutlet UIButton *slideButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet ICSlideView *drySlideView;

@end
@implementation ICDryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)slideDownAction:(id)sender {
    
    [self dismiss];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}


+ (ICDryView *)shareDryView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ICDryView" owner:nil options:nil] lastObject];
}

- (void)dismiss {
    
    self.slideButton.selected = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6 options:0 animations:^{
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        CGRect alertFrame = self.controlView.frame;
        alertFrame.origin.y += self.controlView.frame.size.height  - self.slideButton.frame.size.height / 2.f;
        self.controlView.frame = alertFrame;
        
        CGRect slideFrame = self.slideButton.frame;
        slideFrame.origin.y += self.controlView.frame.size.height  - self.slideButton.frame.size.height / 2.f;
        self.slideButton.frame = slideFrame;
        
        //        self.controlView.layer.opacity = 0.f;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if (self.dismissComplete) {
            self.dismissComplete();
        }
    }];
}

- (void)showInView:(UIView *)view {
    
    ICDryView *dryView = self;
    dryView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:dryView];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dryView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dryView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dryView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dryView)]];
    [dryView layoutIfNeeded];
    
    CGRect alertFrame = self.controlView.frame;
    alertFrame.origin.y += self.controlView.frame.size.height  - self.slideButton.frame.size.height / 2.f;
    self.controlView.frame = alertFrame;
    
    CGRect slideFrame = self.slideButton.frame;
    slideFrame.origin.y += self.controlView.frame.size.height  - self.slideButton.frame.size.height / 2.f;
    self.slideButton.frame = slideFrame;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:0 animations:^{
        //            self.alert.transform = CGAffineTransformMakeScale(1.0, 1.0);
        CGRect alertFrame = self.controlView.frame;
        alertFrame.origin.y -= self.controlView.frame.size.height  - self.slideButton.frame.size.height / 2.f;
        self.controlView.frame = alertFrame;
        
        CGRect slideFrame = self.slideButton.frame;
        slideFrame.origin.y -= self.controlView.frame.size.height  - self.slideButton.frame.size.height / 2.f;
        self.slideButton.frame = slideFrame;
        
    } completion:^(BOOL finished)
     {
         self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
     }];
    
    [self.drySlideView addSliderTitles:@[@"常温",@"低",@"中",@"高"]];
    
    
    self.drySlideView.changeIndex = ^(NSInteger idx)
    {
        TBLog(@"---->%ld",idx);
        
        if (self.changeLevel) {
            self.changeLevel (idx);
        }
    };
    
    
}

- (void)showProgressWithLevel:(NSInteger )level
{
    [self.drySlideView setSectionIndex:level animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
