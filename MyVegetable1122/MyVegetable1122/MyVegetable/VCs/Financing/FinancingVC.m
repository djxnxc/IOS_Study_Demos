//
//  FinancingVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/11.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "FinancingVC.h"
#import "SubOneVC.h"
#import "SubTwoVC.h"
#import "SubThreeVC.h"
#import "MainSetting.h"
#import "MainTabbarController.h"
#import "HomePageVC.h"
#import "AccountVC.h"
#import "HelpVC.h"
#import "BuyOne.h"
#import "DingLICAIModel.h"
@interface FinancingVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,HZMAPIManagerDelegate>
{
    UIPageViewController *_pageViewController;
    //数据源
    NSMutableArray *_vcArray;
    //标识当前页
    NSInteger _curPage;
    //标题scrollView
    UIScrollView *_titleScrollView;
    //指示当前页
    UIView *_indicatorView;
    SubTwoVC *_sub2;
    UIScrollView* svIn;
}
@property (weak, nonatomic) IBOutlet UIView *indView;
@property (weak, nonatomic) IBOutlet UIView *contetnView;




@end

@implementation FinancingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"理财";
//    [self getProduct];
    [self configUI];
    
    
    //创建子页
    [self initData];
    [self configTitleScrollView];
    [self configPageViewController];
    
    
    if ([Tool objectForKey:@"huoqi_tiaohuilicaiyemian__99_101"]) {
        self.num = [[Tool objectForKey:@"huoqi_tiaohuilicaiyemian__99_101"]intValue];
    }
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(NotificationZhangHu:) name:JNotificationZhangHu object:nil];
    [center addObserver:self selector:@selector(NotificationZhangHuu:) name:JNotificationZhangHuWDHQi object:nil];
}
- (void)NotificationZhangHu:(NSNotification*)notification{
    NSDictionary *nameDictionary = [notification userInfo];
    [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
    [Tool setObject:[nameDictionary objectForKey:@"s"] forKey:@"huoqi_tiaohuilicaiyemian__99_101"];
}
- (void)NotificationZhangHuu:(NSNotification*)notification{
    NSDictionary *nameDictionary = [notification userInfo];
    [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
    [Tool setObject:[nameDictionary objectForKey:@"s"] forKey:@"huoqi_tiaohuilicaiyemian__99_101"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[Tool objectForKey:@"ojp"] isEqualToString:@"99"]) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = 100+0;
        UIButton *btn = [self.view viewWithTag:100];
        [self changePage:btn];
        [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
        [Tool setObject:@"0" forKey:@"ojp"];
    }else if ([[Tool objectForKey:@"ojp"] isEqualToString:@"101"]){
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = 100+2;
        UIButton *btn = [self.view viewWithTag:102];
        [self changePage:btn];
        [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
        [Tool setObject:@"0" forKey:@"ojp"];
    }else if (self.num == 0) {//定期
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = 100+1;
        UIButton *btn = [self.view viewWithTag:101];
        [self changePage:btn];
        [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
    }else if (self.num==99){//活期
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = 100+0;
        UIButton *btn = [self.view viewWithTag:100];
        [self changePage:btn];
        [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
    }else if (self.num == 101){//新手标
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = 100+2;
        UIButton *btn = [self.view viewWithTag:102];
        [self changePage:btn];
        [Tool removeObjectForKey:@"huoqi_tiaohuilicaiyemian__99_101"];
    }
    
    //    显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    }
    
    
    if (self.isfrom) {
        
        MainTabbarController *selff = [[MainTabbarController alloc] init];
        //首页
        UINavigationController *navXM1=nil;
        if (iPhone6P) {
            P6HomePageViewController* p6=[UIViewControllerFactory getViewController:P6_HomePage];
            navXM1=[[UINavigationController alloc]initWithRootViewController:p6];
        }else{
            HomePageVC *xmvc =  [[HomePageVC alloc]init];
            //    xmvc.urlStr = LIMITURL;//页面接口网址
            navXM1 = [[UINavigationController alloc]initWithRootViewController:xmvc];
        }
        //理财
        FinancingVC*cpc=  [[FinancingVC alloc]init];
        //    cpc.urlStr = SALEURL;//页面接口网址
        UINavigationController *navCP2 = [[UINavigationController alloc]initWithRootViewController:cpc];
        //账户
        AccountVC*fc=  [[AccountVC alloc]init];
        //    fc.urlStr = FREEURL;//页面接口网址
        UINavigationController *navF3 = [[UINavigationController alloc]initWithRootViewController:fc];
        //帮助
        HelpVC *svc = [[HelpVC alloc]init];
        UINavigationController *navST4 = [[UINavigationController alloc]initWithRootViewController:svc];
        
        selff.viewControllers=@[navXM1,navCP2,navF3,navST4];
        
        
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
            UIViewController *vc=selff.viewControllers[i];
            //填充图片
            UIImage *img=[UIImage imageNamed:selectedImgArr[i]];
            //图片填充模式 imageWithRenderingMode设置渲染模式
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            vc.tabBarItem=[[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:img];

        }

        [[UITabBarItem  appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_red} forState:UIControlStateSelected];//设置TabBarItem字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TabBarItemFontSize]} forState:UIControlStateNormal];//设置
        [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:NavFontSize]}];
    }
 
//    [self getProduct];
    
}
#pragma - 创建通用UI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    立即抢购
//    self.qiangouBtn.layer.cornerRadius = self.qiangouBtn.bounds.size.height/2;
//    self.qiangouBtn.layer.masksToBounds = YES;
//    [self.qiangouBtn setBackgroundColor:RGB_red];
}
- (UIButton *)createButtonWithTitle:(NSString *)title backImgName:(NSString *)imgName frame:(CGRect)frame titleColor:(UIColor *)color{
    UIButton *Btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitleColor:color forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    Btn.frame = frame;
    return Btn;
}

#pragma mark - 交互
- (void)jumpCate {
    
}
- (void)jumpSet {
   
   
}
- (void)jump {
    
}


#pragma mark - 网络 获取定期产品信息
- (void)getProduct {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"3",@"type",nil];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HomePageCPGYdetail_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:HomePageCPGYdetail_NetWoring]) {//产品
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSArray *arr = [response.responseData objectForKey:@"data"];
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                static int i = 0;
                BuyModel *m =[[BuyModel alloc] init];
                [m setValuesForKeysWithDictionary:dic];
                
                DingLICAIModel *d = [[DingLICAIModel alloc] init];
                d.model = m;
                d.ID = i;
                i++;
                [data addObject:d];
            }
