//
//  TYMacroDefine.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#ifndef TYMacroDefine_h
#define TYMacroDefine_h

#pragma mark - *************************************** 设备尺寸 ***********************************
#define SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_6P (SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_5 (SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_4s (SCREEN_MAX_LENGTH == 480.0)



#pragma mark - *************************************** 字符串/数组/字典 判空 ***********************************
#define IS_NIL(_obj)     ((nil == _obj) || [_obj isKindOfClass:[NSNull class]])
#define STRING_IS_EMPTY(_obj)    (_obj.length == 0)
#define STRING_IS_WHITHESPACE(_obj) ([[_obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
#define STRING_IS_NOTNIL_NOTEMPTY(_obj)   ((!IS_NIL(_obj)) && (!STRING_IS_EMPTY(_obj)))
#define STRING_IS_NOTNIL_NOTEMPTY_NOTWHITHESPACE(_obj) ((!IS_NIL(_obj)) && (!STRING_IS_EMPTY(_obj)) && (!STRING_IS_WHITHESPACE(_obj)))
//数组是否为空
#define ARRAY_IS_EMPTY(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define DICT_IS_EMPTY(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)



#pragma mark - *************************************** Other ***********************************
#ifdef DEBUG
#define NSLog(format, ...) NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n 输出 = " format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...) {}
#endif


#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

// 角度转弧度
#define DEGREES_TO_RADIAN(x) (M_PI * (x) / 180.0)
// 弧度转角度
#define RADIAN_TO_DEGREES(radian) (radian*180.0)/(M_PI)



#pragma mark - *************************************** 颜色 RGB 转换 ***********************************
#define UICOLOR_FROM_RGB(rgbValue)	[UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
green:((float)(((rgbValue) & 0x00FF00) >> 8))/255.0 \
blue:((float)((rgbValue) & 0x0000FF))/255.0 \
alpha:1.0]



#pragma mark - *************************************** 强/弱 引用 self ***********************************
#define WEAK_SELF(type)  __weak typeof(type) weak##type = type;
#define STRONG_SELF(type)  __strong typeof(type) type = weak##type;



#pragma mark - *************************************** xib 获取资源 ***********************************
// 获取通过 xib 创建的 view
#define LOAD_XIB(className) [[[NSBundle mainBundle] loadNibNamed:((Str(className))) owner:nil options:nil] lastObject];
// 注册 xib cell
#define REGISTER_NIB_CELL(tableView,cellClass) [tableView registerNib:[UINib nibWithNibName:(Str(cellClass)) bundle:nil] \
forCellReuseIdentifier:(Str(cellClass))];



#pragma mark - *************************************** 获取图片资源 ***********************************
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]



#pragma mark - *************************************** 设备型号 ***********************************
// 字符串是根据ascii  compare 比较字符串的时候是按照 ascii码来比较的 如果你的系统时10.0 的 那么 “9.0”>”10.0”的
#define IOS6_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"  options:NSNumericSearch]!= NSOrderedAscending)
#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"  options:NSNumericSearch]!= NSOrderedAscending)
#define IOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"  options:NSNumericSearch]!= NSOrderedAscending)
#define IOS9_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"  options:NSNumericSearch]!= NSOrderedAscending)
#define IOS10_OR_LATER  ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch]!= NSOrderedAscending)


#pragma mark - *************************************** 设备信息 ***********************************
#define TY_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define TY_APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#endif /* TYMacroDefine_h */
