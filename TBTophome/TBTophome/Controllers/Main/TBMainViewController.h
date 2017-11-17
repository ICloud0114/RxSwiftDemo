//
//  TBMainViewController.h
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBDeviceListViewController.h"
#import "TBMallViewController.h"
#import "TBPersonalCenterViewController.h"
#import "TBModule4ViewController.h"
#import "TBTabBar.h"

NS_ASSUME_NONNULL_BEGIN
@interface TBMainViewController : UITabBarController

@property (nonatomic, readonly, strong) TBTabBar *tbTabbar;

@end
NS_ASSUME_NONNULL_END
