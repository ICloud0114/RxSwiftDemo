//
//  ICOvenSetWarmUpController.h
//  SmartHomeSystem
//
//  Created by 张雷 on 16/9/29.
//  Copyright © 2016年 topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBBaseViewController.h"
@interface ICOvenSetWarmUpController : TBBaseViewController

@property (nonatomic, copy) void (^startWarm)(NSInteger temperature);
@end
