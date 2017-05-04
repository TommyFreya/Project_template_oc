//
//  TYBaseDataController.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseDataController.h"

@implementation TYBaseDataController

+ (void)requestWithParameters:(_Nullable id)parameters
              successCallback:(TYSuccessCompletionBlock _Nullable)success {
}

+ (void)requestWithParameters:(_Nullable id)parameters
              successCallback:(TYSuccessCompletionBlock _Nullable)success
                 failCallback:(TYFailCompletionBlock _Nullable)fail {
}

+ (void)requestWithParameters:(_Nullable id)parameters
                isNeedLoading:(BOOL)isNeedLoading
              successCallback:(TYSuccessCompletionBlock _Nullable)success
                 failCallback:(TYFailCompletionBlock _Nullable)fail {
}

@end
