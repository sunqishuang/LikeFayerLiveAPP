//
//  SUN_WKWebViewController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_WKWebViewController.h"

#import <WebKit/WebKit.h>

@interface SUN_WKWebViewController ()

@end

@implementation SUN_WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;

    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, K_Width, K_Height ) configuration:config];
    
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_UrlStr]]];

    NSLog(@"url === %@",_UrlStr);



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
