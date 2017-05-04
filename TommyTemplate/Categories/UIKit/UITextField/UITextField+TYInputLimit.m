//
//  UITextField+TYInputLimit.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "UITextField+TYInputLimit.h"
#import <objc/runtime.h>

static const void *JKTextFieldInputLimitMaxLength = &JKTextFieldInputLimitMaxLength;

@interface UITextField ()

@property (strong, nonatomic) NSString* haveDian;

@end

@implementation UITextField (TYInputLimit)

static char haveDianKey;

- (void)setHaveDian:(NSString *)haveDian {
    objc_setAssociatedObject(self, &haveDianKey, haveDian, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)haveDian {
    return objc_getAssociatedObject(self, &haveDianKey);
}


- (BOOL)tjm_onlyNumberPointShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.text rangeOfString:@"."].location==NSNotFound) {
        self.haveDian = @"0";
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([self.text length]==0){
                if(single == '.'){
                    [TYHudAlertService showMsgInWindow:@"亲，第一个数字不能为小数点"];
                    [self.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                if (single == '0') {
                    [TYHudAlertService showMsgInWindow:@"亲，第一个数字不能为0"];
                    [self.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                //NSLog(@" name = %@",@(self.haveDian));
                if(![self.haveDian boolValue])//text中还没有小数点
                {
                    self.haveDian = @"1";
                    return YES;
                }else
                {
                    [TYHudAlertService showMsgInWindow:@"亲，您已经输入过小数点了"];
                    [self.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if ([self.haveDian boolValue])//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[self.text rangeOfString:@"."];
                    NSInteger tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        [TYHudAlertService showMsgInWindow:@"亲，您最多输入两位小数"];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [TYHudAlertService showMsgInWindow:@"亲，您输入的格式不正确"];
            [self.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}


#pragma mark - 限制输入长度
- (NSInteger)jk_maxLength {
    return [objc_getAssociatedObject(self, JKTextFieldInputLimitMaxLength) integerValue];
}
- (void)setJk_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, JKTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(jk_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)jk_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.jk_maxLength > 0 && toBeString.length > self.jk_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.jk_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.jk_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.jk_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.jk_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}



@end
