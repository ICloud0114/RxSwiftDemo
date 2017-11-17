//
//  ICRecipeSelectView.m
//  Humidifier
//
//  Created by 郑云 on 16/9/20.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICRecipeSelectView.h"


@interface ICRecipeSelectView () <UIScrollViewDelegate>
{
    CGFloat listMaxHeight;
}
@property (nonatomic, weak) IBOutlet UIScrollView *listScrollView;



@property (nonatomic, weak) IBOutlet UIImageView *arrowImageView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *height;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *sectionHeight;

@property (nonatomic, weak) IBOutlet UIButton *meatGroupButton;
@property (nonatomic, weak) IBOutlet UIButton *vegetablesGroupButton;
@property (nonatomic, weak) IBOutlet UIButton *cookieGroupButton;
@property (nonatomic, weak) IBOutlet UIView *tagView;

@property (nonatomic, strong) NSArray *meatListArr;
@property (nonatomic, strong) NSArray *pastryListArr;
@property (nonatomic, strong) NSArray *vegetablesListArr;
@end
@implementation ICRecipeSelectView

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
    
    NSInteger row1 = self.meatListArr.count %3 > 0 ? self.meatListArr.count / 3 +  1: self.meatListArr.count / 3;
    
    NSInteger row2 = self.pastryListArr.count %3 > 0 ? self.pastryListArr.count / 3 +  1: self.pastryListArr.count / 3;
    
    NSInteger row3 = self.vegetablesListArr.count %3 > 0 ? self.vegetablesListArr.count / 3 +  1: self.vegetablesListArr.count / 3;
    
    NSInteger row = MAX(row1, row2);
    NSInteger maxRow = MAX(row, row3);
    
    listMaxHeight  = maxRow * 49 + 40 + 10;
    
    self.selectLabel.text = @"";
//    CGRect rect = self.listScrollView.frame;
//    rect.size.height = 0;
//    self.listScrollView.frame = rect;
    
    self.listScrollView.delegate = self;
    //    CGRect myRect = self.frame;
    //    myRect.size.height ;
    //    self.frame = myRect;
    //    self.height.constant = 49;
    
   
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.frame.size.width == TBScreenWidth) {
        
        [self.meatListView displayModelListWithDataArray:self.meatListArr withCol:1];
        [self.pastryListView displayModelListWithDataArray:self.pastryListArr withCol:2];
        [self.vegetablesListView displayModelListWithDataArray:self.vegetablesListArr withCol:3];
    }
    
}

- (IBAction)selectTimeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.arrowImageView.transform = CGAffineTransformIdentity;
            CGRect rect = self.listScrollView.frame;
            rect.size.height = listMaxHeight;
            self.listScrollView.frame = rect;
            CGRect myRect = self.frame;
            myRect.size.height += listMaxHeight;
            self.frame = myRect;
            self.height.constant += listMaxHeight;
            
            self.sectionHeight.constant = 40;
            [self.meatListView displayModelListWithDataArray:self.meatListArr withCol:1];
            [self.pastryListView displayModelListWithDataArray:self.pastryListArr withCol:2];
            [self.vegetablesListView displayModelListWithDataArray:self.vegetablesListArr withCol:3];
            self.listScrollView.hidden = NO;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
//        [UIView animateWithDuration:0.25 animations:^{
        
        self.arrowImageView.transform = CGAffineTransformMakeRotation(-180.f / 180.f * M_PI);
            
            CGRect rect = self.listScrollView.frame;
            rect.size.height = 0;
            self.listScrollView.frame = rect;
            
            CGRect myRect = self.frame;
            myRect.size.height -= listMaxHeight;
            self.frame = myRect;
            
            self.listScrollView.hidden = YES;
            
            self.sectionHeight.constant = 0;
            
//        } completion:^(BOOL finished) {
            self.height.constant = 49;
//        }];
    
    }
}

