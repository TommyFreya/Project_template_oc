//
//  UIView+TYBorder.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "UIView+TYBorder.h"

@implementation UIView (TYBorder)

- (void)ty_addBorderWithEdgeInsets:(UIEdgeInsets)insets borderColor:(UIColor *)color {
    
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return;
    }
    
    // 转成{1, 1, 1, 0}
    NSString *string = NSStringFromUIEdgeInsets(insets);
    // 去掉{}
    NSRange range = NSMakeRange(1, string.length-2);
    string = [string substringWithRange:range];
    
    NSArray *insetArray = [string componentsSeparatedByString:@", "];
    [insetArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat inset = [obj floatValue];
        if (inset != 0) {
            CGRect frame = CGRectZero;
            switch (idx) {
                case 0:
                    // top
                    frame.size.width = self.bounds.size.width;
                    frame.size.height = inset;
                    break;
                case 1:
                    // left
                    frame.size.width = inset;
                    frame.size.height = self.bounds.size.height;
                    break;
                case 2:
                    // bottom
                    frame.origin.y = self.bounds.size.height - inset;
                    frame.size.width = self.bounds.size.width;
                    frame.size.height = inset;
                    break;
                case 3:
                    // right
                    frame.origin.x = self.bounds.size.width - inset;
                    frame.size.width = inset;
                    frame.size.height = self.bounds.size.height;
                    break;
            }
            
            [self.layer addSublayer:[self layerWithFrame:frame backgroundColor:color]];
        }
        
    }];
    
}

- (CALayer *)layerWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    return layer;
}

@end
