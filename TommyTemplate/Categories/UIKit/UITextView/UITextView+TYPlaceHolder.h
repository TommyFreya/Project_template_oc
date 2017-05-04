//
//  UITextView+TYPlaceHolder.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (TYPlaceHolder)

/**
 * 占位提示语
 */
@property (nonatomic, copy)   NSString *tjm_placeholder;

/**
 * 占位提示语的字体颜色
 */
@property (nonatomic, strong) UIColor *tjm_placeholderColor;

/**
 * 占位提示语的字体
 */
@property (nonatomic, strong) UIFont  *tjm_placeholderFont;

/**
 *  显示区域Insets
 */
@property (nonatomic, assign) UIEdgeInsets tjm_placeContainerInset;

@end
