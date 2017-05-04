//
//  GVUserDefaults+TYGlobalProperties.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "GVUserDefaults.h"

@interface GVUserDefaults (TYGlobalProperties)

// 是否第一次进入 App
@property (nonatomic, assign, getter=isNotFirstEnterApp) BOOL notFirstEnterApp;
// 当前API网络环境类型
@property (nonatomic, assign) NSInteger baseUrlKeyType;

@end
