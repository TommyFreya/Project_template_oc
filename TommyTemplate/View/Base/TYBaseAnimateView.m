//
//  TYBaseAnimateView.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseAnimateView.h"

@interface TYBaseAnimateView ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation TYBaseAnimateView

- (instancetype)init{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBase];
    }
    return self;
}

- (void)setupBase{
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTapped:)];
    [self.backgroundView addGestureRecognizer:tap];
    
    [self addSubview:self.backgroundView];
}

- (void)showInWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showInView:window];
}


- (void)showInView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [view endEditing:YES];
        self.backgroundView.alpha = 0.f;
        self.containerView.alpha = 1.f;
        [view addSubview:self];
        
        if (self.containerView) {
            
            CGFloat y = self.frame.size.height - self.containerView.frame.size.height;
            CGRect endFrame = self.containerView.frame;
            endFrame.origin.y = y;
            
            [UIView animateWithDuration:0.6
                                  delay:0
                 usingSpringWithDamping:0.8
                  initialSpringVelocity:2
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
                                 self.backgroundView.alpha = 0.5f;
                                 self.containerView.frame = endFrame;
                             } completion:nil];
        }
    });
    
}

- (void)dismiss{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGFloat y = self.frame.size.height;
        CGRect endFrame = self.containerView.frame;
        endFrame.origin.y = y;
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             self.backgroundView.alpha = 0.f;
                             self.containerView.frame = endFrame;
                             self.containerView.alpha = 0.3f;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
        
    });
}

#pragma mark - Action 取消

- (void)backgroundViewDidTapped:(UITapGestureRecognizer *)gesture{
    
    [self dismiss];
}

- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

@end
