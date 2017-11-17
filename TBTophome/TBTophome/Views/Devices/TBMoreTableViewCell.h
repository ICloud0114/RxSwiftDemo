//
//  TBMoreTableViewCell.h
//  TBTophome
//
//  Created by Topband on 2017/2/13.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TBMoreTableViewCellDelegate;
@interface TBMoreTableViewCell : UITableViewCell

@property (weak, nonatomic) id<TBMoreTableViewCellDelegate> delegate;

@end

@protocol TBMoreTableViewCellDelegate <NSObject>

- (void)didModifyName;
- (void)didUpgrade;

@end
NS_ASSUME_NONNULL_END
