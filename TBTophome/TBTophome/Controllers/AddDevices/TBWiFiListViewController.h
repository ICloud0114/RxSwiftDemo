//
//  TBWiFiListViewController.h
//  TBTophome
//
//  Created by Topband on 2017/1/6.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TBWiFiListViewControllerDelegate;
@interface TBWiFiListViewController : TBBaseViewController

+ (instancetype)instanceWiFiListViewController:(id<TBWiFiListViewControllerDelegate>)delegate
                                  selectedSSID:(nullable NSString *)ssid;

@property (nonatomic, weak) id<TBWiFiListViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *selectedSSID; //当前选中的SSID

@end

@protocol TBWiFiListViewControllerDelegate <NSObject>

- (void)didSelectedWiFi:(HMAPWifiInfo *)wifi;

@end
NS_ASSUME_NONNULL_END
