//
//  TYCustomButton.m
//  TommyTemplate
//
//  Created by Tommy on 2017/10/7.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYCustomButton.h"

@interface TYCustomButton ()

@property (strong, nonatomic) UIButton *button;
@property (copy, nonatomic) TYCustomButtonActionBlock block;

@end

@implementation TYCustomButton

- (instancetype)init{
    if (self = [super init]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(buttonActionToTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        self.button = btn;
    }
    return self;
}

- (TYCustomButton *(^)(CGRect))frame {
    return ^id(CGRect frame) {
        self.button.frame = frame;
        return self;
    };
}

- (TYCustomButton *(^)(NSString *))title {
    return ^id(NSString *title) {
        [self.button setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (TYCustomButton *(^)(UIColor *))backgroundColor {
    return ^id(UIColor *backgroundColor) {
        self.button.backgroundColor = backgroundColor;
        return self;
    };
}


- (TYCustomButton *(^)(CGFloat))cornerRadius {
    return ^id(CGFloat cornerRadius) {
        self.button.layer.cornerRadius = cornerRadius;
        self.button.layer.masksToBounds = YES;
        return self;
    };
}

- (TYCustomButton *(^)(CGFloat))fontSize {
    return ^id(CGFloat fontSize) {
        self.button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}


- (TYCustomButton *(^)(UIColor *))titleColor {
    return ^id(UIColor *titleColor) {
        [self.button setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}

- (TYCustomButton *(^)(TYCustomButtonActionBlock))clickAction {
    return ^id(TYCustomButtonActionBlock action) {
        self.block = action;
        return self;
    };
}

- (UIButton *(^)(UIView *))showInView {
    return ^id(UIView *view) {
        [view addSubview:self.button];
        return self.button;
    };
}

// 针对于 那种 tablefooterview 的情况 需要放一个 containview 做容器
- (UIButton *(^)(UIView *,CGRect,UIColor *))showInViewWithBackgroundView {
    return ^id(UIView *view, CGRect frame, UIColor *bgColor) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
        backgroundView.backgroundColor = bgColor;
        [backgroundView addSubview:self.button];
        [view addSubview:backgroundView];
        return self.button;
    };
}


- (void)buttonActionToTouchUpInside:(UIButton *)sender {
    if (_block) {
        _block(sender);
    }
}


@end























