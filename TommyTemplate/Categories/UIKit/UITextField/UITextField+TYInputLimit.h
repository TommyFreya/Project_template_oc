//
//  UITextField+TYInputLimit.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TYInputLimit)

@property (assign, nonatomic)  NSInteger jk_maxLength;//if <=0, no limit

// 一般用于金额输入,只能输入数字和小数点
- (BOOL)tjm_onlyNumberPointShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

// .............

@end
