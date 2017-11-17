//
//  ICNormalCleanView.h
//  Humidifier
//
//  Created by zhengyun on 16/9/22.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface ICNormalCleanView : UIView

+ (ICNormalCleanView *)shareNormalCleanView;


+ (ICNormalCleanView *)shareFemaleCleanView;


//@property (nonatomic, copy) void (^selectImageType)(ICNormalCleanView *sender, NSInteger index);


@property (nonatomic, copy) void (^dismissComplete)();

@property (nonatomic, copy) void (^changeTemperature)(NSInteger index);

@property (nonatomic, copy) void (^changeSPA)(NSInteger temperature, NSInteger presure);

@property (nonatomic, copy) void (^changePressure)(NSInteger index);
@property (nonatomic, copy) void (^changePosition)(NSInteger index);
@property (nonatomic, copy) void (^changeTime)(NSInteger index);
- (void)showInView:(UIView *)view;
- (void)showProgressWithTemperature:(NSInteger )temp pressure:(NSInteger )pressure position:(NSInteger )position andTime:(NSInteger )time;

- (void)dismiss;
@end
NS_ASSUME_NONNULL_END