//            _sub2.productData = data;
            
        }
        
    }
}
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.responseCodeOriginal isEqualToString:@"-99"]) {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}




#pragma mark - 创建pageVC
- (void)initData{
    //创建数据源
    _vcArray = [NSMutableArray array];
    SubOneVC *sub1 = [[SubOneVC alloc]init];
    sub1.pageNum = 0;
    sub1.fathers=self.navigationController;
    
    [_vcArray addObject:sub1];
    _sub2 = [[SubTwoVC alloc]init];
    _sub2.pageNum = 0;
    _sub2.nc=self.navigationController;
    [_vcArray addObject:_sub2];
    SubThreeVC *sub3 = [[SubThreeVC alloc]init];
    sub3.pageNum = 0;
    sub3.nc=self.navigationController;
    [_vcArray addObject:sub3];
    
}
- (void)configTitleScrollView {
    CGFloat w = JSCREEN_W;
//    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 40)];
//    _indicatorView.backgroundColor = [UIColor clearColor];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_indicatorView.bounds.size.width-20)/2, (_indicatorView.bounds.size.height-11), 16, 9)];
//    btn.backgroundColor = [UIColor clearColor];
//    [btn setImage:[UIImage imageNamed:@"financing_sanjiao"] forState:UIControlStateNormal];
//    [_indicatorView addSubview:btn];
//    _indicatorView.alpha = 1;
//    [_titleScrollView addSubview:_indicatorView];
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(self.indView.frame.origin.x, self.indView.frame.origin.y, w, self.indView.frame.size.height);
    _titleScrollView.backgroundColor = [UIColor colorWithRed:222/255.0 green:59/255.0 blue:51/255.0 alpha:1];
    
    for (int i = 0; i<_vcArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(w/_vcArray.count*i, 0, w/_vcArray.count, 55);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:RGB(253, 179, 153, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        UIImageView *sanjiaoImageV = [[UIImageView alloc]initWithFrame: CGRectMake(w/_vcArray.count*i, 41, w/_vcArray.count, 15)];
        sanjiaoImageV.tag = 1000+i;
        sanjiaoImageV.contentMode = UIViewContentModeScaleAspectFit;
        sanjiaoImageV.image =[UIImage imageNamed:@"financing_sanjiao"];
        if (i==0){
            [btn setTitle:@"活期" forState:UIControlStateNormal];
        }
        if (i==1){
            [btn setTitle:@"定期" forState:UIControlStateNormal];
        }
        if (i==2){
            [btn setTitle:@"新手标" forState:UIControlStateNormal];
        }
        sanjiaoImageV.hidden = YES;
        [_titleScrollView addSubview:sanjiaoImageV];
        [_titleScrollView addSubview:btn];
    }
    _titleScrollView.bounces = NO;
    [self.view addSubview:_titleScrollView];
    
   
    
}
- (void)configPageViewController {
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 0, self.contetnView.frame.size.width, self.contetnView.frame.size.height);
    _pageViewController.view.backgroundColor = RGB_gray;
    [self.contetnView addSubview:_pageViewController.view];
    
    
    //找到pageViewController view的scrollview，并将其代理设为self
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)view).delegate = self;
            svIn=(UIScrollView *)view;
            svIn.scrollEnabled=NO;
        }
    }
}
#pragma mark - PageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //查找当前界面viewcontroller是数组中第几个
    NSInteger index = [_vcArray indexOfObject:viewController];
    
    if (index == _vcArray.count-1) {
        return nil;
    }
    //返回下一页
    return _vcArray[index+1];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //返回上一页的界面
    NSInteger index = [_vcArray indexOfObject:viewController];
    //viewController也可以返回_vcArray[11]
    if (index == 0) {
        return nil;
    }
    return _vcArray[index-1];
}
//翻页结束处罚的代理方法
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    for (UIView *v in _titleScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *s = (UIButton *)v;
            s.selected = NO;
        }
    }
    
    //获取当前页数
    UIViewController *sub = pageViewController.viewControllers[0];
    NSInteger index = [_vcArray indexOfObject:sub];
    _curPage = index;
    for (UIView *v in _titleScrollView.subviews) {
        if (v.tag == index+100) {
            UIButton *s = (UIButton *)v;
            s.selected = YES;
        }
    }
    
}
//跳转到对应的页面
- (void)changePage:(UIButton *)btn
{
    for (UIView *v in _titleScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *s = (UIButton *)v;
            UIImageView *sanjiao = (UIImageView *)[_titleScrollView viewWithTag:s.tag-100+1000];
            if (sanjiao) {
                sanjiao.hidden = YES;
                
            }
            s.selected = NO;
        }
    }
    
    NSInteger jumpToPage = btn.tag - 100;
    
    [_pageViewController setViewControllers:@[_vcArray[jumpToPage]] direction:jumpToPage<_curPage animated:YES completion:^(BOOL finished) {
        _curPage = jumpToPage;
    }];
    for (UIView *v in _titleScrollView.subviews) {
        if (v.tag == jumpToPage+100) {
            UIButton *s = (UIButton *)v;
            s.selected = YES;
            UIImageView *sanjiao = (UIImageView *)[_titleScrollView viewWithTag:s.tag-100+1000];
            if (sanjiao) {
                sanjiao.hidden = NO;

            }
        }
    }
    
    
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width;
    CGFloat offSetX = scrollView.contentOffset.x;
//    NSLog(@"---%f",offSetX);
    CGFloat offSetIndicatorX = (width/3)/width * (offSetX-width);
    CGRect frame = _indicatorView.frame;
    frame.origin.x = offSetIndicatorX + _curPage*width/3;
    _indicatorView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)qianggouClicked {
}
- (IBAction)clickedFuBtn:(id)sender {
}

- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
