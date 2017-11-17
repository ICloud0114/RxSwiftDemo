//
//  ICModelSelectView.m
//  Humidifier
//
//  Created by 郑云 on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICModelSelectView.h"


@interface ICModelSelectView ()
{
    CGFloat listViewHeight;
}

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;


@property (nonatomic, weak) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *height;

@property (nonatomic, strong) NSArray *modelListArr;

@end
@implementation ICModelSelectView

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFoodTag:) name:@"SelectFoodTag" object:nil];
    
    NSInteger row = self.modelListArr.count %3 > 0 ? self.modelListArr.count / 3 +  1: self.modelListArr.count / 3;
    
    listViewHeight  = row * 49;
    
    
    CGRect rect = self.modelListView.frame;
    rect.size.height = 0;
    self.modelListView.frame = rect;
    
    self.selectLabel.text = @"";
//    CGRect myRect = self.frame;
//    myRect.size.height ;
//    self.frame = myRect;
//    self.height.constant = 49;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.modelListView displayModelListWithDataArray:self.modelListArr withCol:0];
   
   
}

- (IBAction)selectTimeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.arrowImageView.transform = CGAffineTransformIdentity;
            CGRect rect = self.modelListView.frame;
            rect.size.height = listViewHeight;
            self.modelListView.frame = rect;
            CGRect myRect = self.frame;
            myRect.size.height += listViewHeight;
            self.frame = myRect;
            self.height.constant += listViewHeight;
             [self.modelListView displayModelListWithDataArray:self.modelListArr withCol:0];
            self.modelListView.hidden = NO;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        
//        [UIView animateWithDuration:0.01 animations:^{
        
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-180.f / 180.f * M_PI);
            CGRect rect = self.modelListView.frame;
            rect.size.height = 0;
            self.modelListView.frame = rect;
            
            CGRect myRect = self.frame;
            myRect.size.height -= listViewHeight;
            self.frame = myRect;
            
            self.modelListView.hidden = YES;
//        } completion:^(BOOL finished) {
            self.height.constant = 49;
//        }];

    }
}


- (NSArray *)modelListArr
{
    if (!_modelListArr) {
        
        NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"ModeList" ofType:@"plist"];
        
        _modelListArr = [[NSArray arrayWithContentsOfFile:dataSourcePath] lastObject];
    }
    return _modelListArr;
}

- (void)changeFoodTag:(NSDictionary *)dict
{
    NSDictionary *objectDict = [dict valueForKey:@"object"];
    NSString *foodName = [objectDict valueForKey:@"foodName"];
    self.selectLabel.text = foodName;
}

@end
