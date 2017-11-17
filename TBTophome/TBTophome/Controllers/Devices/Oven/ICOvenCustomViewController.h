//
//  ICOvenCustomViewController.h
//  Humidifier
//
//  Created by zhengyun on 16/9/23.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBBaseViewController.h"
@interface ICOvenCustomViewController : TBBaseViewController

@property (nonatomic, copy) void (^startHeating)(NSDictionary *data, NSString *foodType);

@end