- (NSArray *)meatListArr
{
    if (!_meatListArr) {
//        101：烤鸡翅102：烤全鸡103：烤全鸭104：牛扒105：猪扒106：肉片107：鱿鱼108：肉串109：烤鱼110：肋排111：香肠112：生蚝113：叉烧
//        _meatListArr = @[@"烤鸡翅",@"烤全鸡",@"烤全鸭",@"牛扒",@"猪扒",@"肉片",@"鱿鱼",@"肉串",@"烤鱼",@"肋排",@"香肠",@"生蚝",@"叉烧"];
        NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"ModeList" ofType:@"plist"];
        
        _meatListArr = [[NSArray arrayWithContentsOfFile:dataSourcePath] firstObject];
    }
    return _meatListArr;
}
- (NSArray *)pastryListArr
{
    if (!_pastryListArr) {
//        201：蛋糕202：面包203：比萨204：布丁205：曲奇206：蛋挞207：蛋黄酥208：苹果派209：烧饼
//        _pastryListArr = @[@"面包",@"曲奇",@"布丁",@"蛋糕",@"披萨",@"蛋挞",@"蛋黄酥",@"苹果派",@"烧饼"];
        NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"ModeList" ofType:@"plist"];
        
        _pastryListArr = [[NSArray arrayWithContentsOfFile:dataSourcePath] objectAtIndex:1];
    }
    return _pastryListArr;
}
- (NSArray *)vegetablesListArr
{
    if (!_vegetablesListArr) {
//        301：玉米302：红薯303：土豆304：茄子305：南瓜
//        _vegetablesListArr = @[@"玉米",@"红薯",@"土豆",@"茄子",@"南瓜"];
        NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"ModeList" ofType:@"plist"];
        
        _vegetablesListArr = [[NSArray arrayWithContentsOfFile:dataSourcePath] objectAtIndex:2];
    }
    return _vegetablesListArr;
}

- (IBAction)meatGroup:(UIButton *)sender {
    [self.listScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.meatGroupButton.selected = YES;
    self.vegetablesGroupButton.selected = NO;
    self.cookieGroupButton.selected = NO;
    
    self.tagView.center = CGPointMake(self.meatGroupButton.center.x, self.tagView.center.y);
//    self.tagView.frame = CGRectMake(43, 38, 46, 2);
}

- (IBAction)vegetablesGroup:(UIButton *)sender {
    [self.listScrollView setContentOffset:CGPointMake(TBScreenWidth * 2, 0) animated:YES];
    self.meatGroupButton.selected = NO;
    self.vegetablesGroupButton.selected = YES;
    self.cookieGroupButton.selected = NO;
//    self.tagView.frame = CGRectMake(277, 38, 46, 2);
    self.tagView.center = CGPointMake(self.vegetablesGroupButton.center.x, self.tagView.center.y);
}

- (IBAction)cookieGroup:(UIButton *)sender {
    [self.listScrollView setContentOffset:CGPointMake(TBScreenWidth, 0) animated:YES];
    self.meatGroupButton.selected = NO;
    self.vegetablesGroupButton.selected = NO;
    self.cookieGroupButton.selected = YES;
//    self.tagView.frame = CGRectMake(164, 38, 46, 2);
    self.tagView.center = CGPointMake(self.cookieGroupButton.center.x, self.tagView.center.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        self.meatGroupButton.selected = YES;
        self.vegetablesGroupButton.selected = NO;
        self.cookieGroupButton.selected = NO;
//        self.tagView.frame = CGRectMake(43, 38, 46, 2);
        self.tagView.center = CGPointMake(self.meatGroupButton.center.x, self.tagView.center.y);
    }
    else if (scrollView.contentOffset.x == TBScreenWidth)
    {
        self.meatGroupButton.selected = NO;
        self.vegetablesGroupButton.selected = NO;
        self.cookieGroupButton.selected = YES;
//        self.tagView.frame = CGRectMake(164, 38, 46, 2);
        self.tagView.center = CGPointMake(self.cookieGroupButton.center.x, self.tagView.center.y);
    }
    else if (scrollView.contentOffset.x == TBScreenWidth*2)
    {
        self.meatGroupButton.selected = NO;
        self.vegetablesGroupButton.selected = YES;
        self.cookieGroupButton.selected = NO;
//        self.tagView.frame = CGRectMake(277, 38, 46, 2);
        self.tagView.center = CGPointMake(self.vegetablesGroupButton.center.x, self.tagView.center.y);
    }
}

- (void)changeFoodTag:(NSDictionary *)dict
{
    NSDictionary *objectDict = [dict valueForKey:@"object"];
    NSInteger foodTag = [[objectDict valueForKey:@"foodTag"] integerValue];
    NSString *foodName = [objectDict valueForKey:@"foodName"];
    
    
    self.meatListView.selectBtn.selected = self.meatListView.selectBtn.tag == foodTag ?YES:NO;
    self.pastryListView.selectBtn.selected = self.pastryListView.selectBtn.tag == foodTag ?YES:NO;
    self.vegetablesListView.selectBtn.selected = self.vegetablesListView.selectBtn.tag == foodTag ?YES:NO;
    self.foodTag = foodTag;
    self.selectLabel.text = foodName;
}

@end
