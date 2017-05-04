//
//  TYBaseRequest+TYSingleRequestBlock.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseRequest+TYSingleRequestBlock.h"

@implementation TYBaseRequest (TYSingleRequestBlock)

- (void)request {
    [self requestWithSuccessBlock:nil];
}

- (void)requestWithSuccessBlock:(TYRequestSuccessBlock)successBlock {
    [self requestWithSuccessBlock:successBlock failureBlock:nil];
}

- (void)requestWithSuccessBlock:(TYRequestSuccessBlock)successBlock failureBlock:(TYRequestFailureBlock)failureBlock {
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *resultDict = request.responseObject;
        NSString *code = resultDict[@"code"];
        NSString *msg = resultDict[@"msg"];
        id data = resultDict[@"data"];
        if ([resultDict[@"code"] integerValue] == 1) {
            if (successBlock) {
                successBlock(data);
            }
        } else {
            if (failureBlock) {
                failureBlock(msg,code);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failureBlock) {
            failureBlock(@"",@"");
        }
    }];
}

@end
