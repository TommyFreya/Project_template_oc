//
//  TYRouteService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TYRouteDefine.h"

//#define TY_ROUTE_SERVICE [TYRouteService registerRouteDefault]

NS_ASSUME_NONNULL_BEGIN

@interface TYRouteService : NSObject

/**
 默认配置
 */
+ (void)registerRouteDefault;

/**
 注册 Route
 
 @param schemeName app的 URL Schemes
 @param routePattern /:viewController/:jumpStyle
 @param handlerBlock <#handlerBlock description#>
 */
+ (void)registerRouteWithScheme:(NSString *)schemeName routePattern:(NSString *)routePattern handler:(BOOL (^)(NSDictionary<NSString *, id> *parameters))handlerBlock;


/**
 通过远程URL打开(通常指 H5 跳入 app 或者 远程推送跳入 app)
 
 @param url <#url description#>
 @return <#return value description#>
 */
+ (BOOL)openURL:(NSURL *)url;

/**
 通过应用内URL打开(为了书写,分解为传入参数模式,在内部进行拼接)
 
 @param scheme     app的 URL Schemes
 @param target     每个target,也即 viewController
 @param action     vc 与 vc 之间的跳转方式(默认 是 push)
 @param parameters vc之间需要传值的参数(默认 不传任何参数)
 @return <#return value description#>
 */
+ (BOOL)openURLWithScheme:(NSString *)scheme
                   target:(NSString *)target
                   action:(TJMRouteAction)action
               parameters:(NSDictionary<NSString *,id> * _Nullable)parameters;
+ (BOOL)openURLWithScheme:(NSString *)scheme
                   target:(NSString *)target;
+ (BOOL)openURLDefaultSchemeWithTarget:(NSString *)target;
+ (BOOL)openURLDefaultSchemeWithTarget:(NSString *)target
                            parameters:(NSDictionary<NSString *,id> * _Nullable)parameters;
+ (BOOL)openURLDefaultSchemeWithTarget:(NSString *)target
                                action:(TJMRouteAction)action
                            parameters:(NSDictionary<NSString *,id> * _Nullable)parameters;



+ (void)unregisterRouteScheme:(NSString *)scheme;
+ (void)unregisterAllRouteSchemes;
+ (void)removeRouteWithScheme:(NSString *)scheme routePattern:(NSString *)routePattern;
+ (void)removeAllRoutesWithScheme:(NSString *)scheme;

@end

NS_ASSUME_NONNULL_END


///--------------------------------
/// @name UIViewController Category
///--------------------------------

@interface UIViewController (TJMRouter)

@property (nonatomic, strong) NSDictionary *_Nullable params;

@end
