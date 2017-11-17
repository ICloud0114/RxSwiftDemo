//
//  AddSceneBindServiceCmd.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import <HomeMateSDK/HomeMateSDK.h>

@interface AddSceneBindServiceCmd : BaseCmd

@property (nonatomic,copy) NSString *sceneNo;   ///< 情景编号
@property (nonatomic,strong) NSArray *sceneBindList;    ///< 情景绑定列表

@end
