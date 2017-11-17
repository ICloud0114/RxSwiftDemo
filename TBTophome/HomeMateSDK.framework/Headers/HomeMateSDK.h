//
//  HomeMateSDK.h
//  HomeMateSDK
//
//  Created by Air on 16/9/22.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#ifndef HomeMateSDK_h
#define HomeMateSDK_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "HMUtil.h"
#import "HMApUtil.h"
#import "HMTypes.h"
#import "HMProtocol.h"
#import "HMNotifications.h"
#import "CmdModel.h"
#import "SingletonClass.h"
#import "HMConstant.h"
#import "AccountSingleton+RT.h"
#import "AccountSingleton+Bind.h"
#import "AccountSingleton+Family.h"
#import "LogMacro.h"
#import "HMAPWifiInfo.h"
#import "NSObject+Save.h"
#import "NSObject+Observer.h"
#import "NSObject+Foreground.h"
#import "UIButton+EnlargeEdge.h"
#import "NSData+AES.h"
#import "getgateway.h"
#import "HMDeviceConfig.h"
#import "HMAPGetIp.h"
#import "HMProductModel.h"
#import "HMNetworkMonitor.h"
#import "HMZigbeeConfig.h"
#import "HMDatabaseManager.h"
#import "RunTimeLanguage.h"
#import "BLUtility.h"
#import "HMCoreManagerByMacroDefinition.h"
#import "HMProductModel.h"
#import "Gateway+RT.h"
#import "Gateway+Login.h"
#import "Gateway+Foreground.h"
#import "RemoteGateway+RT.h"

#import "HMAppFactoryConfig.h"

#import "HMAirConditionUtil.h"
#import "HMVRVAirConditionUtil.h"
#import "SearchMdns+FindGateway.h"

#import "HMSDK.h"
#import "HMAPDeleteDeviceProtocol.h"

#import "HMAPI.h"


#ifdef NSLocalizedString
#undef NSLocalizedString

#define NSLocalizedString(key, comment) \
[[RunTimeLanguage shareInstance] runTimeLocalizedStringForKey:(key) value:@"" table:nil]

#endif

#endif /* HomeMateSDK_h */
