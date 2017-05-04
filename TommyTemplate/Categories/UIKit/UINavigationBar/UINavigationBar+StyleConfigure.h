//
//  UINavigationBar+StyleConfigure.h
//  FeiDan
//
//  Created by Tommy on 2017/3/23.
//  Copyright © 2017年 TianJiMoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (StyleConfigure)

/**
 基本样式 A
 导航栏背景是main_00，标题是origin_00，导航栏底部没有阴影，没有横线
 */
- (void)setupStyleBasic;
/**
 基本样式 B
 导航栏背景是origin_00，标题是main_10，导航栏底部没有阴影，有横线weak_13或者没有横线
 */
- (void)setupStyleBasicWhiteWithLineColor:(UIColor *)lineColor;

/**
 自定义 导航栏背景色 + 标题文字颜色
 默认 导航栏底部没有阴影，没有黑线
 @param barTintColor 导航栏背景色
 */
- (void)setupStyleWithBarTintColor:(UIColor *)barTintColor titleColor:(UIColor *)titleColor;


/**
  自定义 导航栏背景色 + 标题文字颜色 + item颜色
  默认 导航栏底部没有阴影，没有黑线
 @param barTintColor 导航栏背景色
 @param titleColor 标题颜色
 @param tintColor item颜色
 */
- (void)setupStyleWithBarTintColor:(UIColor *)barTintColor
                        titleColor:(UIColor *)titleColor
                         tintColor:(UIColor *)tintColor;

/**
 自定义导航栏相关设置
 
 @param titleTextAttributes 导航栏文字的颜色
 @param barTintColor 导航栏背景颜色
 @param tintColor 导航栏左右item的颜色
 @param lineColor 导航栏底部横线的颜色, nil表示没有横线
 @param shadowColor 导航栏底部阴影颜色, nil表示没有阴影
 */
- (void)setupStyleWithTitleTextAttributes:(NSDictionary *)titleTextAttributes
                             barTintColor:(UIColor *)barTintColor
                                tintColor:(UIColor *)tintColor
                                lineColor:(UIColor *)lineColor
                              shadowColor:(UIColor *)shadowColor;


/**
 设置导航栏底部横线的颜色以及导航栏底部阴影的颜色
 
 @param lineColor 底部横线的颜色  nil=不显示横线
 @param shadowColor 底部阴影的颜色 nil=不显示阴影
 */
- (void)showBottomLine:(UIColor *)lineColor
           shadowColor:(UIColor *)shadowColor;

/**
 清除导航栏底部横线，同时取消阴影
 */
- (void)clearBottomLineAndShadow;


/**
 设置导航栏底部横线颜色
 
 @param color 横线颜色
 */
- (void)setBottomLineColor:(UIColor *)color;

/**
 设置导航栏底部阴影颜色
 
 @param color 阴影颜色
 */
- (void)setShadowColor:(UIColor *)color;


/**
 清除导航栏底部横线
 */
- (void)clearBottomLine;

/**
 清除导航栏底部阴影
 */
- (void)clearShadow;

@end
