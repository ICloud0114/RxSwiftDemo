//
//  QrCodeModel.h
//  HomeMate
//
//  Created by liuzhicai on 16/1/13.
//  Copyright © 2016年 Air. All rights reserved.
//

@interface HMQrCodeModel : HMBaseModel

@property (nonatomic, copy)NSString *qrCodeId;

@property (nonatomic, assign)int qrCodeNo;

// 添加入口类型
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *picUrl;

+ (instancetype)objectwithQrCode:(NSString *)qrCodeNo;

+ (instancetype)objectFromDictionary:(NSDictionary *)dict;

- (BOOL)insertObject;


@end
