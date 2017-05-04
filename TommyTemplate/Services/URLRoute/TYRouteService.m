//
//  TYRouteService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYRouteService.h"
#import <JLRoutes/JLRoutes.h>
#import <objc/runtime.h>
#import "UIViewController+TYTopView.h"

@implementation TYRouteService

#pragma mark - add route

+ (void)registerRouteDefault {
    [[JLRoutes routesForScheme:TJMRouteDefineSchemeDefault] addRoute:@"/:target/:action" handler:^BOOL(NSDictionary *parameters) {
        NSString *target = [parameters[@"target"] lowercaseString ];
        NSString *action = [parameters[@"action"] lowercaseString];
        
        NSString* file = [[NSBundle mainBundle] pathForResource:@"TYRouteMap" ofType:@"plist"];
        NSMutableDictionary *viewControllersPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
        
        UIViewController *vc = nil;
        NSString *viewControllerName = viewControllersPlist[target];
        if (viewControllerName) {
            // Storyboard References 的特性 可以 都从 Main.sb 上读取所有的 viewControllers
            vc = [[UIStoryboard storyboardWithName:TJMRouteDefineStoryboardMain bundle:nil] instantiateViewControllerWithIdentifier:viewControllerName];
        } else {
            NSCAssert(viewControllerName != nil, @"url route 跳转, 传入的 target 不存在");
            return NO;
        }
        
        // 传值
        parameters ? [vc setParams:parameters] : nil;
        
        if ([action isEqualToString:@"push"]) {
            [[UIViewController topViewController].navigationController pushViewController:vc animated:YES]; // 按理说动画的状态在这里不应该写死,应该通过参数来控制
        } else if ([action isEqualToString:@"pop"]) {
            // ....
        } else if ([action isEqualToString:@"popto"]) {
            [[UIViewController topViewController].navigationController popToViewController:vc animated:YES];
        } else if ([action isEqualToString:@"poptoroot"]) {
            // ....
        } else if ([action isEqualToString:@"present"]) {
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
            
            [[UIViewController topViewController] presentViewController:navi animated:YES completion:nil];
        } else if ([action isEqualToString:@"dismiss"]) {
            // ....
        } else {
            NSString *jumpStyle = nil;
            NSCAssert(jumpStyle != nil, @"url route 跳转, 传入的 action 不存在");
            return NO;
        }
        
        return YES;
    }];
}

+ (void)registerRouteWithScheme:(NSString *)schemeName routePattern:(NSString *)routePattern handler:(BOOL (^)(NSDictionary<NSString *, id> *parameters))handlerBlock {
    [[JLRoutes routesForScheme:schemeName] addRoute:routePattern handler:handlerBlock];
}


#pragma mark - open url
+ (BOOL)openURL:(NSURL *)url {
    return [JLRoutes routeURL:url];
}

+ (BOOL)openURLDefaultSchemeWithTarget:(NSString *)target {
    return [self openURLWithScheme:TJMRouteDefineSchemeDefault target:target];
}

+ (BOOL)openURLDefaultSchemeWithTarget:(NSString *)target
                            parameters:(NSDictionary<NSString *,id> * _Nullable)parameters {
    return [self openURLWithScheme:TJMRouteDefineSchemeDefault target:target action:TJMRouteActionPush parameters:parameters];
}

+ (BOOL)openURLDefaultSchemeWithTarget:(NSString *)target
                                action:(TJMRouteAction)action
                            parameters:(NSDictionary<NSString *,id> * _Nullable)parameters {
    return [self openURLWithScheme:TJMRouteDefineSchemeDefault target:target action:action parameters:parameters];
}

+ (BOOL)openURLWithScheme:(NSString *)scheme
                   target:(NSString *)target {
    return  [self openURLWithScheme:scheme target:target action:TJMRouteActionPush parameters:nil];
}

+ (BOOL)openURLWithScheme:(NSString *)scheme
                   target:(NSString *)target
                   action:(TJMRouteAction)action
               parameters:(NSDictionary<NSString *,id> *)parameters {
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@/%@",scheme,target,[self p_getURLActionString:action]];
    return [JLRoutes routeURL:[NSURL URLWithString:urlStr] withParameters:parameters];
}

+ (void)unregisterRouteScheme:(NSString *)scheme {}
+ (void)unregisterAllRouteSchemes {}
+ (void)removeRouteWithScheme:(NSString *)scheme routePattern:(NSString *)routePattern {}
+ (void)removeAllRoutesWithScheme:(NSString *)scheme {}


#pragma mark - Private Methods
// 跳转方式不写成 plis 文件,是因为,远程 url 在这个值的问题上并不会引起 crash, 字符串如果对不上的话,就默认为 push 展示,当然,也可以考虑写成 plsit, 可以后续讨论
+ (NSString *)p_getURLActionString:(TJMRouteAction)action {
    NSString *urlAction = nil;
    switch (action) {
        case TJMRouteActionPush: urlAction = @"push"; break;
        case TJMRouteActionPop: urlAction = @"pop"; break;
        case TJMRouteActionPopTo: urlAction = @"popto"; break;
        case TJMRouteActionPopToRoot: urlAction = @"poptoroot"; break;
        case TJMRouteActionPresent: urlAction = @"present"; break;
        case TJMRouteActionDismiss: urlAction = @"dismiss"; break;
        default: break;
    }
    return urlAction;
}

@end



#pragma mark - UIViewController Category

@implementation UIViewController (TJMRouter)

static char kAssociatedParamsObjectKey;

- (void)setParams:(NSDictionary *)paramsDictionary {
    objc_setAssociatedObject(self, &kAssociatedParamsObjectKey, paramsDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, &kAssociatedParamsObjectKey);
}

@end
