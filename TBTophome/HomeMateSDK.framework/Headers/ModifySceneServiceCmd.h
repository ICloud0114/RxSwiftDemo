//
//  ModifySceneServiceCmd.h
//  HomeMateSDK
//
//  Created by orvibo on 2017/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifySceneServiceCmd : BaseCmd

@property (nonatomic, retain)NSString * sceneNo;

@property (nonatomic, retain)NSString * sceneName;

@property (nonatomic, assign)int pic;

@end
