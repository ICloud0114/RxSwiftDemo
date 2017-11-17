//
//  ICTimeSelectView.m
//  Humidifier
//
//  Created by 郑云 on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICTimeSelectView.h"
#import "UIColor+Ex.h"
@interface ICTimeSelectView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *selectLabel;

@property (nonatomic, weak) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *height;

@property (nonatomic, strong) NSMutableArray *hoursArr;
@property (nonatomic, strong) NSMutableArray *minutesArr;


@end
@implementation ICTimeSelectView

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
    myRect.size.height -= 217;
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
            rect.size.height = 217;
            self.pickerView.frame = rect;
            CGRect myRect = self.frame;
            myRect.size.height += 217;
            self.frame = myRect;
            self.height.constant = 266;
        
            
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
            myRect.size.height -= 217;
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
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component  == 0) {
        return self.hoursArr.count;
    }
    else if(component == 2)
    {
        return self.minutesArr.count;
    }else{
        return 1;
    }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component  == 0) {
        return self.hoursArr[row];
    }
    else if(component == 2)
    {
        return self.minutesArr[row];
    }
    
    if (component == 1) {
        return @"时";
    }
    if (component == 3) {
        return @"分";
    }
    return nil;
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED
//{
//    if (component  == 0) {
//        return self.hoursArr[row];
//    }
//    else if(component == 2)
//    {
//        return self.minutesArr[row];
//    }
//    
//    if (component == 1) {
//        return @"min";
//    }
//    if (component == 3) {
//        return @"sec";
//    }
//    return nil;
//}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
//{
//
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 1 || component == 3) {
        return 40;
    } else {
        return 40;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSString *hour = @"0";
    NSString *minutes = @"0";
    if (component == 0) {
        self.hour = row;
       hour = [NSString stringWithFormat:@"%@",self.hoursArr[row]];
    }
    else if(component == 2)
    {
        self.min = row;
       minutes = [NSString stringWithFormat:@"%@",self.minutesArr[row] ];
    }
//    self.selectLabel.text = [NSString stringWithFormat:@"%@ : %@",hour,minutes];
    self.selectLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",self.hour,self.min];
    
}


- (NSMutableArray *)hoursArr
{
    if (!_hoursArr) {
        _hoursArr = @[].mutableCopy;
        
        for (NSInteger hour = 0;  hour < 24; ++ hour) {
//            NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",hour]];
//            [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",hour] length])];
//            [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#282828"] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",hour] length])];
//            
//            [_hoursArr addObject:attributeStr];
            NSString *str = [NSString stringWithFormat:@"%ld",hour];
            [_hoursArr addObject:str];
        }
    }
    return _hoursArr;
}

- (NSMutableArray *)minutesArr
{
    if (!_minutesArr) {
        _minutesArr = @[].mutableCopy;
        
        for (NSInteger minutes = 0;  minutes < 60; ++ minutes) {
//            NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",minutes]];
//            [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",minutes] length])];
//            [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#282828"] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",minutes] length])];
//            
//            [_minutesArr addObject:attributeStr];
            NSString *str = [NSString stringWithFormat:@"%ld",minutes];
            [_minutesArr addObject:str];
        }
    }
    return _minutesArr;
}
- (void)setHour:(NSInteger)hour{
    _hour = hour;
    self.selectLabel.text = [NSString stringWithFormat:@"%02zd%@",hour,[self.selectLabel.text substringFromIndex:2]];
    [self.pickerView selectRow:hour inComponent:0 animated:NO];
}
- (void)setMin:(NSInteger)min{
    _min = min;
    self.selectLabel.text = [NSString stringWithFormat:@"%@%02zd",[self.selectLabel.text substringToIndex:3],min];
    [self.pickerView selectRow:min inComponent:2 animated:NO];
}
@end
