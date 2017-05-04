//
//  TYThemeService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TY_THEME [TYThemeService sharedInstance]

//static const CGFloat weak_text_00 = 11.f;    // 辅助类、标签类，如日期时间、产品类型标签等
//static const CGFloat weak_text_01 = 12.f;    // 按钮内文字，标签内文字，注释类等
//static const CGFloat weak_text_02 = 13.f;    // 按钮内文字
//
//static const CGFloat normol_text_00 = 14.f;  // 普通文本、产品详情页收缩展开里的文本
//static const CGFloat normol_text_01 = 15.f;  // 普通文本 输入框title
//static const CGFloat normol_text_02 = 16.f;  // 普通文本
//
//static const CGFloat main_text_00 = 17.f;    // 消息卡片标题，新闻详情页文本，页面标题
//static const CGFloat main_text_01 = 18.f;    // 产品详情页产品标题等
//static const CGFloat main_text_02 = 20.f;    // 注册登录页面顶部栏标题等
//static const CGFloat main_text_03 = 24.f;    // 首页的产品标题、新闻详情页标题
//
//static const CGFloat origin_text_00 = 30.f;  // 用于突出的文字，如返佣比例等



@interface TYThemeService : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Color
// 用于对比强烈的颜色组合
- (UIColor *)origin_color_00; /**< ffffff */

// 纯黑色,不常用
- (UIColor *)origin_color_01; /**< 000000 */

// 用于一级.二级页面头部(产品详情页.注册登录类除外)-图标选中状态-需要醒目的文字.有链接或文字按钮,如净值,返佣比例等
- (UIColor *)main_color_00; /**< f33d2f */

// 按钮选中时的背景颜色
- (UIColor *)main_color_01; /**< aa2b21 */

// 用于白色背景下的标题
- (UIColor *)main_color_10; /**< 323232 */

// 用于辅助类文字.非重要文本,如文章.消息的摘要,返佣比例.产品净值.产品期限等辅助性文字
- (UIColor *)normal_color_10; /**< 7a7a7a */

// 一般用在如系统消息.新闻文章发布的日期
- (UIColor *)normal_color_20; /**< 8e8e8e */

// 用于底部栏图标下面的文字,用于选项条右侧的文字
- (UIColor *)normal_color_30; /**< 929292 */

// 用在系统消息卡片上面的发布的日期色块
- (UIColor *)normal_color_40; /**< b0b0b0 */

// 页面最底层背景
- (UIColor *)weak_color_10; /**< efeff4 */

// 按钮禁用文字颜色
- (UIColor *)weak_color_11; /**< efefef */

// 按钮禁用背景颜色
- (UIColor *)weak_color_12; /**< dfdfdf */

// 边框颜色
- (UIColor *)weak_color_13; /**< e1e1e1 */

// 消息提示小圆点
- (UIColor *)other_color_10; /**< 65ba67 */


#pragma mark - Font

// 平方-细体
- (UIFont *)pingFangSCLightWithSize:(CGFloat)size;  /**< PingFangSC-Light */

// 平方-中黑体
- (UIFont *)pingFangSCMediumWithSize:(CGFloat)size;  /**< PingFangSC-Medium */

// 平方-常规体
- (UIFont *)pingFangSCRegularWithSize:(CGFloat)size;  /**< PingFangSC-Regular */

// 平方-中粗体
- (UIFont *)pingFangSCSemiboldWithSize:(CGFloat)size;  /**< PingFangSC-Semibold */

// 平方-纤细体
- (UIFont *)pingFangSCThinWithSize:(CGFloat)size;  /**< PingFangSC-Thin */

// 平方-极细体
- (UIFont *)pingFangSCUltralightWithSize:(CGFloat)size; /**< PingFangSC-Ultralight */


/**
 变更主题 颜色/字体/其他
 
 @param fileName 配置文件
 */
- (void)changeThemeStyleWithFileName:(NSString *)fileName;

@end
