//
//  ICNormalCleanView.m
//  Humidifier
//
//  Created by zhengyun on 16/9/22.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICNormalCleanView.h"
#import "ICSlideView.h"
@interface ICNormalCleanView()
@property (weak, nonatomic) IBOutlet UIButton *slideButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (weak, nonatomic) IBOutlet ICSlideView *temperatureSlideView;
@property (weak, nonatomic) IBOutlet ICSlideView *pressureSlideView;
@property (weak, nonatomic) IBOutlet ICSlideView *positionSlideView;
@property (weak, nonatomic) IBOutlet ICSlideView *timeSlideView;

@property (weak, nonatomic) IBOutlet UILabel *spaLabel;

@property (weak, nonatomic) IBOutlet UILabel *massageLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveLabel;
@property (weak, nonatomic) IBOutlet UILabel *careLabel;
@property (weak, nonatomic) IBOutlet UIButton *spaButton;
@property (weak, nonatomic) IBOutlet UIButton *massageButton;
@property (weak, nonatomic) IBOutlet UIButton *moveButton;


@property (weak, nonatomic) IBOutlet UIButton *careBtn;



@end
@implementation ICNormalCleanView



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
- (IBAction)spaAction:(UIButton *)sender {
     sender.selected = !sender.selected;
    if (sender.selected) {
        self.spaLabel.hidden = NO;
        self.temperatureSlideView.hidden = YES;
        self.massageLabel.hidden = NO;
        self.pressureSlideView.hidden = YES;
        
        self.massageButton.selected = YES;
        self.massageButton.userInteractionEnabled = NO;
        
        if (self.changeSPA) {
            self.changeSPA(7, 6);
        }
    }
    else
    {
        self.spaLabel.hidden = YES;
        self.temperatureSlideView.hidden = NO;
        self.massageLabel.hidden = YES;
        self.pressureSlideView.hidden = NO;
        self.massageButton.selected = NO;
        self.massageButton.userInteractionEnabled = YES;
        
        if (self.changeSPA) {
            self.changeSPA(self.temperatureSlideView.sectionIndex+ 1,  self.pressureSlideView.sectionIndex + 1);
        }
    }
}
- (IBAction)massageAction:(UIButton *)sender {
     sender.selected = !sender.selected;
    if (sender.selected) {
        self.massageLabel.hidden = NO;
        self.pressureSlideView.hidden = YES;
        if (self.changePressure) {
            self.changePressure(5);
        }
    }
    else
    {
        self.massageLabel.hidden = YES;
        self.pressureSlideView.hidden = NO;
        if (self.changePressure) {
            self.changePressure(self.pressureSlideView.sectionIndex );
        }
    }
}

- (IBAction)moveAction:(UIButton *)sender {
     sender.selected = !sender.selected;
    if (sender.selected) {
        self.moveLabel.hidden = NO;
        self.positionSlideView.hidden = YES;
        if (self.changePosition) {
            self.changePosition(5);
        }
    }
    else
    {
        self.moveLabel.hidden = YES;
        self.positionSlideView.hidden = NO;
        if (self.changePosition) {
            self.changePosition(self.positionSlideView.sectionIndex );
        }
    }
}

- (IBAction)careAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.careLabel.hidden = NO;
        self.temperatureSlideView.hidden = YES;
        if (self.changeTemperature) {
            self.changeTemperature(7);
        }
    }
    else
    {
        self.careLabel.hidden = YES;
        self.temperatureSlideView.hidden = NO;
        if (self.changeTemperature) {
            self.changeTemperature(self.temperatureSlideView.sectionIndex);
        }
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}


+ (ICNormalCleanView *)shareNormalCleanView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ICNormalCleanView" owner:nil options:nil] firstObject];
}

+ (ICNormalCleanView *)shareFemaleCleanView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ICNormalCleanView" owner:nil options:nil] lastObject];
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
        
        if (self.dismissComplete) {
            self.dismissComplete();
        }

        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    
    ICNormalCleanView *normalView = self;
    normalView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:normalView];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[normalView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(normalView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[normalView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(normalView)]];
    [normalView layoutIfNeeded];
    
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
    
    
    [_temperatureSlideView addSliderTitles:@[@"OFF",@"32˚C",@"34˚C",@"36˚C",@"38˚C",@"40˚C"]];
    [_pressureSlideView addSliderTitles:@[@"1档",@"2档",@"3档",@"4档",@"5档"]];
    [_positionSlideView addSliderTitles:@[@"1档",@"2档",@"3档",@"4档",@"5档"]];
    [_timeSlideView addSliderTitles:@[@"1 min",@"2 min",@"3 min",@"4 min"]];
    
    self.temperatureSlideView.changeIndex = ^(NSInteger idx)
    {
//        TBLog(@"temperture --->%ld",idx);
        if (self.changeTemperature) {
            self.changeTemperature(idx);
        }
    };
    self.pressureSlideView.changeIndex = ^(NSInteger idx)
    {
//        TBLog(@"pressure --->%ld",idx);
        if (self.changePressure) {
            self.changePressure(idx);
        }
    };
    self.positionSlideView.changeIndex = ^(NSInteger idx)
    {
//        TBL@IBInspectableog(@"position --->%ld",idx);
        if (self.changePosition) {
            self.changePosition(idx);
        }
    };
    self.timeSlideView.changeIndex = ^(NSInteger idx)
    {
//        TBLog(@"time --->%ld",idx);
        if (self.changeTime) {
            self.changeTime(idx);
        }
    };
    
}

- (void)showProgressWithTemperature:(NSInteger )temp pressure:(NSInteger )pressure position:(NSInteger )position andTime:(NSInteger )time
{
    [self.temperatureSlideView setSectionIndex:temp animated:YES];
    [self.pressureSlideView setSectionIndex:pressure animated:YES];
    [self.positionSlideView setSectionIndex:position animated:YES];
    [self.timeSlideView setSectionIndex:time animated:YES];
    
    if (temp == 6) {
        self.spaLabel.hidden = NO;
        self.temperatureSlideView.hidden = YES;
        self.massageLabel.hidden = NO;
        self.pressureSlideView.hidden = YES;
        self.spaButton.selected = YES;
        self.massageButton.selected = YES;
        self.massageButton.userInteractionEnabled = NO;
        
    }else if (temp == 7){
        self.careLabel.hidden = NO;
        self.temperatureSlideView.hidden = YES;
        self.careBtn.selected = YES;
    }
    
    if (pressure == 5) {
        self.massageLabel.hidden = NO;
        self.pressureSlideView.hidden = YES;
        self.massageButton.selected = YES;
    }
    
    if (position == 5){
        
        self.moveLabel.hidden = NO;
        self.positionSlideView.hidden = YES;
        self.moveButton.selected = YES;
    }
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] lastObject];
   if( [touch.view isEqual:self])
   {
       [self dismiss];
   }
   
}


@end
