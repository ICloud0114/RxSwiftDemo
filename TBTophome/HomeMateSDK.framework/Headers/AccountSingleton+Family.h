//
//  AccountSingleton+Family.h
//  HomeMateSDK
//
//  Created by Air on 17/2/14.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "AccountSingleton.h"

@interface AccountSingleton (Family)

-(void)switchToFamily:(NSString *)familyId completion:(commonBlock)completion;

-(void)readWiFiDeviceDataInFamily:(NSString *)familyId completion:(commonBlock)completion;

@end
