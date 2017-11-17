//
//  RemoteGateway+WiFi.h
//  HomeMate
//
//  Created by Air on 16/7/25.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "RemoteGateway.h"

@interface RemoteGateway (WiFi)

- (void)readAllWifiDataWithFamilyId:(NSString *)familyId completion:(commonBlock)completion;
- (void)didReceiveWifiTableData:(NSDictionary *)dic;

@end
