//
//  TYNetworkService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYNetworkService.h"

@implementation TYNetworkService

+ (NSString *)baseUrl {
    TYNetworkBaseUrlType type = (TYNetworkBaseUrlType)[GVUserDefaults standardUserDefaults].baseUrlKeyType;
    return [self p_getBaseUrlWithType:type];
    
}


#pragma mark - Private Methods
+ (NSString *)p_getBaseUrlWithType:(TYNetworkBaseUrlType)type {
    
    if (!IS_ONLINE_ENVIRONMENT) {
        return @"";
    }
    
    switch (type) {
        case TYNetworkBaseUrlTypeTest:
            return @"";
            break;
        case TYNetworkBaseUrlTypeDeveloper:
            return @"";
            break;
        case TYNetworkBaseUrlTypeDistribution:
            return @"";
            break;
            
        default:
            break;
    }
}


@end
