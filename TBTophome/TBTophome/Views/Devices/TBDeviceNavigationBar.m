//
//  TBDeviceNavigationBar.m
//  TBTophome
//
//  Created by Topband on 2017/3/7.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBDeviceNavigationBar.h"

@implementation TBDeviceNavigationBar

+ (instancetype)deviceNavigationBar {
    UINib *nib = [UINib nibWithNibName:@"TBDeviceNavigationBar" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

@end
