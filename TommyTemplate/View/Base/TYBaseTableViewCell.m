//
//  TYBaseTableViewCell.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseTableViewCell.h"

@implementation TYBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)ty_separatorInsetZero {
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    [self setPreservesSuperviewLayoutMargins:NO];
}

+ (instancetype)ty_makeCellForAllocTableView:(UITableView *)tableView {
    
    TYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    }
    return cell;
}

+ (instancetype)ty_makeCellForNibTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    TYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(self.class)];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
