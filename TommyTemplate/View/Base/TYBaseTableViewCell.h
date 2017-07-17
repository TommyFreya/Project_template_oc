//
//  TYBaseTableViewCell.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYTableViewCellDelegate <NSObject>

@optional

// 注册并创建 cell
+ (instancetype)ty_makeCellForAllocTableView:(UITableView *)tableView;

// 注册并创建 xib cell
+ (instancetype)ty_makeCellForNibTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

// 数据绑定赋值
- (void)ty_bindDataToCellWithValue:(id)value;
- (void)ty_bindDataToCellWithValue:(id)value indexPath:(NSIndexPath *)indexPath;

// 解决 tableView cell 的分割线左边不到头的问题
- (void)ty_separatorInsetZero;

@end

@interface TYBaseTableViewCell : UITableViewCell <TYTableViewCellDelegate>

@end
