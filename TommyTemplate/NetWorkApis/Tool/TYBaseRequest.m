//
//  TYBaseRequest.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseRequest.h"
#import "AFURLResponseSerialization.h"
#import "UIViewController+TYTopView.h"
#import "TYAnimatingRequestAccessory.h"

@implementation TYBaseRequest {
    NSDictionary *_parame;
}

- (id)initWithParame:(NSDictionary *)parame {
    self = [super init];
    if (self) {
        _parame = parame;
    }
    return self;
}

- (NSDictionary *)p_filterWithParames:(NSDictionary *)parames{
    
    NSDictionary *paramDic = parames;
    
//    if ([self isNeedParameToken]) {
//        NSString *token = [GVUserDefaults standardUserDefaults].token;
//        if (STRING_IS_NOTNIL_NOTEMPTY(token) ) {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parames];
//            [dic setValue:token forKey:kToken];
//            paramDic = dic;
//        }
//    }
    
    return paramDic;
}

#pragma mark - YTKBaseRequest Override
- (id)requestArgument {
    return [self p_filterWithParames:_parame];
}


- (NSTimeInterval)requestTimeoutInterval {
    return 120;
}

// 默认使用json格式请求
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

//这里暂不考虑JSONModel解析错误的问题

- (void)requestFailedPreprocessor
{
    // NOTE: 子类如需继承，必须必须调用 [super requestFailedPreprocessor];
    NSError * error = self.error;
    
    if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain])
    {
        //AFNetworking处理过的错误
        
    }else if ([error.domain isEqualToString:YTKRequestValidationErrorDomain])
    {
        //猿题库处理过的错误
        
    }else{
        //系统级别的domain错误，无网络等[NSURLErrorDomain]
        //根据error的code去定义显示的信息，保证显示的内容可以便捷的控制
    }
}

- (void)requestFailedFilter {
}


#pragma mark - Setter & Getter
- (void)setNeedLoading:(BOOL)needLoading {
    _needLoading = needLoading;
    if (_needLoading) {
        self.animatingText = @"loading";
        self.animatingView = [UIViewController topViewController].view;
    }else {
        self.animatingView = nil;
    }
}

@end
