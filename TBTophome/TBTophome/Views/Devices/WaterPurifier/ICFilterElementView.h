//
//  ICFilterElementView.h
//  Humidifier
//
//  Created by zhengyun on 16/8/31.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICFilterElementView : UIView

@property (nonatomic, weak) IBOutlet UIButton *selectButton;

- (void)showFilterDamagePercent:(NSInteger )percent;

- (void)changeFilterImageState:(BOOL) isNormal;

@end
