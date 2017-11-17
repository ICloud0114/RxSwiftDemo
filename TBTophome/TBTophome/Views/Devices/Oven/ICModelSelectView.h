//
//  ICModelSelectView.h
//  Humidifier
//
//  Created by 郑云 on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICModelListView.h"

@interface ICModelSelectView : UIView

@property (nonatomic, weak) IBOutlet ICModelListView *modelListView;
@property (nonatomic, weak) IBOutlet UILabel *selectLabel;
@property (nonatomic, weak) IBOutlet UIButton *selectButton;
@end
