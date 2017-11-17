//
//  TBNavigationController.h
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TBNavigationControllerDelegate;
@interface TBNavigationController : UINavigationController <UINavigationControllerDelegate>

@property (nullable, nonatomic, weak) id<TBNavigationControllerDelegate> navigationDelegate;

@end

@protocol TBNavigationControllerDelegate <UINavigationControllerDelegate>

@end
NS_ASSUME_NONNULL_END
