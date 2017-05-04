//
//  TYBaseNavigationController.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseNavigationController.h"
#import "TYBaseViewController.h"

@interface TYBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation TYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"nav_orange_back_icon"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)onClickBack:(UIButton *)sender {
    
    TYBaseNavigationController *navigationCtl = [[sender.allTargets allObjects] firstObject];
    TYBaseViewController *viewController = [navigationCtl.viewControllers lastObject];
    if ([viewController conformsToProtocol:@protocol(TYViewControllerPopActionDelegate)] &&
        [viewController respondsToSelector:@selector(ty_unifyPopForMoreEvent)]) {
        [viewController ty_unifyPopForMoreEvent];
    } else {
        [self popViewControllerAnimated:YES];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

#pragma mark - UIGestureRecognizerDelegate
// 防止在根视图滑动手势后,界面卡死
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
