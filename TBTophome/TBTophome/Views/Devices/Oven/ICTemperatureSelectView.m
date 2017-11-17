//
//  ICTemperatureSelectView.m
//  Humidifier
//
//  Created by 郑云 on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICTemperatureSelectView.h"
#import "UIColor+Ex.h"
@interface ICTemperatureSelectView()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *selectLabel;

@property (nonatomic, weak) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *height;

@property (nonatomic, strong) NSMutableArray *temperatureArr;
@end
@implementation ICTemperatureSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{
    [super awakeFromNib];
    CGRect rect = self.pickerView.frame;
    rect.size.height = 0;
    self.pickerView.frame = rect;
    
    CGRect myRect = self.frame;
    myRect.size.height -= 219;
    self.frame = myRect;
    self.height.constant = 50;

}

- (IBAction)selectTimeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-180.f / 180.f * M_PI);
            CGRect rect = self.pickerView.frame;
            rect.size.height = 219;
            self.pickerView.frame = rect;
            CGRect myRect = self.frame;
            myRect.size.height += 219;
            self.frame = myRect;
            self.height.constant = 268;
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
//        [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.arrowImageView.transform = CGAffineTransformIdentity;
            
            CGRect rect = self.pickerView.frame;
            rect.size.height = 0;
            self.pickerView.frame = rect;
            
            CGRect myRect = self.frame;
            myRect.size.height -= 219;
            self.frame = myRect;
            self.height.constant = 50;
            
//        } completion:^(BOOL finished) {
//            
//        }];
    }
}

#pragma mark -UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.temperatureArr.count) {
        
        if (!component) {
            return (250 - self.lowTemp + 1);
        }else{
            return 1;
        }
       
    }else{
        return 0;
    }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (!component) {
        return self.temperatureArr[row];
    }else{
        return @"˚C";
    }
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (!component) {
        return 55;
    }else{
        return 40;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectTemp = self.lowTemp + row;
    self.selectLabel.text = [NSString stringWithFormat:@"%@ ˚C",self.temperatureArr[row]];
}

- (NSMutableArray *)temperatureArr
{
    if (!_temperatureArr) {
        _temperatureArr = @[].mutableCopy;

    }
    return _temperatureArr;
}


- (void)setLowTemp:(NSInteger)lowTemp{
    _lowTemp = lowTemp;
    for (NSInteger tem = self.lowTemp; tem <= 250; ++ tem) {
//        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",tem]];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",tem] length])];
//        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#282828"] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",tem] length])];
//        
//        [_temperatureArr addObject:attributeStr];
        NSString *str = [NSString stringWithFormat:@"%ld",tem];
        [_temperatureArr addObject:str];
    }
    [self.pickerView reloadAllComponents];
    
}
- (void)setSelectTemp:(NSInteger)selectTemp{
    _selectTemp = selectTemp;
    
    if (selectTemp >= self.lowTemp) {
        [self.pickerView selectRow:(selectTemp - self.lowTemp) inComponent:0 animated:NO];
        self.selectLabel.text = [NSString stringWithFormat:@"%ld ˚C",selectTemp];
    }else{
        self.selectLabel.text = [NSString stringWithFormat:@"-- ˚C",selectTemp];
    }
   
}

@end
