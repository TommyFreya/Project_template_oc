//
//  TYThemeService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYThemeService.h"
#import "UIColor+HEX.h"

@interface TYThemeService ()

@property (nonatomic,strong) NSDictionary *colorDict;

@end

@implementation TYThemeService

static TYThemeService *instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.colorDict = [self p_getThemeConfigure:@"TJMDefaultThemeConfigure"];
    });
    return instance;
}

- (void)changeThemeStyleWithFileName:(NSString *)fileName {
    [TYThemeService sharedInstance].colorDict = [TYThemeService p_getThemeConfigure:fileName];
}

+ (NSDictionary *)p_getThemeConfigure:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"strings"];
    NSDictionary *map = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return map;
}


#pragma mark - Color
- (UIColor *)origin_color_00 {
    return [UIColor colorWithHexString:self.colorDict[@"origin_color_00"]];
}
- (UIColor *)origin_color_01 {
    return [UIColor colorWithHexString:self.colorDict[@"origin_color_01"]];
}

- (UIColor *)main_color_00 {
    return [UIColor colorWithHexString:self.colorDict[@"main_color_00"]];
}

- (UIColor *)main_color_01 {
    return [UIColor colorWithHexString:self.colorDict[@"main_color_01"]];
}

- (UIColor *)main_color_10 {
    return [UIColor colorWithHexString:self.colorDict[@"main_color_10"]];
}

- (UIColor *)normal_color_10 {
    return [UIColor colorWithHexString:self.colorDict[@"normal_color_10"]];
}

- (UIColor *)normal_color_20 {
    return [UIColor colorWithHexString:self.colorDict[@"normal_color_20"]];
}

- (UIColor *)normal_color_30 {
    return [UIColor colorWithHexString:self.colorDict[@"normal_color_30"]];
}

- (UIColor *)normal_color_40 {
    return [UIColor colorWithHexString:self.colorDict[@"normal_color_40"]];
}

- (UIColor *)weak_color_10 {
    return [UIColor colorWithHexString:self.colorDict[@"weak_color_10"]];
}

- (UIColor *)weak_color_11 {
    return [UIColor colorWithHexString:self.colorDict[@"weak_color_11"]];
}

- (UIColor *)weak_color_12 {
    return [UIColor colorWithHexString:self.colorDict[@"weak_color_12"]];
}

- (UIColor *)weak_color_13 {
    return [UIColor colorWithHexString:self.colorDict[@"weak_color_13"]];
}

- (UIColor *)other_color_10 {
    return [UIColor colorWithHexString:self.colorDict[@"other_color_10"]];
}


#pragma mark - Font
- (UIFont *)pingFangSCLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:self.colorDict[@"light_font"] size:size] ? : [UIFont fontWithName:@".HelveticaNeueInterface-Light" size:size];
}

- (UIFont *)pingFangSCMediumWithSize:(CGFloat)size {
    return [UIFont fontWithName:self.colorDict[@"medium_font"] size:size] ? : [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

- (UIFont *)pingFangSCRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:self.colorDict[@"regular_font"] size:size] ? : [UIFont fontWithName:@".HelveticaNeueInterface-Regular" size:size];
}

- (UIFont *)pingFangSCSemiboldWithSize:(CGFloat)size {
    return [UIFont fontWithName:self.colorDict[@"semibold_font"] size:size] ? : [UIFont fontWithName:@".HelveticaNeueInterface-MediumP4" size:size];
}

- (UIFont *)pingFangSCThinWithSize:(CGFloat)size {
    return [UIFont fontWithName:self.colorDict[@"thin_font"] size:size] ? : [UIFont fontWithName:@".HelveticaNeueInterface-Thin" size:size];
}

- (UIFont *)pingFangSCUltralightWithSize:(CGFloat)size {
    return [UIFont fontWithName:self.colorDict[@"ultralight_font"] size:size] ? : [UIFont fontWithName:@".HelveticaNeueInterface-UltraLightP2" size:size];
}

@end

