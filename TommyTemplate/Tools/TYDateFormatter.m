//
//  TYDateFormatter.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYDateFormatter.h"

@implementation TYDateFormatter

static id _sharedInstance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (NSString *)specialStyleWithDate:(NSDate *)date {
    NSInteger time = [[NSDate date] timeIntervalSinceDate:date];
    
    if (time <= 3*60) {
        return @"刚刚";
    }
    else if (time < 10*60 ) {
        return @"3分钟前";
    }
    else if (time < 30*60) {
        return @"10分钟前";
    }
    else if (time < 60*60) {
        return @"半小时前";
    }
    else if (time < 60*60*6) {
        return @"1小时前";
    }
    else if (time < 60*60*12) {
        return @"半天前";
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd HH:mm"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        return dateString;
    }
}


- (NSString *)defaultStyleWithDate:(NSDate *)date {
    return [TY_DATE_FORMATTER stringWithDate:date dateFormatter:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)stringWithDate:(NSDate *)date dateFormatter:(NSString *)formatter {
    if (formatter.length == 0 || !formatter) {
        return [TY_DATE_FORMATTER defaultStyleWithDate:date];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:date];
}

@end
