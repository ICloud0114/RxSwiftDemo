//
//  LFCookingMachineTimeView.m
//  CookingMachine
//
//  Created by Topband on 16/9/1.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "LFCookingMachineTimeView.h"

@interface LFCookingMachineTimeView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

@end

@implementation LFCookingMachineTimeView

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) { return 60; }
    else if (component == 1) { return 1; }
    else if (component == 2) { return 60; }
    else { return 1; }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0 || component == 2) {
        return [@(row) stringValue];
    }
    if (component == 1) {
        return @"min";
    }
    if (component == 3) {
        return @"sec";
    }
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 1 || component == 3) {
        return 50;
    } else {
        return 40;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(didSelected:second:)]) {
        [self.delegate didSelected:[pickerView selectedRowInComponent:0] second:[pickerView selectedRowInComponent:2]];
    }
}

#pragma mark - getter setter
- (void)setSeconds:(NSInteger)seconds {
    if (_seconds != seconds) {
        _seconds = seconds;
        NSInteger minute = _seconds / 60;
        NSInteger sec = _seconds % 60;
        [self.pickerView selectRow:minute inComponent:0 animated:YES];
        [self.pickerView selectRow:sec inComponent:2 animated:YES];
    }
}

@end
