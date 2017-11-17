//
//  ICRecipeSelectView.h
//  Humidifier
//
//  Created by 郑云 on 16/9/20.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICModelListView.h"

@interface ICRecipeSelectView : UIView

@property (nonatomic, weak) IBOutlet UIButton *selectButton;

@property (nonatomic, weak) IBOutlet ICModelListView *meatListView;

@property (nonatomic, weak) IBOutlet ICModelListView *pastryListView;

@property (nonatomic, weak) IBOutlet ICModelListView *vegetablesListView;
@property (nonatomic, weak) IBOutlet UILabel *selectLabel;
@property (nonatomic, assign) NSInteger foodTag;

@end
