//
//  ICRecipiViewController.h
//  Humidifier
//
//  Created by 郑云 on 16/9/20.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBBaseViewController.h"

@interface ICRecipeViewController : TBBaseViewController

@property (nonatomic, copy) void (^startHeating)(NSDictionary *data, NSString *foodType);
@end
