//
//  AlertView.m
//  TBTophome
//
//  Created by Topband on 2017/1/9.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "AlertView.h"

@interface AlertView() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *alert;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (nonatomic, strong) UILabel *inputView;
@end

@implementation AlertView

- (void)showInView:(UIView *)view {
    UIView *selfView = self;
    [view addSubview:selfView];
    selfView.layer.backgroundColor = [UIColor clearColor].CGColor;
    selfView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[selfView]|"
                                                                options:0
                                                                metrics:nil
                                                                  views:NSDictionaryOfVariableBindings(selfView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[selfView]|"
                                                                options:0
                                                                metrics:nil
                                                                  views:NSDictionaryOfVariableBindings(selfView)]];
    [selfView layoutIfNeeded];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.25f animations:^{
        selfView.layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        self.topConstraint.constant = CGRectGetHeight(self.alert.frame);
        [selfView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

- (IBAction)dismiss:(UIButton *)sender {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.25f animations:^{
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.topConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self removeFromSuperview];
        
        if ([self.delegate respondsToSelector:@selector(alertView:didClicked:)]) {
            [self.delegate alertView:self didClicked:sender.tag - 1];
        }
    }];
}

- (IBAction)textChange:(UITextField *)sender {
    self.inputView.text = sender.text;
}

- (IBAction)didEndEdit:(id)sender {
    [self.textField resignFirstResponder];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    UILabel *inputView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44)];
    inputView.textAlignment = NSTextAlignmentCenter;
    inputView.backgroundColor = [UIColor whiteColor];
    inputView.text = self.textField.placeholder;
    self.textField.inputAccessoryView = inputView;
    self.inputView = inputView;
    
    self.textMaxLength = 16;
}


+ (instancetype)alertView:(AlertStyle)style {
    UINib *nib = [UINib nibWithNibName:@"AlertView" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:style];
}
@end
