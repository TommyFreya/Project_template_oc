//
//  TYDateFormatter.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TY_DATE_FORMATTER [TYDateFormatter sharedInstance]

@interface TYDateFormatter : NSObject

+ (instancetype)sharedInstance;

// 默认时间格式：2017-02-27 17:08
- (NSString *)defaultStyleWithDate:(NSDate *)date;

// 特殊时间格式：多少分钟前、多少小时前、一天前等
- (NSString *)specialStyleWithDate:(NSDate *)date;

// 指定时间格式：formatter
- (NSString *)stringWithDate:(NSDate *)date dateFormatter:(NSString *)formatter;

// ......... more

@end
