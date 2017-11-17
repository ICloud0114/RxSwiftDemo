//
//  TBDeviceNavigationBar.h
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBDeviceNavigationBar : UIView

+ (instancetype)deviceNavigationBar;

@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *more;
@end
NS_ASSUME_NONNULL_END
