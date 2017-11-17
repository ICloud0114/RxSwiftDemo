//
//  TBDeviceViewController.h
//  TBTophome
//
//  Created by Topband on 2016/12/30.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBBaseViewController.h"
#import "TBDeviceViewModel.h"

//此类应视为抽象类，不应直接使用
NS_ASSUME_NONNULL_BEGIN
@interface TBDeviceViewController<DeviceType: TBDeviceViewModel *> : TBBaseViewController

+ (instancetype)deviceViewController;

@property (nonatomic, strong) DeviceType device;

@property (nullable, nonatomic, weak) IBOutlet UIView *overlay;

@property (nonatomic, assign) BOOL hideOverlay;

@end
NS_ASSUME_NONNULL_END
