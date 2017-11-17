//
//  HMFamily.h
//  HomeMateSDK
//
//  Created by user on 17/1/13.
//  Copyright © 2017年 orvibo. All rights reserved.
//
typedef  void(^GetLocalImage)(UIImage * image);


#import "HMBaseModel.h"

@interface HMFamily : HMBaseModel

//@property (nonatomic, copy) NSString *familyId; // 父类已定义
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) int showIndex;

+ (instancetype)familyWithId:(NSString *)familyId;

+ (NSMutableArray *)familysWithUserId:(NSString *)userId;
+ (NSMutableArray *)selectAllFamilyObject;
+(BOOL)updateFamilyName:(NSString *)familyName byFamilyId:(NSString *)familyId;
+ (NSString *)selectCurrentFamilyName;
+ (HMFamily *)selectDefaultFamily;
+ (void )loadPicFromDataBaseWithFamily:(HMFamily *)family callBack:(GetLocalImage)localImage;


@end
