//
//  TYAttStrMaker.h
//
//  Created by Tommy on 2017/3/2.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TY_ATTR_STR(value) [[TYAttStrMaker alloc] initValue:(value)]
#define TY_ATTR_STR_RANGE(value,loc,len) [[TYAttStrMaker alloc] initValue:(value) range:NSMakeRange((loc), (len))]

@interface TYAttStrMaker : NSObject

@property (strong, nonatomic) NSMutableAttributedString *attrStr;

/**
 初始化 make

 @param value 文本字符串›
 @param range 需要改变的范围(默认整个文本)
 @return <#return value description#>
 */
- (instancetype)initValue:(NSString *)value range:(NSRange)range;
- (instancetype)initValue:(NSString *)value;
// 文本大小
- (TYAttStrMaker *(^)(CGFloat))fontSize;
// 文本字体和大小
- (TYAttStrMaker *(^)(NSString*,CGFloat))textTypeface;
// 文本颜色
- (TYAttStrMaker *(^)(UIColor *))fontColor;
// 文本背景色
- (TYAttStrMaker *(^)(UIColor *))backgroundColor;
// 下划线
- (TYAttStrMaker *(^)(NSUnderlineStyle))underline;
// 下划线颜色
- (TYAttStrMaker *(^)(UIColor *))underlineColor;
// 删除线
- (TYAttStrMaker *(^)(NSUnderlineStyle))strikeThrough;
// 删除线颜色
- (TYAttStrMaker *(^)(UIColor *))strikeThroughColor;
// ....... 需要什么自己去加

// 添加另一个 maker
- (TYAttStrMaker *(^)(TYAttStrMaker *))add;

@end


// NSUnderlineStyleNone 不设置下划线／删除线
// NSUnderlineStyleSingle 设置下划线／删除线为细的单线
// NSUnderlineStyleThick 设置下划线／删除线为粗的单线
// NSUnderlineStyleDouble 设置下划线／删除线为细的双线
// NSUnderlinePatternSolid 设置下划线／删除线样式为连续的实线
// NSUnderlinePatternDot 设置下划线／删除线样式为点，也就是虚线，比如这样：－－－－－－
// NSUnderlinePatterDash 设置下划线／删除线样式为破折号，比如这样：—— —— ——
// NSUnderlinePatternDashDot 设置下划线／删除线样式为连续的破折号和点，比如这样：——－——－——－
// NSUnderlinePatternDashDotDot 设置下划线／删除线样式为连续的破折号、点、点，比如：——－－——－－——－－
// NSUnderlineByWord 在有空格的地方不设置下划线／删除线
/*可以多个组合一起用,如下*/
// NSUnderlineStyleDouble | NSUnderlinePatternDot





