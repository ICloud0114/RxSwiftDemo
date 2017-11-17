//
//  ICOvenSetWarmUpController.m
//  SmartHomeSystem
//
//  Created by 张雷 on 16/9/29.
//  Copyright © 2016年 topband. All rights reserved.
//

#import "ICOvenSetWarmUpController.h"
#import "UIColor+Ex.h"
@interface ICOvenSetWarmUpController() <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *temoPickerView;
@property (nonatomic, strong) NSMutableArray *temperatureArr;

@property (nonatomic, assign) NSInteger selectTemp;
@end

@implementation ICOvenSetWarmUpController

- (void)dealloc{
    TBLog(@"销毁毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tempLabel.text = @"150 ˚C";
    self.selectTemp = 150;
    // Do any additional setup after loading the view.
    
    [self.temoPickerView selectRow:0 inComponent:0 animated:NO];
    [self setupUI];
}

- (void)setupUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(startWarmAction:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self setTitle:@"预热"];
}
#pragma mark - overwrite
- (BOOL)isInteractivePop {
    return YES;
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
    if (!component) {
        return 101;
    }
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (!component) {
        return self.temperatureArr[row];
    }else{
        return @"˚C";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(!component){
        self.selectTemp = row + 150;
        self.tempLabel.text = [NSString stringWithFormat:@"%@ ˚C",self.temperatureArr[row] ];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (!component) {
        return 55;
    }else{
        return 40;
    }
}

- (NSMutableArray *)temperatureArr
{
    if (!_temperatureArr) {
        _temperatureArr = @[].mutableCopy;
        for (NSInteger tem = 150; tem <= 250; ++ tem) {
//            NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",tem]];
//            [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",tem] length])];
//            [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#282828"] range:NSMakeRange(0, [[NSString stringWithFormat:@"%ld",tem] length])];
//            
//            [_temperatureArr addObject:attributeStr];
            NSString *str = [NSString stringWithFormat:@"%ld",tem];
            [_temperatureArr addObject:str];
        }
    }
    return _temperatureArr;
}


- (IBAction)startWarmAction:(id)sender {
    
    
    if (self.startWarm) {
        self.startWarm(self.selectTemp);
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
