//
//  TYBaseWebViewController.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYBaseWebViewController.h"
#import <Masonry.h>

static NSString *const kJsToNativeMethod = @"jsObj";

@interface TYBaseWebViewController ()

// 网页标题
@property (copy, nonatomic) NSString *titleName;
@property (strong, nonatomic) UIProgressView *requestProgressView;
@property (copy, nonatomic) NSString *finalUrl;

@end

@implementation TYBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createWkWebview];
    
    self.titleName = self.params[@"title"];
    [self loadWebWithUrl:self.params[@"urlString"]];
    self.finalUrl = self.params[@"urlString"];
}


#pragma mark - Subclass Override Methos
- (void)loadWebWithUrl:(NSString *)urlString {
    // 加载网页资源
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}


#pragma mark - WKScriptMessageHandler Methods
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //这里就是使用高端配置，js调用native的处理地方。我们可以根据name和body，进行桥协议的处理。
    NSString *messageName = message.name;
    NSLog(@" messageName = %@",messageName);
}


#pragma mark - WKNavigationDelegate Methods
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.requestProgressView setProgress:0.0 animated:NO];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    
    NSString *requestString = [navigationAction.request.URL absoluteString];
    NSLog(@" requestString = %@",requestString);
//    if ([requestString hasPrefix:[TJMBaseUrlConfigService getBaseUrl]] && ![requestString isEqualToString:_finalUrl] && _finalUrl) {
//        if ([self.navigationItem.leftBarButtonItems count] > 1) {
//            
//        } else {
//            // 关闭 --> Pop    <- 则是 webview back 最后一个 <- 才会是 Pop
//            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickWebBackForntWeb:)];
//            UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector( clickBackToRecordViewController:)];
//            self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
//        }
//    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //一个页面没有被完全加载之前收到下一个请求，此时迅速会出现此error,error=-999
    //此时可能已经加载完成，则忽略此error，继续进行加载。
    // 根据”一个页面没有被完全加载之前收到下一个请求“这句话，我猜测到我的代码中出现此问题的原因：在发请求之前先取消了上次的请求，注释取消先前请求的代码果然就解决了问题。
    //http://stackoverflow.com/questions/1024748/how-do-i-fix-nsurlerrordomain-error-999-in-iphone-3-0-os
    if([error code] == NSURLErrorCancelled) {
        return;
    }
}


#pragma mark - WKUIDelegate Methods
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Action Methods
- (void)clickBackToRecordViewController:(UIBarButtonItem *)barItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickWebBackForntWeb:(UIBarButtonItem *)barItem {
    if ([_wkWebView.backForwardList.backList count] == 1) {
        self.navigationItem.leftBarButtonItem = nil;
        [self createLeftBarButtonItem];
    }
    [_wkWebView goBack];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == _wkWebView) {
            self.requestProgressView.hidden = _wkWebView.estimatedProgress == 1.0;
            [self.requestProgressView setProgress:_wkWebView.estimatedProgress animated:YES];
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]){
        if (object == _wkWebView) {
            self.navigationItem.title = _titleName ?: (_wkWebView.title ?: @"天玑金服");
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        // Make sure to call the superclass's implementation in the else block in case it is also implementing KVO
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - Intial Methods
- (void)createWkWebview {
    self.wkWebView = ({
        //创建配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];    // 创建UserContentController(提供javaScript向webView发送消息的方法)
        WKUserContentController *userContent = [[WKUserContentController alloc] init];    // 添加消息处理，注意：self指代的是需要遵守WKScriptMessageHandler协议，结束时需要移除
        
        // http://stackoverflow.com/questions/31094110/memory-leak-when-using-wkscriptmessagehandler  内存泄露问题
        
        TYWeakScriptMessageHandler *headler = [[TYWeakScriptMessageHandler alloc] init];
        headler.scriptMessageHandler = self;
        [userContent addScriptMessageHandler:headler name:kJsToNativeMethod];                // 将UserContentController设置到配置文件中
        
        configuration.userContentController = userContent;                                // 高端的自定义配置创建WKWebView
        if ([configuration respondsToSelector:@selector(websiteDataStore)]) {
            configuration.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
        }
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:configuration];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        webView;
    });
    
    self.requestProgressView = ({
        UIProgressView *progressView = [UIProgressView new];
        progressView.progressTintColor = TY_THEME.main_color_00;
        progressView.trackTintColor = TY_THEME.weak_color_13;
        [self.view addSubview:progressView];
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(@2);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
        progressView;
    });
    
    //  监控进度条
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //  监控文章标题
    [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)createLeftBarButtonItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"header-back") style:UIBarButtonItemStylePlain target:self action:@selector(clickBackToRecordViewController:)];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkWebView removeObserver:self forKeyPath:@"title"];
    [_wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kJsToNativeMethod];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
