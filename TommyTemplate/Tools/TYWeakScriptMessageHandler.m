//
//  TYWeakScriptMessageHandler.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYWeakScriptMessageHandler.h"

@implementation TYWeakScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptMessageHandler userContentController:userContentController didReceiveScriptMessage:message];
}

- (void)dealloc {
    NSLog(@"weakScriptMessageHandler dealloc");
}


@end
