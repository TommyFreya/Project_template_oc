//
//  GVUserDefaults+TYGlobalProperties.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "GVUserDefaults+TYGlobalProperties.h"

@implementation GVUserDefaults (TYGlobalProperties)

@dynamic notFirstEnterApp;
@dynamic baseUrlKeyType;

- (NSDictionary *)setupDefaults {
    return @{
             @"notFirstEnterApp" : @0,
             @"baseUrlKeyType" : @0,
             };
}

@end
