//
//  TYRouteDefine.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#ifndef TYRouteDefine_h
#define TYRouteDefine_h

#pragma mark - App Scheme Name
/*
 *** feidan 或者 tjm 或者 xxx ,根据 app 中 info.plist 中 "URL types -> URL Schemes -> item 0/1/2/3/4/xxx"来定义
 *** app 内部的跳转不受它影响
 *** 因为 item 可以有多个,所以如果 远程的 url scheme有多个的话,比如 http://blog.csdn.net/qq_22080737/article/details/53188784 里面举例的,那就要注册多个
 */
static NSString *const TJMRouteDefineSchemeDefault = @"xxxx";
//static NSString *const TJMRouteDefineSchemeXxx = @"Xxx";
//static NSString *const TJMRouteDefineSchemeXxxx = @"Xxxx";


#pragma mark - Storyboard Name
static NSString *const TJMRouteDefineStoryboardMain = @"Main";

#pragma mark - UIViewController Name
static NSString *const TJMRouteDefineViewControllerRootAuthen=@"rootauthen";
// 首页
static NSString *const TJMRouteDefineViewControllerHomePage = @"homepage";


#pragma mark - VC - VC JumpStyle Name
typedef NS_ENUM(NSInteger, TJMRouteAction) {
    TJMRouteActionPush = 0,
    TJMRouteActionPop = 1,
    TJMRouteActionPopTo = 2,
    TJMRouteActionPopToRoot = 3,
    TJMRouteActionPresent = 4,
    TJMRouteActionDismiss = 5
};


#endif /* TYRouteDefine_h */
