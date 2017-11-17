//
//  LFInductionCookingCountdownView.m
//  SmartHomeSystem
//
//  Created by Topband on 16/9/26.
//  Copyright © 2016年 topband. All rights reserved.
//

#import "LFDishwasherReservationView.h"

@interface LFDishwasherReservationView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *componentView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation LFDishwasherReservationView

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [@(row + 1) stringValue];
    }
    return @"时";
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 24;
    }
    return 1;
}

- (IBAction)sure:(id)sender {
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didSelectedReservationTime:)]) {
        [self.delegate didSelectedReservationTime:[self.pickerView selectedRowInComponent:0] + 1];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismiss];
}


+ (instancetype)dishwasherReservationView {
    UINib *nib = [UINib nibWithNibName:@"LFDishwasherReservationView" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)dismiss {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.bottomLayoutConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    UIView *selfView = self;
    [view addSubview:selfView];
    selfView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[selfView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selfView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[selfView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selfView)]];
    [selfView layoutIfNeeded];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.bottomLayoutConstraint.constant = -CGRectGetHeight(self.componentView.frame);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

@end
