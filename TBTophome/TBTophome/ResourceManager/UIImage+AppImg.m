//
//  UIImage+AppImg.m
//  TBTophome
//
//  Created by Topband on 2016/12/29.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "UIImage+AppImg.h"

@implementation UIImage (AppImg)

+ (UIImage *)navigationBarImage {
    UIImage *image = [UIImage imageNamed:@"nav.png"];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)navigationBackNormalImage {
    return [[UIImage imageNamed:@"back.png"]
            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)navigationAddNormalImage {
    return [[UIImage imageNamed:@"add.png"]
            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)airPurifierDeviceIconImage {
    return [UIImage imageNamed:@"icon_aircleaner.png"];
}

+ (UIImage *)airPurifierDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_aircleaner_close.png"];
}

+ (UIImage *)heaterDeviceIconImage {
    return [UIImage imageNamed:@"icon_heater.png"];
}

+ (UIImage *)heaterDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_heater_close.png"];
}

+ (UIImage *)ledDeviceIconImage {
    return [UIImage imageNamed:@"icon_led.png"];
}

+ (UIImage *)ledDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_led_close.png"];
}

+ (UIImage *)humidifierDeviceIconImage {
    return [UIImage imageNamed:@"icon_humidifier.png"];
}

+ (UIImage *)humidifierDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_humidifier_close.png"];
}

+ (UIImage *)waterPurifierIconImage {
    return [UIImage imageNamed:@"icon_waterpurifier.png"];
}

+ (UIImage *)waterPurifierOffIconImage {
    return [UIImage imageNamed:@"icon_waterpurifier_close.png"];
}

+ (UIImage *)riceCookerIconImage {
    return [UIImage imageNamed:@"icon_cooker.png"];
}

+ (UIImage *)riceCookerOffIconImage {
    return [UIImage imageNamed:@"icon_cooker_close.png"];
}

+ (UIImage *)waterPurifierMadeImage {
    return [UIImage imageNamed:@"info_made.png"];
}

+ (UIImage *)waterPurifierWashImage {
    return [UIImage imageNamed:@"info_wash.png"];
}

+ (UIImage *)coffeeDeviceIconImage {
    return [UIImage imageNamed:@"icon_coffee.png"];
}

+ (UIImage *)coffeeDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_coffee_close.png"];
}

+ (UIImage *)ovenDeviceIconImage {
    return [UIImage imageNamed:@"icon_oven.png"];
}

+ (UIImage *)ovenDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_oven_close.png"];
}

+ (UIImage *)inductionCookingIconImage {
    return [UIImage imageNamed:@"icon_hotplate.png"];
}

+ (UIImage *)inductionCookingOffIconImage {
    return [UIImage imageNamed:@"icon_hotplate_close.png"];
}

+ (UIImage *)moreIconImage {
    return [UIImage imageNamed:@"more.png"];
}

+ (UIImage *)toiletDeviceIconImage {
    return [UIImage imageNamed:@"icon_tolit.png"];
}

+ (UIImage *)toiletDeviceOffIconImage {
    return [UIImage imageNamed:@"icon_tolit_close.png"];
}
    
+ (UIImage *)cookingMachineIconImage {
    return [UIImage imageNamed:@"icon_blender.png"];
}

+ (UIImage *)cookingMachineOffIconImage {
    return [UIImage imageNamed:@"icon_blender_close.png"];
}

+ (UIImage *)dishwasherIconImage {
    return [UIImage imageNamed:@"icon_dishwasher.png"];
}

+ (UIImage *)dishwasherOffIconImage {
    return [UIImage imageNamed:@"icon_dishwasher_close.png"];
}
    
+ (UIImage *)xiaofangIconImage {
    return [UIImage imageNamed:@"icon_box.png"];
}
    
+ (UIImage *)xiaofangOffIconImage {
    return [UIImage imageNamed:@"icon_box_close.png"];
}

+ (UIImage *)aricIconImage {
    return [UIImage imageNamed:@"icon_conditioner_1.png"];
}

+ (UIImage *)aricOffIconImage {
    return [UIImage imageNamed:@"icon_conditioner_1_close.png"];
}

+ (UIImage *)aricCIconImage {
    return [UIImage imageNamed:@"icon_conditioner_2.png"];
}

+ (UIImage *)aricCOffIconImage {
    return [UIImage imageNamed:@"icon_conditioner_2_close.png"];
}
@end
