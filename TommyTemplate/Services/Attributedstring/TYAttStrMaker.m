//
//  TYAttStrMaker.m
//  TestNavBarHeighLayout
//
//  Created by Tommy on 2017/3/2.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYAttStrMaker.h"

@interface TYAttStrMaker ()

@property (assign, nonatomic) NSRange range;

@end

@implementation TYAttStrMaker

- (instancetype)initValue:(NSString *)value {
    return [self initValue:value range:NSMakeRange(0, value.length)];
}

- (instancetype)initValue:(NSString *)value range:(NSRange)range {
    if (self = [super init]) {
        NSAssert(value != nil, @"TYAttStrMaker 接收的 value 为 nil");
        self.attrStr = [[NSMutableAttributedString alloc] initWithString:value ?: @"    "];
        self.range = range;
    }
    return self;
}

- (TYAttStrMaker *(^)(CGFloat))fontSize {
    return ^id(CGFloat size) {
        [self.attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(NSString *, CGFloat))textTypeface {
    return ^id(NSString *type ,CGFloat size) {
        [self.attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:type size: size] range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(UIColor *))fontColor {
    return ^id(UIColor *color) {
        [self.attrStr addAttribute:NSForegroundColorAttributeName value:color range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(UIColor *))backgroundColor {
    return ^id(UIColor *color) {
        [self.attrStr addAttribute:NSBackgroundColorAttributeName value:color range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(NSUnderlineStyle))underline {
    return ^id(NSUnderlineStyle style) {
        [self.attrStr addAttribute:NSUnderlineStyleAttributeName value:@(style) range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(UIColor *))underlineColor {
    return ^id(UIColor *color) {
        [self.attrStr addAttribute:NSUnderlineColorAttributeName value:color range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(NSUnderlineStyle))strikeThrough {
    return ^id(NSUnderlineStyle style) {
        [self.attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(style) range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(UIColor *))strikeThroughColor {
    return ^id(UIColor *color) {
        [self.attrStr addAttribute:NSStrikethroughColorAttributeName value:color range:self.range];
        return self;
    };
}

- (TYAttStrMaker *(^)(TYAttStrMaker *))add {
    return ^id(TYAttStrMaker *maker) {
        [self.attrStr appendAttributedString:maker.attrStr];
        return self;
    };
}

@end
























