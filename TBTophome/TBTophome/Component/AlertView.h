//
//  AlertView.h
//  TBTophome
//
//  Created by Topband on 2017/1/9.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertStyle) {
    MessageStyle = 0,
    TextFieldStyle = 1
};

NS_ASSUME_NONNULL_BEGIN
@protocol AlertViewDelegate;
@interface AlertView : UIControl

//+ (instancetype)alertTextFieldView;
+ (instancetype)alertView:(AlertStyle)style;

@property (weak, nonatomic) id<AlertViewDelegate> delegate;

//@property (nonatomic, copy) NSString *text;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;

@property (nonatomic, assign) NSInteger textMaxLength; //文字最大长度，默认16

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray<UIButton *> *actions;

- (void)showInView:(UIView *)view;
@end

@protocol AlertViewDelegate <NSObject>

- (void)alertView:(AlertView *)alert didClicked:(NSInteger)index;

@end
NS_ASSUME_NONNULL_END
