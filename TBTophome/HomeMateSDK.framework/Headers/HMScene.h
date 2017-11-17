//
//  VihomeScene.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMScene : HMBaseModel

@property (nonatomic, retain)NSString *             sceneNo;

@property (nonatomic, retain)NSString *             sceneName;

@property (nonatomic, retain)NSString *             roomId;

@property (nonatomic, assign)int                    onOffFlag;

@property (nonatomic, assign)int                    sceneId;

@property (nonatomic, assign)int                    groupId;

@property (nonatomic ,assign)int                    pic;

@property (nonatomic, strong) NSString *             userId;    ///< wifi情景 新增字段

@property (nonatomic, assign,readonly)BOOL      changed;        ///< 判断当前情景的名称和图标是否发生变化
@property (nonatomic, retain)NSString *         initialName;
@property (nonatomic, assign)int                initialPic;
@property (nonatomic, assign)BOOL               createSuccess;  ///< 只在创建情景时使用，标记添加情景时，情景是否添加成功


/**
 获取所有情景数组

 @return 根据当前设备数查询的情景数组
 */
+ (NSArray *)allScenesArr;

+ (HMScene *)readSceneWithSceneNo:(NSString *)sceneNo;

/**
 情景对应的图片名称
 */
- (NSString *)picName;

@end
