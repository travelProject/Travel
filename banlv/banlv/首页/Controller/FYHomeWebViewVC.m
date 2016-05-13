//
//  FYHomeWebViewVC.m
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYHomeWebViewVC.h"

@interface FYHomeWebViewVC () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *homeWebview;

@end

@implementation FYHomeWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求地址
    NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];//对网址进行编码,防止含有中文
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.homeWebview = [[UIWebView alloc] init];
    self.homeWebview.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    self.homeWebview.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1.0];
    
    [self.homeWebview loadRequest:request];
    
    self.homeWebview.delegate = self;
    
    self.homeWebview.scalesPageToFit = YES;
    
    [self.view addSubview:self.homeWebview];
}

#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    CYLog(@"网页加载失败:%@",error);
}


//setter方法
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
