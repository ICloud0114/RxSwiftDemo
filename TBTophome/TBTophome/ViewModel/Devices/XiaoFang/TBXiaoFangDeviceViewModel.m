//
//  TBXiaoFangDeviceViewModel.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBXiaoFangDeviceViewModel.h"

@implementation TBXiaoFangDeviceViewModel

#pragma mark - overwrite
- (void)deviceReportedData:(NSDictionary *)payload cmd:(NSInteger)cmd {
    //    TBLog(@"cmd: %d", cmd)
    //    TBLog(@"payload: %@", payload)
}
    
- (UIImage *)deviceIcon {
    return UIImage.xiaofangIconImage;
}
    
- (UIImage *)deviceOffIcon {
    return UIImage.xiaofangOffIconImage;
}
    
- (Class)viewControllerClass {
    return NSClassFromString(@"TBXiaoFangViewController");
}
    
@end
