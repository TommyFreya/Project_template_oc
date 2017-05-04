//
//  TYBaseWebViewController.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseViewController.h"
#import <WebKit/WebKit.h>
#import "TYWeakScriptMessageHandler.h"

@interface TYBaseWebViewController : TYBaseViewController <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *wkWebView;

@end
