//
//  ViewController.m
//  demoWKwebView
//
//  Created by 高崇 on 17/2/27.
//  Copyright © 2017年 LieLvWang. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKScriptMessageHandler, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSLog(@"%@", configuration.userContentController);
    
    [configuration.userContentController addScriptMessageHandler:self name:@"OCJSHelper"];
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView = webView;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"]]];
    [self.view addSubview:webView];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%s", __func__);
    NSLog(@"%@", message.name);
    NSLog(@"%@", message.body);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"login();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result = %@", result);
        NSLog(@"error = %@", error);
    }];
}

- (void)dealloc
{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"OCJSHelper"];
}

@end
