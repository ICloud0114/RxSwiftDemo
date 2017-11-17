//
//  TBRemoteView.h
//  TBTophome
//
//  Created by Topband on 2017/3/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RemotePanelType) {
    RemoteWallAirType = 0,
    RemoteCabinetAirType = 1
};

@protocol TBRemoteToolBarView;
@protocol TBRemoteView <NSObject>

+ (instancetype)RemoteViewPanelType:(RemotePanelType)type;

@property (nonatomic, weak) id<TBRemoteToolBarView> toolBarDelegate;

- (void)showToolBar;

- (void)hideToolBar;

@property (nonatomic, readonly) UIButton *leftBt;
@property (nonatomic, readonly) UILabel *leftTitle;
@property (nonatomic, readonly) UIButton *rightBt;
@property (nonatomic, readonly) UILabel *rightTitle;
@property (nonatomic, readonly) UIButton *okBt;

@property (assign, nonatomic, readonly) RemotePanelType panelType;

@end

@protocol TBRemoteToolBarView <NSObject>
@required
- (void)didShow;

@end
