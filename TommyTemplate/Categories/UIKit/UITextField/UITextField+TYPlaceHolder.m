//
//  UITextField+TYPlaceHolder.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "UITextField+TYPlaceHolder.h"

@implementation UITextField (TYPlaceHolder)

- (void)setTy_placeHolderColor:(UIColor *)ty_placeHolderColor {
    [self setValue:ty_placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)ty_placeHolderColor {
    return  [self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setTy_placeHolderFont:(UIFont *)ty_placeHolderFont {
    [self setValue:ty_placeHolderFont forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)ty_placeHolderFont {
    return  [self valueForKeyPath:@"_placeholderLabel.font"];
}

@end
