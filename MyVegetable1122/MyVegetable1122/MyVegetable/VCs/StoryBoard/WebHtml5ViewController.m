//
//  WebHtml5ViewController.m
//  MyVegetable
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 yunhoo. All rights reserved.
//

#import "WebHtml5ViewController.h"
#import "AccountJL.h"
@interface WebHtml5ViewController ()

@end

@implementation WebHtml5ViewController
@synthesize myCode;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden=YES;
    if (self.messTitle) {
        self.titleLable.text=self.messTitle;
    }
    if (self.url.length>0) {
        self.webView.delegate=self;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden=YES;
    [self getInvestCode];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
-(void)getInvestCode
{
    WDCAccount* a=[WDCUserManage getLastUserInfo] ;
    NSDictionary* dt=@{@"type":@"1",@"userId":a.userId==nil?@"":a.userId};
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HomePageYQM_NetWoring;
    request.requestParamDic = dt;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
if ([response.requestId isEqualToString:HomePageYQM_NetWoring]) {
    if ([response.responseCodeOriginal isEqualToString:@"1"]) {
        NSDictionary* data=[response.responseData objectForKey:@"data"];
        self.myCode=[data objectForKey:@"code"];
    }
}
}
-(void)transactionFailed:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.responseCodeOriginal isEqualToString:@"-99"]) {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 88;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark WebDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* str=[[request URL] absoluteString];
    if ([str rangeOfString:@"ios:"].location != NSNotFound) {
        NSArray* cutArray=[str componentsSeparatedByString:@"jsonStr="];
        NSString* jsdata=[cutArray objectAtIndex:1];
        if (cutArray.count>1) {
            NSError* err=[[NSError alloc]init];
            jsdata=[jsdata stringByReplacingOccurrencesOfString:@"%22" withString:@"\""];
            jsdata=[jsdata stringByReplacingOccurrencesOfString:@"%7B" withString:@"{"];
            jsdata=[jsdata stringByReplacingOccurrencesOfString:@"%7D" withString:@"}"];
            NSDictionary* dictb=[NSJSONSerialization JSONObjectWithData:[jsdata dataUsingEncoding:NSASCIIStringEncoding] options:NSJSONReadingMutableLeaves error:&err];
            NSString* function=[dictb objectForKey:@"functionId"];
            if ([function isEqualToString:@"10001"]) {
                [UMSocialData defaultData].extConfig.wechatSessionData.url=[NSString stringWithFormat:@"http://static.wdclc.cn/wx/pages/account/register.html?code=%@",self.myCode];
                [UMSocialData defaultData].extConfig.wechatSessionData.title=@"我的菜理财福利大放送，现金、红包、豪礼等你拿！";
                [UMSocialData defaultData].extConfig.wechatTimelineData.title=@"我的菜理财福利大放送，现金、红包、豪礼等你拿！";
                [UMSocialData defaultData].extConfig.wechatTimelineData.url=[NSString stringWithFormat:@"http://static.wdclc.cn/wx/pages/account/register.html?code=%@",self.myCode];
                [UMSocialData defaultData].extConfig.qqData.url=[NSString stringWithFormat:@"http://static.wdclc.cn/wx/pages/account/register.html?code=%@",self.myCode];
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:UMkey
                                                  shareText:[NSString stringWithFormat: @"邀请好友送30元现金，注册送5000元体验金，现金红包豪礼天天抽！http://static.wdclc.cn/wx/pages/account/register.html?code=%@",self.myCode]
                                                 shareImage:[UIImage imageNamed:@"X120"]
                                            shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,nil]
                                                   delegate:self];

                [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];

            }
            if ([function isEqualToString:@"10002"]) {//大转盘分享
                NSString* add=[NSString stringWithFormat:@"http://static.wdclc.cn/wx/pages/dial.html?code=%@",myCode];
                [UMSocialData defaultData].extConfig.wechatSessionData.url=add;
                [UMSocialData defaultData].extConfig.wechatTimelineData.url=add;
                [UMSocialData defaultData].extConfig.wechatSessionData.title=@"我的菜理财福利大放送，现金、红包、豪礼等你拿！";
                [UMSocialData defaultData].extConfig.wechatTimelineData.title=@"我的菜理财福利大放送，现金、红包、豪礼等你拿！";
                [UMSocialData defaultData].extConfig.qqData.url=add;
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:UMkey
                                                  shareText:[NSString stringWithFormat:@"注册送5000元体验金，邀请朋友送30元现金，还有现金红包豪礼天天抽！%@",add]
                                                 shareImage:[UIImage imageNamed:@"X120"]
                                            shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,nil]
                                                   delegate:self];

                [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
                WDCAccount* a=[WDCUserManage getLastUserInfo] ;
                NSDictionary* dt=@{@"type":@"1",@"userId":a.userId};
                [[HZMAPImanager shareMAPImanager] addDelegate:self];
                HZMRequest *request =[[HZMRequest alloc] init];
                request.requsetId = Activity_Connect;
                request.requestParamDic = dt;
                request.callBackDelegate = self;
                request.tag = 0;
                [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
                
            }
            if ([function isEqualToString:@"10003"]) {
                AccountJL *m = [[AccountJL alloc]init];
                //        UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:m];
                m.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:m animated:YES];
            }
            return NO;
        }
    }
    return YES;
}

-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    
}
@end
