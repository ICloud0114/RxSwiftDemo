//
//  LFTableViewDataSource.m
//  Route
//
//  Created by 胡小宝 on 14-12-26.
//  Copyright (c) 2014年 胡小宝. All rights reserved.
//

#import "LFTableViewDataSource.h"

@implementation LFTableViewDataSource
@synthesize dataSource = _dataSource;

- (void)dealloc
{
    _cellConfig = nil;
    _commitEditing = nil;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)setDataSource:(NSArray *)dataSource
{
    if (_dataSource != dataSource)
    {
        _dataSource = dataSource;
    }
}

- (NSString *)cellIndentifier
{
    if (_cellIndentifier == nil)
    {
        _cellIndentifier = @"cell indentifier";
    }
    return _cellIndentifier;
}

- (id)dataForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil)
        return nil;
    return self.dataSource[indexPath.row];
}

- (NSArray *)itemsForIndexPaths:(NSArray *)indexPaths
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths)
    {
        [items addObject:[self.dataSource objectAtIndex:indexPath.row]];
    }
    return items;
}

- (void)removeDataAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *mAry = self.dataSource.mutableCopy;
    [mAry removeObjectAtIndex:indexPath.row];
    self.dataSource = mAry;
}

#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = nil;
    if (self.multiCellIdentifier) {
        cellIndentifier = self.multiCellIdentifier(indexPath);
    } else {
        cellIndentifier = self.cellIndentifier;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
//    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    if (SystemVersion() >= 8.f)
//    {
//        cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    if (self.cellConfig)
        self.cellConfig(cell, self.dataSource[indexPath.row], indexPath);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.canEditRow)
    {
        return self.canEditRow(indexPath);
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.commitEditing)
    {
        self.commitEditing([tableView cellForRowAtIndexPath:indexPath], self.dataSource[indexPath.row], editingStyle);
    }
}

@end
