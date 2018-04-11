//
//  MyTabBarController.m
//  LoveXianMian
//
//  Created by 蒋孝才 on 15/7/1.
//  Copyright (c) 2015年 蒋孝才. All rights reserved.
//

#import "MainTabbarController.h"
#import "HomePageVC.h"
#import "FinancingVC.h"
#import "AccountVC.h"
#import "HelpVC.h"
#import "UIViewControllerFactory.h"

@interface MainTabbarController ()<UITabBarControllerDelegate,UITabBarDelegate>
@end
@implementation MainTabbarController
- (id)initWith:(NSInteger)num {
    if (self = [super init]) {
        
//        self.num = num;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isfrom=1;
    [self createTabBarControllers];
    [self setTabBarItems];
    [self checkNetWork];
    self.delegate = self;
    
    if (self.isfrom == 1) {//首页
        self.selectedIndex =0;
        self.selectedViewController = self.viewControllers[0];
    } else if(self.isfrom == 2||self.isfrom>98){//理财
        self.selectedIndex =1;
        self.selectedViewController = self.viewControllers[1];
    }else if(self.isfrom == 3){
        self.selectedIndex =2;
        self.selectedViewController = self.viewControllers[2];
    }else if(self.isfrom == 4){
        
    }
    //[Tool setObject:@"0" forKey:JIsLoginUser];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isfrom == 1) {//首页
//        self.selectedIndex =0;
//        self.selectedViewController = self.viewControllers[0];
    } else if(self.isfrom == 2||self.isfrom>98){//理财
        self.selectedIndex =1;
        self.selectedViewController = self.viewControllers[1];
        if (self.isfrom>98) {
            UIViewController*cpc=self.viewControllers[1];
            cpc.view.tag=self.isfrom;
        }
    }else if(self.isfrom == 3){//账户
        self.selectedIndex =2;
        self.selectedViewController = self.viewControllers[2];
    }else if(self.isfrom == 4){
        
    }
    self.navigationController.navigationBarHidden=NO;
}
#pragma mark 导航控制器包装视图控制器
- (void)createTabBarControllers{
    //首页
    UINavigationController *navXM1=nil;
//    CGSize s=[[UIScreen mainScreen] currentMode].size;
    
    if (iPhone6P) {
        P6HomePageViewController* p6=[UIViewControllerFactory getViewController:P6_HomePage];
        navXM1=[[UINavigationController alloc]initWithRootViewController:p6];
    }else{
    HomePageVC *xmvc =  [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
//    xmvc.urlStr = LIMITURL;//页面接口网址
        navXM1 = [[UINavigationController alloc]initWithRootViewController:xmvc];
    }
    //理财
    FinancingVC*cpc=  [[FinancingVC alloc]initWithNibName:@"FinancingVC" bundle:nil];
    if (self.isfrom>98) {
        cpc.num=self.isfrom;
    }
//    cpc.num = self.num;
//    cpc.urlStr = SALEURL;//页面接口网址
    
    UINavigationController *navCP2 = [[UINavigationController alloc]initWithRootViewController:cpc];
    //账户
    AccountVC*fc=  [[AccountVC alloc]initWithNibName:@"AccountVC" bundle:nil];
//    fc.urlStr = FREEURL;//页面接口网址
    UINavigationController *navF3 = [[UINavigationController alloc]initWithRootViewController:fc];
    //帮助
    HelpVC *svc = [[HelpVC alloc]initWithNibName:@"HelpVC" bundle:nil];
    UINavigationController *navST4 = [[UINavigationController alloc]initWithRootViewController:svc];

    
    self.viewControllers=@[navXM1,navCP2,navF3,navST4];
    
}
#pragma mark 设置分栏元素:文字图片
-(void)setTabBarItems{
    // 文字数组
    NSArray *titleArr=@[@"首页",@"理财",@"账户",@"帮助"];
    // 普通图片名数组
    NSArray *normalImgArr = @[@"shouye-hui.png",
                              @"licai-hui",
                              @"zhanghu-hui",
                              @"help-hui" ];
    // 被选中时图片名数组
    NSArray *selectedImgArr = @[@"shouye-red.png",
                                @"licai-red",
                                @"zhanghu-red",
                                @"help-red" ];
    // 循环设置tabbarItem的文字，图片
    for (int i=0; i< 4; i++) {
        UIViewController *vc=self.viewControllers[i];
        //填充图片
        UIImage *img=[UIImage imageNamed:selectedImgArr[i]];
        //重置图片大小
        img = [self reSizeImage:img toSize:CGSizeMake(22, 22)];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imgg=[UIImage imageNamed:normalImgArr[i]];
        
        
        imgg = [self reSizeImage:imgg toSize:CGSizeMake(22, 22)];
        imgg = [imgg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem=[[UITabBarItem alloc]initWithTitle:titleArr[i] image:imgg selectedImage:img];
        [vc.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"ding-beijing"]];
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);//title上移一些
        
//        [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(3, 3, 3,3)];
        
//        [[UITabBarItem appearance] setImageInsets:UIEdgeInsetsMake(3, 3, 3,3)];
//        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        
//        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    }
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    // [UITabBarItem appearance] 获取全局TabBarItem
//    [[UITabBarItem  appearance] setImageInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [[UITabBarItem  appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_red} forState:UIControlStateSelected];//设置TabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TabBarItemFontSize]} forState:UIControlStateNormal];//设置
////    nav字体颜色:为何没有用？？？？？
//     [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:NavFontSize],NSForegroundColorAttributeName:[UIColor redColor]}];//设置Navi导航栏字体大小\字体颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:NavFontSize]}];
    
    
}


- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContextWithOptions(reSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;}




#pragma mark - 网络-检测网络
- (void)checkNetWork{
    // 初始化网络检测者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开启网络检测
    [manger startMonitoring];
    //设置返回数据
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [Tool setBool:NO forKey:JIsNetWorking];
                //                [self creatUI];
                break;
            case AFNetworkReachabilityStatusUnknown:
                [Tool setBool:YES forKey:JIsNetWorking];
                //                [self creatUI];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://34G
                [Tool setBool:YES forKey:JIsNetWorking];
                //                [self creatUI];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://wifi
                [Tool setBool:YES forKey:JIsNetWorking];
                //                [self creatUI];
                break;
            default:
                break;
        }
    }];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //拦截账户的点击事件
    UIViewController *v = [self.viewControllers objectAtIndex:2];
    if(v == viewController){
        if (![[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
            LoginVC *l = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
            l.hidesBottomBarWhenPushed = YES;
            l.isFrom = 66;
            UINavigationController *ll = [[UINavigationController alloc] initWithRootViewController:l];
            //l.nc=self.navigationController;
            [self presentViewController:ll animated:YES completion:nil];
//            [self.navigationController pushViewController:l animated:YES];
            return NO;
        }else
        return YES;
        
    }else
        
        return YES;
        
    
    
}












@end
