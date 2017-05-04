//
//  NSString+TYOpenLink.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "NSString+TYOpenLink.h"
#import "UIViewController+TYTopView.h"

@implementation NSString (TYOpenLink)

- (void)call {
    NSString *allString = self;
    if (![self hasPrefix:@"tel:"]) {
        allString = [@"tel:" stringByAppendingString:self];
    }
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:allString]]];
    [[UIViewController topViewController].view addSubview:callWebview];
}

// 打开 url
- (void)openUrl {
    NSURL *url = [NSURL URLWithString:self];
    
    //打开url
    [[UIApplication sharedApplication] openURL:url];
}

@end
