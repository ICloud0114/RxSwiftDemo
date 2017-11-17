//
//  ICOvenCustomViewController.m
//  Humidifier
//
//  Created by zhengyun on 16/9/23.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "ICOvenCustomViewController.h"
#import "ICModelSelectView.h"
#import "ICTemperatureSelectView.h"
#import "ICTimeSelectView.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface ICOvenCustomViewController ()

@property (weak, nonatomic) IBOutlet ICModelSelectView *modeSelectView;
@property (weak, nonatomic) IBOutlet ICTemperatureSelectView *temperatureSelectView;
@property (weak, nonatomic) IBOutlet ICTimeSelectView *timeSelectView;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@end

@implementation ICOvenCustomViewController
- (void)dealloc{
    TBLog(@"销毁毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.temperatureSelectView.selectTemp = 60;
    self.temperatureSelectView.lowTemp = 60;
    self.timeSelectView.hour = 0;
    self.timeSelectView.min = 0;
    
    @weakify(self)
    RAC(self.temperatureSelectView, selectTemp) = [RACObserve(self.modeSelectView.modelListView, selectBtn)map:^id _Nullable(UIButton*  _Nullable value) {
        @strongify(self)
        if (value) {
            NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"OvenDisplayMode" ofType:@"plist"];
            
            NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:dataSourcePath];
            
            NSArray *dataArr = [data objectForKey:[NSString stringWithFormat:@"%ld",value.tag]];
            if (value.tag == 10) {
                self.temperatureSelectView.layer.opacity = 0.6;
                self.temperatureSelectView.userInteractionEnabled = NO;
            }else{
                 self.temperatureSelectView.userInteractionEnabled = YES;
                self.temperatureSelectView.layer.opacity = 1;
            }
            self.timeSelectView.hour = 0;
            self.timeSelectView.min = 30;
            if ([[dataArr objectAtIndex:1] isEqualToString:@"--"]) {
                return @(0);
            }else{
               return @([[dataArr objectAtIndex:1] integerValue]);
            }
            
        }else{
            return @(60);
        }
        
    }];
    
    RAC(self.view, hidden) = [RACObserve(self.modeSelectView.selectButton, selected)map:^id _Nullable(id  _Nullable value) {
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
            
            if (self.modeSelectView.selectButton.selected) {
                [self.modeSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
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
            if (self.modeSelectView.selectButton.selected) {
                [self.modeSelectView.selectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        return @NO;
    }];
    
    RAC(self.navigationItem.rightBarButtonItems[1],enabled) = [RACObserve(self.modeSelectView.modelListView,selectBtn)map:^id _Nullable(UIButton *  _Nullable value) {
        @strongify(self)
        if (value) {
            
            return @YES;
        }else{
            return @NO;
        }
    }];
    
    RAC(self.navigationItem.rightBarButtonItems[1],enabled) = [RACObserve(self.timeSelectView,hour)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue]&& self.modeSelectView.modelListView.selectBtn) {
            
            return @YES;
        }else{
            if (self.timeSelectView.min&& self.modeSelectView.modelListView.selectBtn) {
                return @YES;
            }else{
                return @NO;
            }
            
        }
    }];
    RAC(self.navigationItem.rightBarButtonItems[1],enabled) = [RACObserve(self.timeSelectView,min)map:^id _Nullable(NSNumber *  _Nullable value) {
        @strongify(self)
        if ([value integerValue] && self.modeSelectView.modelListView.selectBtn) {
            
            return @YES;
        }else{
            if (self.timeSelectView.hour&& self.modeSelectView.modelListView.selectBtn) {
                return @YES;
            }else{
                return @NO;
            }
            
        }
    }];
    
    
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
    [self setTitle:@"自定义"];
}
#pragma mark - overwrite
- (BOOL)isInteractivePop {
    return YES;
}

- (IBAction)startAction:(id)sender{
    
    NSInteger showMode = 0;
    
    NSInteger workMode = 0;
    
    if (self.modeSelectView.modelListView.selectBtn) {
        workMode = self.modeSelectView.modelListView.selectBtn.tag;
    }
    NSInteger temp = self.temperatureSelectView.selectTemp;
    NSInteger cookTime = self.timeSelectView.hour * 60 + self.timeSelectView.min;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(workMode),@"displayMode",
                         @(workMode),@"workMode",
                         @(temp),@"setTemp",
                         @(cookTime),@"setWorkTime"
                         , nil];
    if (self.startHeating) {
        self.startHeating (dic, self.modeSelectView.selectLabel.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
