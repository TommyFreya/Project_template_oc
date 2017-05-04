//
//  UINavigationBar+StyleConfigure.m
//  FeiDan
//
//  Created by Tommy on 2017/3/23.
//  Copyright © 2017年 TianJiMoney. All rights reserved.
//

#import "UINavigationBar+StyleConfigure.h"
#import "UIColor+Image.h"

@implementation UINavigationBar (StyleConfigure)

/**
 基本样式
 导航栏背景是main_00，标题是origin_00，导航栏底部没有阴影，没有横线
 */
- (void)setupStyleBasic {
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:TY_THEME.origin_color_00};
    [self setupStyleWithTitleTextAttributes:titleTextAttributes
                               barTintColor:TY_THEME.main_color_00
                                  tintColor:TY_THEME.origin_color_00
                                  lineColor:[UIColor clearColor]
                                shadowColor:[UIColor clearColor]];
}

- (void)setupStyleBasicWhiteWithLineColor:(UIColor *)lineColor {
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:TY_THEME.main_color_10};
    [self setupStyleWithTitleTextAttributes:titleTextAttributes
                               barTintColor:TY_THEME.origin_color_00
                                  tintColor:TY_THEME.main_color_10
                                  lineColor:lineColor
                                shadowColor:nil];
}

- (void)setupStyleWithBarTintColor:(UIColor *)barTintColor
                        titleColor:(UIColor *)titleColor
                         tintColor:(UIColor *)tintColor {
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
    [self setupStyleWithTitleTextAttributes:titleTextAttributes
                               barTintColor:barTintColor
                                  tintColor:tintColor
                                  lineColor:nil
                                shadowColor:nil];
}

/**
 自定义导航栏背景色+标题文字颜色
 默认 导航栏底部没有阴影，没有黑线
 @param barTintColor 导航栏背景色
 */
- (void)setupStyleWithBarTintColor:(UIColor *)barTintColor titleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
    [self setupStyleWithTitleTextAttributes:titleTextAttributes
                               barTintColor:barTintColor
                                  tintColor:TY_THEME.origin_color_00
                                  lineColor:nil
                                shadowColor:nil];
}


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
                              shadowColor:(UIColor *)shadowColor {
    // 导航栏标题颜色
    self.titleTextAttributes = titleTextAttributes;
    // 导航栏背景颜色
    self.barTintColor = barTintColor;
    // 左右item颜色
    self.tintColor = tintColor;
    // 透明度
    self.translucent = NO;
    
    lineColor ? [self setBottomLineColor:lineColor] : [self clearBottomLine];
    shadowColor ? [self setShadowColor:shadowColor] : [self clearShadow];
}

#pragma mark - 一起设置的方法
/**
 设置导航栏底部横线的颜色以及导航栏底部阴影的颜色
 
 @param lineColor 底部横线的颜色  nil=不显示横线
 @param shadowColor 底部阴影的颜色 nil=不显示阴影
 */
- (void)showBottomLine:(UIColor *)lineColor
           shadowColor:(UIColor *)shadowColor {
    
    [self setBottomLineColor:lineColor];
    [self setShadowColor:shadowColor];
}


/**
 清除导航栏底部横线，同时取消阴影
 */
- (void)clearBottomLineAndShadow {
    [self clearBottomLine];
    [self clearShadow];
}


#pragma mark - 单独设置的一些方法
/**
 设置导航栏底部横线颜色
 
 @param color 横线颜色
 */
- (void)setBottomLineColor:(UIColor *)color{
    
    [self setBackgroundImage:[[UIImage alloc] init]
              forBarPosition:UIBarPositionAny
                  barMetrics:UIBarMetricsDefault];
    [self setShadowImage:[color toImageWithSize:CGSizeMake(1.f, 0.5f)]];
    
}

/**
 设置导航栏底部阴影颜色
 
 @param color 阴影颜色
 */
- (void)setShadowColor:(UIColor *)color {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = 6.f;
    self.layer.shadowOffset = CGSizeMake(0.f, 0.5f);
    self.layer.shadowOpacity = 0.12f;
}


#pragma mark - clear清除的一些方法
/**
 清除导航栏底部横线
 */
- (void)clearBottomLine {
    [self setBackgroundImage:[[UIColor clearColor] toImage]
              forBarPosition:UIBarPositionAny
                  barMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
}


/**
 清除导航栏底部阴影
 */
- (void)clearShadow {
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowRadius = 0.f;
    self.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    self.layer.shadowOpacity = 1.f;
}

@end
