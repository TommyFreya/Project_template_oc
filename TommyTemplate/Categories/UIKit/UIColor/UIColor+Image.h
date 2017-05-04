//
//  UIColor+Image.h
//  FeiDan
//
//  Created by Tommy on 2017/3/22.
//  Copyright © 2017年 TianJiMoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Image)

// 颜色转换为图片
- (UIImage *)toImage;

- (UIImage *)toImageWithSize:(CGSize)size;

/**
 创建虚线图片
 
 @param size 图片尺寸
 @param lengths 虚线间距  CGFloat lengths[] = {4.0f,4.0f};
 @param count 2
 @return 图片
 */
- (UIImage *)toImageWithSize:(CGSize)size dashLineLengths:(CGFloat [])lengths counts:(NSInteger)count;

@end
