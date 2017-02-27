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
    [configuration.userContentController addScriptMessageHandler:self name:@"HeadLineImg"];
    [configuration.userContentController addScriptMessageHandler:self name:@"AttentionBtn"];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView = webView;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"]]];
    [self.view addSubview:webView];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //    NSLog(@"%@", message.name);
    //    NSLog(@"%@", message.body);
    
    
    if ([message.name isEqualToString:@"HeadLineImg"]) {
        NSLog(@" ----  HeadLineImg  跳转控制器");
        
    }else  if ([message.name isEqualToString:@"AttentionBtn"]) {
        
        NSLog(@" ----  AttentionBtn   %@", message.body[@"body"]);
        NSString *btnTitcle = message.body[@"body"];
        if ([btnTitcle isEqualToString:@"关注"]) {
            [self.webView evaluateJavaScript:@"var btn =  document.getElementsByClassName('attention')[0]; btn.innerText = '已关注';" completionHandler:nil];
        }else{
            
            [self.webView evaluateJavaScript:@"var btn =  document.getElementsByClassName('attention')[0]; btn.innerText = '关注';" completionHandler:nil];
        }
    }
}



- (void)dealloc
{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"HeadLineImg"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"AttentionBtn"];
}

@end
