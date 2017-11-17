//
//  TBAddRemoteViewController.h
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBBaseViewController.h"
#import "TBRemoteView.h"
#import "TBAddRemotesTipView.h"

UIKIT_EXTERN NSString *const TBAddRemoteViewClassKey;
UIKIT_EXTERN NSString *const TBAddRemotePanelTypeKey;
UIKIT_EXTERN NSString *const TBAddRemotePanelTitleKey;

NS_ASSUME_NONNULL_BEGIN
@interface TBAddRemoteViewController<ViewType: UIView<TBRemoteView> *> : TBBaseViewController

//+ (instancetype)instanceRemoteViewControllerWithViewClass:(Class<TBRemoteView>)viewClass remoteTitle:(NSString *)title;
//info contain key: @"_TBAddRemoteViewClassKey", @"_TBAddRemotePanelTypeKey", @"_TBAddRemotePanelTitleKey"
+ (instancetype)instanceRemoteViewControllerWithInfo:(NSDictionary *)info;

@property (nonatomic) Class<TBRemoteView> viewClass;

@property (assign, nonatomic) RemotePanelType type;

@property (nonatomic, weak) ViewType remoteView;

@property (nonatomic, copy) NSString *remoteTitle;

@property (nonatomic, weak) TBAddRemotesTipView *tipView;
#pragma mark - 此类从写下列方法
- (NSInteger)ridCount; //返回rid总的数量
- (NSInteger)currentRidIndex; //返回当前使用的rid的下标
- (void)getAricModeWithRidIndex:(NSInteger)index;
- (void)saveRemote;
@end
NS_ASSUME_NONNULL_END
