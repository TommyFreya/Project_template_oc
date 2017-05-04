//
//  TYNetworkService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TYNetworkBaseUrlType) {
    TYNetworkBaseUrlTypeTest = 0,            // 测试环境
    TYNetworkBaseUrlTypeDeveloper = 1,       // 预发布环境
    TYNetworkBaseUrlTypeDistribution = 2     // 生产环境
};

@interface TYNetworkService : NSObject

+ (NSString *)baseUrl;

@end
