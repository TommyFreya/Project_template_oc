//
//  TYInitializeConfigService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYInitializeConfigService.h"
#import <AFNetworkReachabilityManager.h>
#import <YTKNetwork.h>
#import "TYRouteService.h"

@implementation TYInitializeConfigService

+ (void)setUp {
    // network
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"xxxxxxxxxxxxxxxx";
    
    // route
    [TYRouteService registerRouteDefault];
}

@end
