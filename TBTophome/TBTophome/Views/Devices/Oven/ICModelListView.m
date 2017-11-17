//
//  ICModelListView.m
//  Humidifier
//
//  Created by zhengyun on 16/9/17.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICModelListView.h"
#import "UIColor+Ex.h"
@interface ICModelListView ()
{
    NSArray *dataArr;
}
@property (nonatomic, strong) NSMutableArray *selectArr;

@end
@implementation ICModelListView

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
    
   
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (void)displayModelListWithDataArray:(NSArray *)arr withCol:(NSInteger)col
{
    [self layoutIfNeeded];
    
    dataArr = arr;
//    NSInteger ListRow = arr.count %3 > 0 ? arr.count / 3 +  1: arr.count / 3;
    if (!_selectArr) {
        
    
        CGFloat space = 90.f / 375.f * self.frame.size.width / 4.f;
        if (self.frame.size.width <= 320) {
            space = 31;
        }
        
        CGFloat buttonWidth = (self.frame.size.width - 4 *space) / 3.f;
        CGFloat rait = buttonWidth * 1.f/95;
        
        for (NSInteger sub = 1; sub <= dataArr.count; ++ sub) {
            
            NSDictionary *dic = dataArr[sub -1];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = [dic[@"tag"] integerValue];//col *100 + sub;
//            if (sub == 1 && (col == 1 || col == 0)) {
//                btn.selected = YES;
//                self.selectBtn = btn;
//            }
            CGRect rect ;
            rect.size.width = buttonWidth;
            rect.size.height = 39 * rait;
            rect.origin.x = space *((sub -1) %3 + 1) + buttonWidth * ((sub -1) %3);
            rect.origin.y = 50 * ((sub- 1) /3);
            btn.frame = rect;
            [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor colorWithHexString:@"#828282"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_food_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_food_press"] forState:UIControlStateHighlighted];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_food_select"] forState:UIControlStateSelected];
            
            [btn addTarget:self action:@selector(selectModel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            [self.selectArr addObject:btn];
            
        }
    }
    
}


- (void)selectModel:(UIButton *)sender
{
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = !sender.selected;
    NSDictionary *dict = @{@"foodTag":@(sender.tag),
                           @"foodName":sender.titleLabel.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectFoodTag" object:dict];
}

- (NSMutableArray *)selectArr
{
    if (!_selectArr) {
        _selectArr = @[].mutableCopy;
    }
    return _selectArr;
}





@end
