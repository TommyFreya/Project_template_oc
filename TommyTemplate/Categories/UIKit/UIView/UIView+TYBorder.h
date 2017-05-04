//
//  UIView+TYBorder.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TYBorder)

/**
 给 View 某一个方向 添加 边框宽度和颜色
 
 @param insets 遵循 上-左-下-右
 @param color <#color description#>
 */
- (void)ty_addBorderWithEdgeInsets:(UIEdgeInsets)insets borderColor:(UIColor *)color;

@end
