//
//  TYBaseAnimateView.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYBaseAnimateView : UIView

// 继承之后要自己实现这个containerView，弹出的也即这个视图
@property (nonatomic, strong) UIView *containerView;

// 展示在keywindow上面
- (void)showInWindow;

// 展示在你想添加的view上
- (void)showInView:(UIView *)view;


- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
