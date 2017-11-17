//
//  ICModelListView.h
//  Humidifier
//
//  Created by zhengyun on 16/9/17.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICModelListView : UIView

@property (nonatomic, weak) UIButton *selectBtn;
- (void)displayModelListWithDataArray:(NSArray *)arr withCol:(NSInteger)col;

@end
