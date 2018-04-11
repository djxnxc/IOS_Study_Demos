//
//  AppDelegate.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/11.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarController.h"
//#import "PasswordGestureViewController.h"
#import "WDCUserManage.h"
//#import "WDCAccount.h"
//extern WDCAccount *g_account;
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "Tool.h"


@interface AppDelegate ()
{
    NSInteger _isBackground;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = RGB_gray;
    
    
    // 设置window的根控制器
    // 判断当前版本是否是新版本.
    // 取出当前应用信息字典
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 取出当前应用版本号
    NSString *currentVersion = [infoDict objectForKey:(NSString *)kCFBundleVersionKey];
    
    // 取出沙盒存储的应用版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    
    // 判断应用程序是否是第一次进入：通过比对沙盒中的应用
//    if (![currentVersion isEqualToString:saveVersion]) {// 如果是第一次进入新版本,进入介绍页面
//        [Tool setObject:currentVersion forKey:@"version"];//【用JTool类来封装方法：数据存入沙盒。】
//        [self gotoScrollView];
//    } else { // 否则，直接进入TabbarController
//        [self gotoTabbarController];
//    }
    
    [self.window makeKeyAndVisible];
    
    //获取用户信息
//    g_account = [WDCUserManage getLastUserInfo];
//    if (!g_account) {
//        g_account = [[WDCAccount alloc] init];
//    }
    
    
    //友盟
    //设置在友盟注册的appkey：
    //[Tool setObject:@"0" forKey:JIsLoginUser];
    [UMSocialData setAppKey:UMkey];
//    [UMSocialWechatHandler setWXAppId:@"wxbd41355462c67443" appSecret:@"2b02a9527228a7b2768262b55e16d479" url:@"http://www.umeng.com/social"];
    
//    [MobClick startWithAppkey:UMkey reportPolicy:BATCH   channelId:@"Web"];
//    /AppID：wxbd41355462c67443
//    AppSecret：2b02a9527228a7b2768262b55e16d479
    [UMSocialWechatHandler setWXAppId:@"wxbd41355462c67443" appSecret:@"2b02a9527228a7b2768262b55e16d479" url:@"http://static.wdclc.cn/wx/pages/dial.html"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1104935455" appKey:@"oOR5IDPZpiOVrnHb" url:@"http://static.wdclc.cn/wx/pages/dial.html"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
    //[UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2437988923" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //[UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2437988923" RedirectURL:@"http://www.wdclc.cn"];
    //8806a86cec0b851a9f53a58d11f15404
    /*if ([[Tool objectForKey:JIsSetSecretShoushi] boolValue]) {
        
    PasswordGestureViewController *l = [[PasswordGestureViewController alloc]init];
    l.hidesBottomBarWhenPushed = YES;
    l.isfrom = 21;
    l.state=SSFPasswordGestureViewStateCheck;
    self.window.rootViewController = l;
    _isBackground =0;
    }else{*/
    //[self.navigationController pushViewController:l animated:YES];
//[Tool setObject:@"0" forKey:JIsLoginUser];
    MainTabbarController* main=[[MainTabbarController alloc]init];
    self.window.rootViewController=main;
    //}
    
    return YES;
}

#pragma mark - 进入（goto）介绍页面
- (void)gotoScrollView {
}

#pragma mark 进入（goto）主页面
- (void)gotoTabbarController {
    
//    [UIView animateWithDuration:0.8f animations:^{
    
//        _scrollView.alpha = 0.2f;
        
//    } completion:^(BOOL finished) {
//        [_scrollView removeFromSuperview];
//        [_pc removeFromSuperview];
        MainTabbarController *tabVC = [[MainTabbarController alloc] init];
        self.window.rootViewController = tabVC;
//    }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
//    即将进入后台
   // [Tool setObject:@"0" forKey:JIsLoginUser];
}

//    已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    _isBackground = 9;
    [[NSNotificationCenter defaultCenter]postNotificationName:IN_BACKGROUND object:nil];
    
    
}

 //    即将进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
    BOOL flag=[Tool boolForKey:JIsSetSecretShoushi];
    if (_isBackground == 9&&[Tool boolForKey:JIsSetSecretShoushi]) {
        [Tool setObject:@"0" forKey:JIsLoginUser];
        MainTabbarController* main=[[MainTabbarController alloc]init];
        self.window.rootViewController=main;
//        PasswordGestureViewController *l = [[PasswordGestureViewController alloc]init];
//        l.hidesBottomBarWhenPushed = YES;
//        l.isfrom = 21;
//        l.state=SSFPasswordGestureViewStateCheck;
//        self.window.rootViewController = l;
//        _isBackground =0;
    }*/
    
    
    
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //    已经进入前台
}

- (void)applicationWillTerminate:(UIApplication *)application {
//即将推出
}

@end
