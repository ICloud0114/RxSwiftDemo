//
//  ICTimeSelectView.h
//  Humidifier
//
//  Created by 郑云 on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICTimeSelectView : UIView

@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, weak) IBOutlet UIButton *selectButton;

@end
