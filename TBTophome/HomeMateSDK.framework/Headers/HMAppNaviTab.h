//
//  HMAppNaviTab.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/4/28.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMAppNaviTab : HMBaseModel


@property (nonatomic, strong) NSString *naviTabId;
@property (nonatomic, strong) NSString *factoryId;
@property (nonatomic, assign) int sequence;
@property (nonatomic, assign) int verCode;
@property (nonatomic, strong) NSString *defaultIconUrl;
@property (nonatomic, strong) NSString *selectedIconUrl;
@property (nonatomic, strong) NSString *defaultFontColor;
@property (nonatomic, strong) NSString *selectedFontColor;
@property (nonatomic, strong) NSString *viewId;




@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *defaultIcon;
@property (nonatomic, strong) NSString *selectedIcon;

@end
