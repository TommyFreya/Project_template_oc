//
//  TYBaseDataController.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "TYBaseRequest+TYSingleRequestBlock.h"

typedef void(^TYSuccessCompletionBlock)(_Nullable id);
typedef void(^TYFailCompletionBlock)(_Nullable id);
typedef void(^TYNetErrorCompletionBlock)(_Nullable id);
typedef void(^TYProgressBlock)(NSProgress * _Nonnull progress);

@interface TYBaseDataController : NSObject

#pragma mark - 建议:子类都不要调用这三个方法,而是加上当前所做网络请求的 事件名 来重写方法,比如 request"Login"WithXxxxxxxxxxxxxxxxx
/**
 *  <#Description#>
 *
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 */
+ (void)requestWithParameters:(_Nullable id)parameters
              successCallback:(TYSuccessCompletionBlock _Nullable)success;

/**
 *  <#Description#>
 *
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 *  @param fail       针对 无网络状态的错误callback
 */
+ (void)requestWithParameters:(_Nullable id)parameters
              successCallback:(TYSuccessCompletionBlock _Nullable)success
                 failCallback:(TYFailCompletionBlock _Nullable)fail;

/**
 *  <#Description#>
 *
 *  @param parameters <#parameters description#>
 *  @param isNeedLoading    <#success description#>
 *  @param success    <#success description#>
 *  @param fail       针对 无网络状态的错误callback
 */
+ (void)requestWithParameters:(_Nullable id)parameters
                isNeedLoading:(BOOL)isNeedLoading
              successCallback:(TYSuccessCompletionBlock _Nullable)success
                 failCallback:(TYFailCompletionBlock _Nullable)fail;

@end
