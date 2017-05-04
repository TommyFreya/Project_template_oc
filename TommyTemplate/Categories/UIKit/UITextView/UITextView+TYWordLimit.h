//
//  UITextView+TYWordLimit.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (TYWordLimit)

- (BOOL)ty_shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text maxLimitNums:(NSInteger)maxLimitNums;
- (void)ty_didChangeMaxLimitNums:(NSInteger)maxLimitNums;

@end
