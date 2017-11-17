//
//  TBWiFiListTableViewCell.h
//  TBTophome
//
//  Created by Topband on 2017/1/6.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBWiFiListTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *ssid;
@property (nonatomic, weak) IBOutlet UIImageView *enc;
@property (nonatomic, weak) IBOutlet UIImageView *rssi;
@property (nonatomic, weak) IBOutlet UIImageView *selectedIcon;

@end
NS_ASSUME_NONNULL_END
