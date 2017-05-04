//
//  TYNSStringMacroDefine.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYNSStringMacroDefine.h"


BOOL NERObjectIsKindOfClass(NSString *className, ...) {
    va_list argList;
    va_start(argList, className);
    id object = va_arg(argList, id);
    va_end(argList);
    return [object isKindOfClass:NSClassFromString(className)];
}

NSString *NERFormatedStringWithArgumentsCount(NSInteger count, ...) {
    va_list argList;
    va_start(argList, count);
    
    NSString *result = nil;
    NSString *format = va_arg(argList, id);
    
    if (count <= 1) {
        result = format;
    } else {
        result = [[NSString alloc] initWithFormat:format arguments:argList];
    }
    
    va_end(argList);
    return result;
}

NSString *NERStringRepresentationOfValue(const char *type, const void *value) {
#define VALUE_OF_TYPE(t)    (*(t *)value)
    
    //http://www.dribin.org/dave/blog/archives/2008/09/22/convert_to_nsstring/
    //https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
    //http://nshipster.com/type-encodings/
    
    long length = strlen(type);
    
    if (length == 1) {
        switch (type[0]) {
            case '@': {
                id object = *(__strong id *)value;
                return [object description];
            }
                
#define CHECK_PRIMITIVE(t1, t2) case t1: return [@(VALUE_OF_TYPE(t2)) stringValue]
                
                CHECK_PRIMITIVE('i', int);
                CHECK_PRIMITIVE('l', long);
                
                CHECK_PRIMITIVE('f', float);
                CHECK_PRIMITIVE('d', double);
                
                CHECK_PRIMITIVE('s', short);
                CHECK_PRIMITIVE('B', BOOL);
                CHECK_PRIMITIVE('q', long long);
                
                CHECK_PRIMITIVE('I', unsigned int);
                CHECK_PRIMITIVE('L', unsigned long);
                CHECK_PRIMITIVE('S', unsigned short);
                CHECK_PRIMITIVE('Q', unsigned long long);
                
            case 'c':   //char
            case 'C':   //unsigned char
                return [NSString stringWithCharacters:value length:1];
                
            case '*':   //char *
                return [NSString stringWithUTF8String:VALUE_OF_TYPE(char *)];
                
            case ':':
                return NSStringFromSelector(VALUE_OF_TYPE(SEL));
            case '#':
                return NSStringFromClass(VALUE_OF_TYPE(Class));
        }
    }
    
    //const char *
    if (NER_IS_TYPE_OF(const char *)) {
        return [NSString stringWithFormat:@"%s", VALUE_OF_TYPE(const char *)];
    }
    
    //C string literal
    if (length > 1 && type[0] == '[' && type[length - 1] == ']' && type[length - 2] == 'c') {
        return [NSString stringWithFormat:@"%s", (char *)value];
    }
    
#define CHECK_IS_TYPE_OF(t1, t2)    if (NER_IS_TYPE_OF(t1)) return NSStringFrom##t2(VALUE_OF_TYPE(t1))
#define CHECK_IS_TYPE_OF2(t1)       CHECK_IS_TYPE_OF(t1, t1)
    
    CHECK_IS_TYPE_OF2(CGRect);
    CHECK_IS_TYPE_OF2(CGPoint);
    CHECK_IS_TYPE_OF2(CGSize);
    
    CHECK_IS_TYPE_OF(NSRange, Range);
    CHECK_IS_TYPE_OF2(UIEdgeInsets);
    
    CHECK_IS_TYPE_OF2(CGVector);
    CHECK_IS_TYPE_OF2(CGAffineTransform);
    CHECK_IS_TYPE_OF2(UIOffset);
    
    return @"";
}


@implementation NSString (NERChainable)

- (NERChainableNSStringObjectBlock)a {
    NER_OBJECT_BLOCK(return [self stringByAppendingString:value]);
}

- (NERChainableNSStringObjectBlock)ap {
    NER_OBJECT_BLOCK(return [self stringByAppendingPathComponent:value]);
}

- (NERChainableNSStringIntOrObjectBlock)subFrom {
    return ^(id value) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return [self substringFromIndex:[value integerValue]];
        } else {
            NSRange range = [self rangeOfString:[value description]];
            if (range.location != NSNotFound) {
                return [self substringFromIndex:range.location];
            } else {
                return @"";
            }
        }
    };
}

- (NERChainableNSStringIntOrObjectBlock)subTo {
    return ^(id value) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return [self substringToIndex:[value integerValue]];
        } else {
            NSRange range = [self rangeOfString:[value description]];
            if (range.location != NSNotFound) {
                return [self substringToIndex:range.location];
            } else {
                return @"";
            }
        }
    };
}

- (NERChainableNSStringObjectBlock)subMatch {
    return ^(id value) {
        NSRegularExpression *exp = nil;
        if ([value isKindOfClass:NSRegularExpression.class]) {
            exp = value;
        } else {
            exp = [[NSRegularExpression alloc] initWithPattern:value options:0 error:nil];
        }
        
        NSRange range = [exp rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
        
        if (range.location != NSNotFound) {
            return [self substringWithRange:range];
        } else {
            return @"";
        }
    };
}

- (NERChainableNSStringTwoObjectBlock)subReplace {
    return ^(id pattern, id template) {
        NSRegularExpression *exp = nil;
        if ([pattern isKindOfClass:NSRegularExpression.class]) {
            exp = pattern;
        } else {
            exp = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
        }
        
        return [exp stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:template];
    };
}


- (NSString *)inDocument {
    static NSString *documentPath = nil;
    if (!documentPath) {
        documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    }
    return [documentPath stringByAppendingPathComponent:self];
}

- (NSString *)inCaches {
    static NSString *cachesPath = nil;
    if (!cachesPath) {
        cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    }
    return [cachesPath stringByAppendingPathComponent:self];
}

- (NSString *)inTmp {
    static NSString *tmpPath = nil;
    if (!tmpPath) {
        tmpPath = NSTemporaryDirectory();
    }
    return [tmpPath stringByAppendingPathComponent:self];
}

@end
