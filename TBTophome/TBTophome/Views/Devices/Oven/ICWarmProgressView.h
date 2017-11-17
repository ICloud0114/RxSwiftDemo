//
//  ICWarmProgressView.h
//  TBTophome
//
//  Created by zhengyun on 2017/2/22.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICWarmProgressView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *loadingImageView;
- (void)startLoading;
- (void)endLoading;
@end
