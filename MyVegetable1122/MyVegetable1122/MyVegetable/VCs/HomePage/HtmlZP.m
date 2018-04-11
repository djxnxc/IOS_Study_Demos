//
//  HtmlZP.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/30.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "HtmlZP.h"

@interface HtmlZP ()<UISearchBarDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HtmlZP

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.address) {
        [self loadString:self.address];
    }else{
        [self loadString:@"http://static.wdclc.cn/wx/pages/account/service-agreement.html"];
    }
    if (self.webTitle) {
        //self.navigationController.title=self.webTitle;
        self.title=@"用户协议";
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (From1(self)|From2(self)) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backa) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}
- (void)loadString:(NSString *)str
{
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = str;
//    if (![str hasPrefix:@"https://"]) {
//        urlStr = [NSString stringWithFormat:@"https://m.baidu.com/s?word=%@", str];
//    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@", searchBar.text);
    [self loadString:searchBar.text];
    
    [self.view endEditing:YES];
}


#pragma mark - WebView代理方法


#pragma mark 完成加载,页面链表数据会更新
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 根据webView当前的状态,来判断按钮的状态
//    self.backButton.enabled = webView.canGoBack;
//    self.forwarButton.enabled = webView.canGoForward;
}
#pragma mark - WebView的代理方法
#pragma mark 是否允许加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    
    if ( [[url scheme] isEqualToString:@"myapp"] )
    {
        NSString *slug = [url path];
        [self performSegueWithIdentifier:@"heroSegue" sender:slug];
        return NO;
    }
   
    
    NSLog(@"是否允许加载");
    return YES;
}
#pragma mark 已经开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"已经开始加载");
}
#pragma mark 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败_error:%@",error);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
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
