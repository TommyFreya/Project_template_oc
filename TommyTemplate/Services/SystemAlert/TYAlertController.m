//
//  TYAlertController.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYAlertController.h"
#import <objc/runtime.h>

@implementation TYAlertAction

//按钮标题的字体颜色
-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for(int i =0;i < count;i ++){
        
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        
        if ([ivarName isEqualToString:@"_titleTextColor"]) {
            
            [self setValue:textColor forKey:@"titleTextColor"];
        }
    }
}

@end

@implementation TYAlertController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertController class], &count);
    for(int i = 0;i < count;i ++){
        
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        
        //标题颜色
        if ([ivarName isEqualToString:@"_attributedTitle"] && self.title && self.titleColor) {
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self.title attributes:@{NSForegroundColorAttributeName:self.titleColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
            [self setValue:attr forKey:@"attributedTitle"];
        }
        
        //描述颜色
        if ([ivarName isEqualToString:@"_attributedMessage"] && self.message) {
            
            NSMutableDictionary *atttributes = [NSMutableDictionary dictionary];
            [atttributes setObject:[UIFont systemFontOfSize:13.0] forKey:NSFontAttributeName];
            if(self.messageColor){
                [atttributes setObject:self.messageColor forKey:NSForegroundColorAttributeName];
            }
            
            //对齐方式
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = self.messageAlignment;
            [atttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
            
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.message attributes:atttributes];
            [self setValue:attr forKey:@"attributedMessage"];
        }
    }
    
    //按钮统一颜色
    if (self.tintColor) {
        for (TYAlertAction *action in self.actions) {
            if (!action.textColor) {
                action.textColor = self.tintColor;
            }
        }
    }
    
    if (self.actionColor) {
        for (TYAlertAction *action in self.actions) {
            if (action.style == UIAlertActionStyleDefault) {
                action.textColor = self.actionColor;
            }
        }
    }
    
    if (self.cancelColor) {
        for (TYAlertAction *action in self.actions) {
            if (action.style == UIAlertActionStyleCancel) {
                action.textColor = self.cancelColor;
            }
        }
    }
}

@end
