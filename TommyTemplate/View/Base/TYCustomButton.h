//
//  TYCustomButton.h
//  TommyTemplate
//
//  Created by Tommy on 2017/10/7.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^TYCustomButtonActionBlock)(UIButton *);

@interface TYCustomButton : NSObject

- (TYCustomButton *(^)(CGRect))frame;
- (TYCustomButton *(^)(NSString *))title;
- (TYCustomButton *(^)(UIColor *))backgroundColor;
- (TYCustomButton *(^)(CGFloat))cornerRadius;
- (TYCustomButton *(^)(CGFloat))fontSize;
- (TYCustomButton *(^)(UIColor *))titleColor;
- (TYCustomButton *(^)(TYCustomButtonActionBlock))clickAction;
- (UIButton *(^)(UIView *))showInView;
// 针对于 那种 tablefooterview 的情况 需要放一个 containview 做容器
- (UIButton *(^)(UIView *,CGRect,UIColor *))showInViewWithBackgroundView;

@end
