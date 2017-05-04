//
//  TYNSStringMacroDefine.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <objc/objc.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

/**
 * Create a NSString.
 * Str argument can be:
 1) C string
 2) any primitive type
 3) any object
 4) CGRect, CGPoint, CGSize, NSRange, UIEdgeInsets
 5) Selector
 6) Class
 7) Format String
 
 * Usages: Str(100), Str(3.14), Str(@0.618), Str([UIView class]), Str(_cmd), Str(view.frame),
 Str("Hello"), Str(@"World"), Str(@"%d+%d=%d", 1, 1, 1 + 1)
 */
#define Str(...)                ({NER_CHECK_IS_STRING(__VA_ARGS__)? \
NER_STRING_FORMAT(__VA_ARGS__):\
NER_STRING_VALUE(__VA_ARGS__);})

/****************************************************** 辅助 *************************************************************/

#define NER_CHECK_IS_STRING(x, ...)     NER_IS_STRING(x)
#define NER_IS_STRING(x)                (NER_IS_OBJECT(x) && NERObjectIsKindOfClass(@"NSString", x))

#define NER_IS_OBJECT(x)            (strchr("@#", NER_TYPE_FIRST_LETTER(x)) != NULL)
#define NER_TYPE(x)                 @encode(typeof(x))
#define NER_TYPE_FIRST_LETTER(x)    (NER_TYPE(x)[0])
#define NER_IS_TYPE_OF(x)           (strcmp(type, @encode(x)) == 0)


#define NER_STRING_FORMAT(...)          ({ NERFormatedStringWithArgumentsCount(NER_NUMBER_OF_VA_ARGS(__VA_ARGS__), __VA_ARGS__); })
#define NER_NUMBER_OF_VA_ARGS(...)  NER_NUMBER_OF_VA_ARGS_(__VA_ARGS__, NER_RSEQ_N())
#define NER_NUMBER_OF_VA_ARGS_(...) NER_ARG_N(__VA_ARGS__)

#define NER_ARG_N( \
_1, _2, _3, _4, _5, _6, _7, _8, _9,_10, \
_11,_12,_13,_14,_15,_16,_17,_18,_19,_20, \
_21,_22,_23,_24,_25,_26,_27,_28,_29,_30, \
_31,_32,_33,_34,_35,_36,_37,_38,_39,_40, \
_41,_42,_43,_44,_45,_46,_47,_48,_49,_50, \
_51,_52,_53,_54,_55,_56,_57,_58,_59,_60, \
_61,_62,_63,N,...) N

#define NER_RSEQ_N() \
63,62,61,60,                   \
59,58,57,56,55,54,53,52,51,50, \
49,48,47,46,45,44,43,42,41,40, \
39,38,37,36,35,34,33,32,31,30, \
29,28,27,26,25,24,23,22,21,20, \
19,18,17,16,15,14,13,12,11,10, \
9,8,7,6,5,4,3,2,1,0


#define NER_STRING_VALUE(x, ...)        ({ typeof(x) _ix_ = (x); NERStringRepresentationOfValue(@encode(typeof(x)), &_ix_); })


BOOL    NERObjectIsKindOfClass(NSString *className, ...);
NSString *      NERFormatedStringWithArgumentsCount(NSInteger count, ...);
NSString *      NERStringRepresentationOfValue(const char *type, const void *value);


#pragma mark - ********************************* 字符串处理 Category(https://github.com/nerdycat/NerdyUI) ***********************************************
/*
 typedef
 */
typedef struct NERRect {
    CGRect value;
} NERRect;

typedef struct NERPoint {
    CGPoint value;
} NERPoint;

typedef struct NERSize {
    CGSize value;
} NERSize;

typedef struct NEREdgeInsets {
    UIEdgeInsets value;
} NEREdgeInsets;

typedef struct NERRange {
    NSRange value;
} NERRange;

//typedef struct NERCallback {
//    void *targetOrBlock;
//    SEL action;
//} NERCallback;

typedef struct NERFloatList {
    CGFloat f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;
    CGFloat validCount;
} NERFloatList;

#define NER_MAKE_FLOAT_LIST(...)    ({NERFloatList floatList = (NERFloatList){__VA_ARGS__}; \
floatList.validCount = MIN(10, NER_NUMBER_OF_VA_ARGS(__VA_ARGS__)); \
floatList;})


typedef void (^NERSimpleBlock)();
typedef void (^NERObjectBlock)(id);


#define NERNull             NSIntegerMax

#define Exp(x)              ({x;})


@class NERConstraint;
@class NERAlertMaker;
@class NERStack;
@class NERStyle;
@class NERStaticRow;
@class NERStaticSection;
@class NERStaticTableView;
#define NER_STRING_PROP(y)          NER_PROP(NSString, y)
#define NER_PROP(x,y)               NER_READONLY NERChainable##x##y##Block
#define NER_CHAINABLE_TYPE(v, t)    typedef v *(^NERChainable##v##t##Block)
#define NER_READONLY                @property (nonatomic, readonly)

#define NER_OBJECT_BLOCK(...)       NER_CHAINABLE_BLOCK(id, __VA_ARGS__)
#define NER_CHAINABLE_BLOCK(x, ...) return ^(x value) {__VA_ARGS__; return self;}

