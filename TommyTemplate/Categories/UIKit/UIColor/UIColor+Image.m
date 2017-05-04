//
//  UIColor+Image.m
//  FeiDan
//
//  Created by Tommy on 2017/3/22.
//  Copyright © 2017年 TianJiMoney. All rights reserved.
//

#import "UIColor+Image.h"

@implementation UIColor (Image)

- (UIImage *)toImage {
    return [self toImageWithSize:CGSizeMake(1.0f, 1.0f)];
}

- (UIImage *)toImageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)toImageWithSize:(CGSize)size dashLineLengths:(CGFloat [])lengths counts:(NSInteger)count {
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [self set];
    //    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, size.height);
    CGContextSetStrokeColorWithColor(context, self.CGColor);
    //    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,count);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, size.width,size.height);
    CGContextStrokePath(context);
    //    CGContextClosePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
