//
//  DetailWebViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/6.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "DetailWebViewController.h"
#import <WebKit/WebKit.h>

@interface DetailWebViewController () <WKNavigationDelegate,WKUIDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation DetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 右侧按钮标题
    self.navigationItem.title = @"详情";
    
    // WKWebView
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strURL]]];
    wkWeb.allowsBackForwardNavigationGestures = YES;    // 允许手势滑动返回
    [self.view addSubview:wkWeb];
    
    wkWeb.navigationDelegate = self;
    wkWeb.UIDelegate = self;
    
}

//
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //    NSLog(@"开始加载的回调函数");
}

//
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    //    NSLog(@"内容返回的回调函数");
}

//
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //    NSLog(@"加载完事的回调函数");
}

//
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败: %@",error.description);
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
