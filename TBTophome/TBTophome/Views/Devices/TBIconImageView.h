//
//  TBIconImageView.h
//  TBTophome
//
//  Created by Topband on 2017/2/17.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TBIconState) {
    normalState = 0,
    selectedState,
    disabledState
};

NS_ASSUME_NONNULL_BEGIN
@interface TBIconImageView : UIImageView

@property (nonatomic, strong) IBInspectable UIImage *normalImage;
@property (nonatomic, strong) IBInspectable UIImage *selectedImage;
@property (nonatomic, strong) IBInspectable UIImage *disabledImage;

@property (nonatomic, assign) TBIconState state;
    
@end
NS_ASSUME_NONNULL_END
