//
//  TYHudAlertService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger,TYProgressHUDMode){
    TYProgressHUDModeOnlyText,              //文字
    TYProgressHUDModeLoading,               //加载菊花
    TYProgressHUDModeCircle,                //加载环形
    TYProgressHUDModeCircleLoading,         //加载圆形-要处理进度值
    TYProgressHUDModeCustomAnimation,       //自定义加载动画（序列帧实现）
    TYProgressHUDModeSuccess,               //成功
    TYProgressHUDModeCustomerImage          //自定义图片
};

@interface TYHudAlertService : NSObject

// 显示
+ (void)show:(NSString *)msg inView:(UIView *)view mode:(TYProgressHUDMode)myMode;


#pragma mark - 纯文本提示框
// 显示提示（1秒后消失）
+ (void)showMessage:(NSString *)msg inView:(UIView *)view;

// 显示提示（N秒后消失）
+ (void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay;

// 在最上层显示 - 不需要指定showview
+ (void)showMsgInWindow:(NSString *)msg;


#pragma mark - 加载框
// 显示进度(菊花)
+ (void)showProgress:(NSString *)msg inView:(UIView *)view;

// 显示进度(环形)
+ (void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view ;

// 显示进度(转圈-要处理数据加载进度)
+ (MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view;


#pragma mark - 带图片/动画提示框
// 显示成功提示
+ (void)showSuccess:(NSString *)msg inview:(UIView *)view;

// 显示提示、带静态图片，比如失败，用失败图片即可，警告用警告图片等
+ (void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view;

// 显示自定义动画(自定义动画序列帧  找UI做就可以了)
+ (void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view;


#pragma mark - 取消
// 隐藏
+ (void)hide;

@end
