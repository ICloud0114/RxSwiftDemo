//
//  ICTemperatureSelectView.h
//  Humidifier
//
//  Created by 郑云 on 16/9/13.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICTemperatureSelectView : UIView

@property (nonatomic, assign) NSInteger selectTemp;
@property (nonatomic, weak) IBOutlet UIButton *selectButton;

@property (nonatomic, assign) NSInteger lowTemp;
@end
