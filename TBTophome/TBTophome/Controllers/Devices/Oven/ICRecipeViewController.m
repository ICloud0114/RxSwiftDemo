//
//  ICRecipiViewController.m
//  Humidifier
//
//  Created by 郑云 on 16/9/20.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICRecipeViewController.h"
#import "ICRecipeSelectView.h"
#import "ICTemperatureSelectView.h"
#import "ICTimeSelectView.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ICRecipeViewController ()
@property (weak, nonatomic) IBOutlet ICRecipeSelectView *recipeSelectView;
@property (weak, nonatomic) IBOutlet ICTemperatureSelectView *temperatureSelectView;
@property (weak, nonatomic) IBOutlet ICTimeSelectView *timeSelectView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation ICRecipeViewController
- (void)dealloc{
    TBLog(@"销毁毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.recipeSelectView.foodTag = 0;
    self.temperatureSelectView.selectTemp = 60;
    self.timeSelectView.hour = 0;
    self.timeSelectView.min = 0;
    self.temperatureSelectView.lowTemp = 60;
    
    @weakify(self)
    RAC(self.temperatureSelectView, selectTemp) = [RACObserve(self.recipeSelectView, foodTag)map:^id _Nullable(id  _Nullable value) {
        @strongify(self)
        if ([value integerValue]) {
            NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"OvenDisplayMode" ofType:@"plist"];
            
            NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:dataSourcePath];
            
            NSArray *dataArr = [data objectForKey:[NSString stringWithFormat:@"%ld",[value integerValue]]];
            self.timeSelectView.hour = [[dataArr objectAtIndex:2] integerValue] / 60;
            self.timeSelectView.min =   [[dataArr objectAtIndex:2] integerValue] % 60;
            return @([[dataArr objectAtIndex:1] integerValue]);
        }else{
            return @(60);
        }
        
    }];
    
  RAC(self.view, hidden) = [RACObserve(self.recipeSelectView.selectButton, selected)map:^id _Nullable(id  _Nullable value) {
      @strongify(self)
        if ([value boolValue]) {
            
            if (self.temperatureSelectView.selectButton.selected) {
                [self.temperatureSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            if (self.timeSelectView.selectButton.selected) {
                [self.timeSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        return @NO;
    }];
  RAC(self.view, hidden) =  [RACObserve(self.temperatureSelectView.selectButton, selected)map:^id _Nullable(id  _Nullable value) {
      @strongify(self)
        if ([value boolValue]) {
            
            if (self.recipeSelectView.selectButton.selected) {
                [self.recipeSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            if (self.timeSelectView.selectButton.selected) {
                [self.timeSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        return @NO;
    }];
  RAC(self.view, hidden) =   [RACObserve(self.timeSelectView.selectButton, selected)map:^id _Nullable(id  _Nullable value) {
      @strongify(self)
        if ([value boolValue]) {
            
            if (self.temperatureSelectView.selectButton.selected) {
                [self.temperatureSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            if (self.recipeSelectView.selectButton.selected) {
                [self.recipeSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        return @NO;
    }];
    
    RAC(self.navigationItem.rightBarButtonItems[1],enabled) = [RACObserve(self.recipeSelectView,foodTag)map:^id _Nullable(NSNumber*  _Nullable value) {
        @strongify(self)
        if ([value integerValue]) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    RAC(self.navigationItem.rightBarButtonItems[1],enabled) = [RACObserve(self.timeSelectView,hour)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue]&& self.recipeSelectView.foodTag) {
            
            return @YES;
        }else{
            if (self.timeSelectView.min&& self.recipeSelectView.foodTag) {
                return @YES;
            }else{
                return @NO;
            }
            
        }
    }];
    RAC(self.navigationItem.rightBarButtonItems[1],enabled) = [RACObserve(self.timeSelectView,min)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] && self.recipeSelectView.foodTag) {
            
            return @YES;
        }else{
            if (self.timeSelectView.hour&& self.recipeSelectView.foodTag) {
                return @YES;
            }else{
                return @NO;
            }
            
        }
    }];

    
}
- (BOOL)isInteractivePop {
    return YES;
}
#pragma mark -Action

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)startAction:(id)sender{
    
    NSInteger showMode = self.recipeSelectView.foodTag;
    NSInteger workMode = 0;
    NSInteger temp = self.temperatureSelectView.selectTemp;
    NSInteger cookTime = self.timeSelectView.hour * 60 + self.timeSelectView.min;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(showMode),@"displayMode",
                         @(0),@"workMode",
                         @(temp),@"setTemp",
                         @(cookTime),@"setWorkTime"
                         , nil];
    if (self.startHeating) {
        self.startHeating (dic, self.recipeSelectView.selectLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button sizeToFit];
    UIBarButtonItem *moreItm = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -7;
    
    self.navigationItem.rightBarButtonItems =@[spaceItem, moreItm];
    
    [self setTitle:@"食谱"];
}
@end
