//
//  TextField.h
//  Template
//
//  Created by Topband on 2016/12/19.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextField : UITextField

@property (assign, nonatomic) IBInspectable CGFloat textLeading;
@property (assign, nonatomic) IBInspectable CGFloat textTrailing;
@property (assign, nonatomic) IBInspectable BOOL rightViewAutoResize; //右视图是否自适应大小

@end
