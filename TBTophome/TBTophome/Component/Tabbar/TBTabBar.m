//
//  TBTabBar.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBTabBar.h"
#import "UIColor+Ex.h"

@implementation TBTabBar

+ (instancetype)tabbar {
    UINib *nib = [UINib nibWithNibName:@"TBTabBar" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#828282"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#61c23e"]} forState:UIControlStateSelected];
    
    self.tintColor = [UIColor colorWithHexString:@"#61c23e"];
    NSArray *itemIcon = @[@{@"normal": @"tab_device.png",
                            @"selected": @"tab_device_h.png"},
//                          @{@"normal": @"tab_mall.png",
//                            @"selected": @"tab_mall_h.png"},
                          @{@"normal": @"tab_personal.png",
                            @"selected": @"tab_personal_h.png"}];
    for (NSInteger index = 0; index < self.items.count; ++index) {
        UITabBarItem *barItem = self.items[index];
        NSDictionary *dic = itemIcon[index];
        
        [barItem setImage:[UIImage imageNamed:[dic objectForKey:@"normal"]]];
        [barItem setSelectedImage:[[UIImage imageNamed:[dic objectForKey:@"selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}
@end