#define NER_GENERATE_CHAINABLE_TYPES(x) \
NER_CHAINABLE_TYPE(x, Empty)();\
NER_CHAINABLE_TYPE(x, Object)(id);\
NER_CHAINABLE_TYPE(x, TwoObject)(id, id);\
NER_CHAINABLE_TYPE(x, ObjectList)(id, ...);\
NER_CHAINABLE_TYPE(x, Bool)(NSInteger);\
NER_CHAINABLE_TYPE(x, Int)(NSInteger);\
NER_CHAINABLE_TYPE(x, TwoInt)(NSInteger, NSInteger);\
NER_CHAINABLE_TYPE(x, IntOrObject)(id);\
NER_CHAINABLE_TYPE(x, Float)(CGFloat);\
NER_CHAINABLE_TYPE(x, TwoFloat)(CGFloat, CGFloat);\
NER_CHAINABLE_TYPE(x, FourFloat)(CGFloat, CGFloat, CGFloat, CGFloat);\
NER_CHAINABLE_TYPE(x, FloatList)(NERFloatList);\
NER_CHAINABLE_TYPE(x, FloatObjectList)(CGFloat, ...);\
NER_CHAINABLE_TYPE(x, Rect)(NERRect);\
NER_CHAINABLE_TYPE(x, Size)(NERSize);\
NER_CHAINABLE_TYPE(x, Point)(NERPoint);\
NER_CHAINABLE_TYPE(x, Range)(NERRange);\
NER_CHAINABLE_TYPE(x, Insets)(UIEdgeInsets);\
NER_CHAINABLE_TYPE(x, Embed)(id, UIEdgeInsets);\
NER_CHAINABLE_TYPE(x, Callback)(id, id);\
NER_CHAINABLE_TYPE(x, Block)(id);


NER_GENERATE_CHAINABLE_TYPES(UIView);
NER_GENERATE_CHAINABLE_TYPES(UILabel);
NER_GENERATE_CHAINABLE_TYPES(UIImageView);
NER_GENERATE_CHAINABLE_TYPES(UIButton);
NER_GENERATE_CHAINABLE_TYPES(UITextField);
NER_GENERATE_CHAINABLE_TYPES(UITextView);
NER_GENERATE_CHAINABLE_TYPES(UISwitch);
NER_GENERATE_CHAINABLE_TYPES(UIPageControl);
NER_GENERATE_CHAINABLE_TYPES(UISlider);
NER_GENERATE_CHAINABLE_TYPES(UIStepper);
NER_GENERATE_CHAINABLE_TYPES(UISegmentedControl);
NER_GENERATE_CHAINABLE_TYPES(UIVisualEffectView);
NER_GENERATE_CHAINABLE_TYPES(UIImage);
NER_GENERATE_CHAINABLE_TYPES(UIColor);
NER_GENERATE_CHAINABLE_TYPES(NSString);
NER_GENERATE_CHAINABLE_TYPES(NSMutableAttributedString);
NER_GENERATE_CHAINABLE_TYPES(NERConstraint);
NER_GENERATE_CHAINABLE_TYPES(NERAlertMaker);
NER_GENERATE_CHAINABLE_TYPES(NERStack);
NER_GENERATE_CHAINABLE_TYPES(NERStyle);
NER_GENERATE_CHAINABLE_TYPES(NERStaticTableView);
NER_GENERATE_CHAINABLE_TYPES(NERStaticRow);
NER_GENERATE_CHAINABLE_TYPES(NERStaticSection);

@interface NSString (NERChainable)

/**
 * Appending string.
 * a use Str() internally, so it can take any kind of arguments that Str() supported.
 * Usages: @"1".a(@"2").a(3).a(nil).a(4.0f).a(@5).a(@"%d", 6);      //@"123456"
 */
NER_STRING_PROP(Object)         a;

/**
 * Appending path component.
 * ap use Str() internally, so it can take any kind of arguments that Str() supported.
 * Usages: @"dir1".ap(222).ap(@"dir3").ap(@"cat.png")               //@"dir1/222/dir3/cat.png"
 */
NER_STRING_PROP(Object)         ap;

/**
 * Substring from index or from substring.
 * Usages:
 @"hello".subFrom(2);             //@"llo"
 @"hello".subFrom(@"el");         //@"ello"
 */
NER_STRING_PROP(IntOrObject)    subFrom;

/**
 * Substring to index or to substring.
 * Usages:
 @"hello".subTo(2);               //@"he"
 @"hello".subTo(@"el");           //@"h"
 @"hello".subFrom(1).subTo(@"o"); //@"ell"
 */
NER_STRING_PROP(IntOrObject)    subTo;

/**
 * Return first substring that match the regular expression.
 * It support two kind of argument:
 1) NSRegularExpression
 2) NSString that represent regular expression pattern.
 * Usages: @"pi: 3.14".subMatch(@"[0-9.]+")         //@"3.14"
 */
NER_STRING_PROP(Object)         subMatch;

/**
 * Returns a new string containing matching regular expressions replaced with the template string.
 * Inside template string, $0 being replaced by the contents of the matched range,
 $1 by the contents of the first capture group, and so on.
 * Usages:
 @"hello world".subReplace(@"world", @"WORLD")                //@"hello WORLD"
 @"hello world".subReplace(@"(\\w+) (\\w+)", @"$2 $1")        //@"world hello"
 */
NER_STRING_PROP(TwoObject)      subReplace;


#define a(...)                  a(Str(__VA_ARGS__))
#define ap(...)                 ap(Str(__VA_ARGS__))
#define subFrom(x)              subFrom(NER_CONVERT_VALUE_TO_NUMBER(x))
#define subTo(x)                subTo(NER_CONVERT_VALUE_TO_NUMBER(x))


/**
 * Prepend document/caches/tmp directory path to current string.
 * Usages: @"abc.db".inCaches, @"images".ap("cat.png").inDocument
 */
- (NSString *)inDocument;
- (NSString *)inCaches;
- (NSString *)inTmp;

@end

