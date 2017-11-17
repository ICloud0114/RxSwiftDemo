//
//  LFTableViewDataSource.h
//  Route
//
//  Created by 胡小宝 on 14-12-26.
//  Copyright (c) 2014年 胡小宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LFTableViewDataSource<ItemType> : NSObject <UITableViewDataSource>

@property (nonatomic, copy) NSString *cellIndentifier;

@property (nonatomic, copy) NSArray<ItemType> *dataSource;

@property (nonatomic, copy) NSString *(^multiCellIdentifier)(NSIndexPath *);

@property (nonatomic, copy) void (^cellConfig)(__kindof UITableViewCell *cell, ItemType data, NSIndexPath *indexPath);

@property (nonatomic, copy) BOOL (^canEditRow)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^commitEditing)(__kindof UITableViewCell *cell, ItemType data, UITableViewCellEditingStyle style);

- (ItemType)dataForIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)itemsForIndexPaths:(NSArray *)indexPaths;

- (void)removeDataAtIndexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
