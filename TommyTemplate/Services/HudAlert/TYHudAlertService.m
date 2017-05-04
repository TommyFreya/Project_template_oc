//
//  TYHudAlertService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYHudAlertService.h"

@interface TYHudAlertService ()

@property (nonatomic,strong) MBProgressHUD  *hud;

@end

@implementation TYHudAlertService

static TYHudAlertService *instance = nil;
+ (instancetype)shareinstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TYHudAlertService alloc] init];
    });
    
    return instance;
}

+ (void)show:(NSString *)msg inView:(UIView *)view mode:(TYProgressHUDMode)myMode {
    [self show:msg inView:view mode:myMode customImgView:nil];
}

+ (void)show:(NSString *)msg inView:(UIView *)view mode:(TYProgressHUDMode)myMode customImgView:(UIImageView *)customImgView {
    //如果已有弹框，先消失
    if ([TYHudAlertService shareinstance].hud != nil) {
        [[TYHudAlertService shareinstance].hud hideAnimated:YES];
        [TYHudAlertService shareinstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [TYHudAlertService shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //这里设置是否显示遮罩层
    //[YJProgressHUD shareinstance].hud.dimBackground = YES;    //是否显示透明背景
    
    //是否设置黑色背景，这两句配合使用
    [TYHudAlertService shareinstance].hud.bezelView.color = [UIColor blackColor];
    [TYHudAlertService shareinstance].hud.contentColor = [UIColor whiteColor];
    
    [[TYHudAlertService shareinstance].hud setMargin:10];
    [[TYHudAlertService shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [TYHudAlertService shareinstance].hud.detailsLabel.text = msg;
    
    [TYHudAlertService shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    switch ((NSInteger)myMode) {
        case TYProgressHUDModeOnlyText:
            [TYHudAlertService shareinstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case TYProgressHUDModeLoading:
            [TYHudAlertService shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case TYProgressHUDModeCircle:{
            [TYHudAlertService shareinstance].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.toValue = [NSNumber numberWithFloat:M_PI*2];
            animation.duration = 1.0;
            animation.repeatCount = 100;
            [img.layer addAnimation:animation forKey:nil];
            [TYHudAlertService shareinstance].hud.customView = img;
            
            
            break;
        }
        case TYProgressHUDModeCustomerImage:
            [TYHudAlertService shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [TYHudAlertService shareinstance].hud.customView = customImgView;
            break;
            
        case TYProgressHUDModeCustomAnimation:
            //这里设置动画的背景色
            [TYHudAlertService shareinstance].hud.bezelView.color = [UIColor yellowColor];
            
            
            [TYHudAlertService shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [TYHudAlertService shareinstance].hud.customView = customImgView;
            
            break;
            
        case TYProgressHUDModeSuccess:
            [TYHudAlertService shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [TYHudAlertService shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        default:
            break;
    }
}

+ (void)hide {
    if ([TYHudAlertService shareinstance].hud != nil) {
        [[TYHudAlertService shareinstance].hud hideAnimated:YES];
    }
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view {
    [self show:msg inView:view mode:TYProgressHUDModeOnlyText];
    [[TYHudAlertService shareinstance].hud hideAnimated:YES afterDelay:1.0];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay {
    [self show:msg inView:view mode:TYProgressHUDModeOnlyText];
    [[TYHudAlertService shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+ (void)showSuccess:(NSString *)msg inview:(UIView *)view {
    [self show:msg inView:view mode:TYProgressHUDModeSuccess];
    [[TYHudAlertService shareinstance].hud hideAnimated:YES afterDelay:1.0];
}

+ (void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view {
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:view mode:TYProgressHUDModeCustomerImage customImgView:img];
    [[TYHudAlertService shareinstance].hud hideAnimated:YES afterDelay:1.0];
}

+ (void)showProgress:(NSString *)msg inView:(UIView *)view {
    [self show:msg inView:view mode:TYProgressHUDModeLoading];
}

+ (MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = msg;
    return hud;
}

+ (void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view {
    [self show:msg inView:view mode:TYProgressHUDModeCircle];
}

+ (void)showMsgInWindow:(NSString *)msg {
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:TYProgressHUDModeOnlyText];
    [[TYHudAlertService shareinstance].hud hideAnimated:YES afterDelay:1.0];
}

+ (void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view {
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:view mode:TYProgressHUDModeCustomAnimation customImgView:showImageView];
}

@end
