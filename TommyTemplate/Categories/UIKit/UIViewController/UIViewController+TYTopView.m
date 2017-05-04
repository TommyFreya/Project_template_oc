//
//  UIViewController+TYTopView.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "UIViewController+TYTopView.h"

@implementation UIViewController (TYTopView)

+ (UIViewController *)topViewController {
    UIViewController *vc = [self rootTopViewController];
    return [self topViewController:vc];
}

+ (UIViewController *)rootTopViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)rootViewController;
        UIViewController *ctl = tabVC.selectedViewController;
        
        if ([ctl isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)ctl).visibleViewController;
        } else {
            return rootViewController.presentedViewController ? rootViewController.presentedViewController : rootViewController;
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)rootViewController).visibleViewController;
    } else {
        return rootViewController.presentedViewController ? rootViewController.presentedViewController : rootViewController;
    }
}

@end
