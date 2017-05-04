//
//  TYBaseRequest+TYSingleRequestBlock.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseRequest.h"

typedef void(^TYRequestSuccessBlock)(__kindof id _Nullable data);
typedef void(^TYRequestFailureBlock)(__kindof NSString* _Nullable msg, NSString* _Nullable code);

/**
  只针对于单个请求
 */

@interface TYBaseRequest (TYSingleRequestBlock)

- (void)request;
- (void)requestWithSuccessBlock:(TYRequestSuccessBlock _Nullable)successBlock;
- (void)requestWithSuccessBlock:(TYRequestSuccessBlock _Nullable)successBlock
                   failureBlock:(TYRequestFailureBlock _Nullable)failureBlock;

@end
