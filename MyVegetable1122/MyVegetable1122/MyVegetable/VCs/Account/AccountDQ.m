//
//  AccountDQ.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountDQ.h"
#import "AccountDQSubOne.h"
#import "MainTabbarController.h"
#import "PublicString.h"

@interface AccountDQ ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,HZMAPIManagerDelegate>
{
    UIPageViewController *_pageViewController;
    //数据源
    NSMutableArray *_vcArray;
    NSMutableArray *productData;
    //标识当前页
    NSInteger _curPage;
    //标题scrollView
    UIScrollView *_titleScrollView;
    //指示当前页
    UIView *_indicatorView;
    BOOL _isNew;
    NSArray *menus;
    AccountDQSubOne *sub0;
}
@property (weak, nonatomic) IBOutlet UIView *indView;
@property (weak, nonatomic) IBOutlet UIView *contetnView;
@property (weak, nonatomic) IBOutlet UIButton *get;
- (IBAction)clickedGet;

@property (weak, nonatomic) IBOutlet UILabel *priceDQi;
@property (weak, nonatomic) IBOutlet UILabel *priceYqi;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopviewHH;

@end

@implementation AccountDQ

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的定期";
    productData = [NSMutableArray array];
    self.navigationController.navigationBar.translucent = YES;
     self.edgesForExtendedLayout = UIRectEdgeNone;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _curPage=0;
    _vcArray=[[NSMutableArray alloc]init];
//    self.nabigationcontroller.navigationbar.translucent = YES;
    /*[self configUI];
    //创建子页
    [self initData];
    [self configTitleScrollView];
    [self configPageViewController];*/
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.num == 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+0;
        [self changePage:btn];
    }else if (self.num == 99){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+0;
        [self changePage:btn];
    }
    [self getProduct];
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
    
//    if (iPhone6P) {
//        _TopViewH.constant = 75;
//    } else if (iPhone6) {
//        _TopViewH.constant = 75;
//    } else if (iPhone5) {
//        _TopViewH.constant = 70;
//    }
    [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset1=[[HZMRequest alloc]init];
    requset1.requsetId=Dq_MenuList;
    WDCAccount *a1 = [WDCUserManage getLastUserInfo];
    NSDictionary* dict1=@{@"userId":a1.userId};
    requset1.requestParamDic=dict1;
    requset1.callBackDelegate=self;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
}



#pragma - 创建通用UI
- (void)configUI {
    self.view.backgroundColor = RGB_gray;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //    立即抢购
    self.btnH.constant = 30.0*ratioH;
    self.get.layer.cornerRadius = 30.0/2*ratioH;
    self.get.layer.masksToBounds = YES;
    [self.get setBackgroundColor:RGB_yellow];
    self.get.titleLabel.font = JFont(fontBtn);
    [self.get setTitle:@"购买" forState:UIControlStateNormal];
    
//    self.priceDQi.text = @"00";
//    self.priceYqi.text = @"00";
    
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
#pragma mark 购买
- (IBAction)clickedGet {
    
     MainTabbarController *t = [[MainTabbarController alloc] initWith:22];
    t.isfrom = 2;//定期
    if (_isNew){//新手标
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"101"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else{
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"0"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    
    [self presentViewController:t animated:YES completion:nil];
    
    
}


#pragma mark - 网络
- (void)getProduct
{
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",
                              @"12",@"timeType",
                              @"3",@"type",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounDingQiCX_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounDingQiCX_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *dictt= [response.responseData objectForKey:@"data"];
            NSString *ss = [NSString stringWithFormat:@"%@",dictt[@"regularAmtSum"]];
            if (ss.length==0) {
                ss=@"0";
            }
            ss = [NSString countNumAndChangeformat:ss];
            self.priceDQi.text = ss;//[NSString stringWithFormat:@"￥%@",ss];
            
            NSString *sts = [NSString stringWithFormat:@"%@",dictt[@"expectedAmtSum"]];//expectedAmtSum
            if (sts.length==0) {
                sts=@"0";
            }
            sts = [NSString countNumAndChangeformat:sts];
            self.priceYqi.text = sts;//[NSString stringWithFormat:@"￥%@",sts];
            
            
            
        }
    }
    if ([response.requestId isEqualToString:Dq_MenuList]) {
        if ([[response.responseData objectForKey:@"code"] intValue]==1) {
            menus=[response.responseData objectForKey:@"data"];
            [self configUI];
            //创建子页
            [self initData];
            [self configTitleScrollView];
            [self configPageViewController];
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
//    if (menus.count>0) {
//        _vcArray = [NSMutableArray array];
//        AccountDQSubOne *sub0 = [[AccountDQSubOne alloc]init];
//        sub0.dataDictionary=[menus firstObject];
//        [_vcArray addObject:sub0];
//    }
   /* _vcArray = [NSMutableArray array];
    AccountDQSubOne *sub0 = [[AccountDQSubOne alloc]init];
    sub0.pageNum = 1;
    [_vcArray addObject:sub0];
    AccountDQSubOne *sub1 = [[AccountDQSubOne alloc]init];
    sub1.pageNum = 3;
    [_vcArray addObject:sub1];
    AccountDQSubOne *sub2 = [[AccountDQSubOne alloc]init];
    sub2.pageNum = 6;
    [_vcArray addObject:sub2];
    AccountDQSubOne *sub3 = [[AccountDQSubOne alloc]init];
    sub3.pageNum = 12;
    [_vcArray addObject:sub3];
    AccountDQSubOne *sub4 = [[AccountDQSubOne alloc]init];
    sub4.pageNum = 99;
    [_vcArray addObject:sub4];*/
    
}
- (void)configTitleScrollView {
    CGFloat w = JSCREEN_W;
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(0, 0, JSCREEN_W, 35);
    _titleScrollView.backgroundColor = RGB(163, 164, 165, 1);
    for (int i = 0; i<menus.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((80+1)*i, 0, 80, 35);
        btn.backgroundColor = [UIColor clearColor];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (i==0) {
            [btn setTitleColor:RGB_yellow forState:UIControlStateNormal];
        }else{
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
//        if (i==0){
//            [btn setTitle:@"1个月" forState:UIControlStateNormal];
//        }if (i==1){
//            [btn setTitle:@"3个月" forState:UIControlStateNormal];
//        }if (i==2){
//            [btn setTitle:@"6个月" forState:UIControlStateNormal];
//        }if (i == 3) {
//             [btn setTitle:@"12个月" forState:UIControlStateNormal];
//        }if (i == 4) {
//            [btn setTitle:@"新手标" forState:UIControlStateNormal];
//        }
        NSDictionary* meDict=[menus objectAtIndex:i];
        [btn setTitle:[meDict objectForKey:@"title"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [_vcArray addObject:btn];
        [_titleScrollView addSubview:btn];
    }
    //(80+menus.count)*menus.count
    _titleScrollView.contentSize=CGSizeMake((80+menus.count)*menus.count, 35);
    [_titleScrollView setShowsHorizontalScrollIndicator:NO];
    //_titleScrollView.bounces = NO;
//    if (iPhone6P) {
//        _TopViewH.constant = 90;
//        _TopviewHH.constant = -10;
//    } else if (iPhone6) {
//        _TopViewH.constant = 80;
//    } else if (iPhone5) {
//        _TopViewH.constant = 70;
//    }
    [self.indView addSubview:_titleScrollView];
    
    /*_indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w/_vcArray.count, 35)];
    _indicatorView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_indicatorView.bounds.size.width-16)/2, (_indicatorView.bounds.size.height-9)+1, 16, 9)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"financing_sanjiao"] forState:UIControlStateNormal];
    [_indicatorView addSubview:btn];
    _indicatorView.alpha = 1;
    [_titleScrollView addSubview:_indicatorView];*/
    
}
- (void)configPageViewController {
    sub0=[[AccountDQSubOne alloc]init];
    sub0.dataDictionary=[menus firstObject];
    sub0.view.frame=self.contetnView.frame;
    [self.view addSubview:sub0.view];
    /*
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageViewController.view.frame = self.contetnView.frame;
    _pageViewController.view.backgroundColor = RGB_gray;
    [self.view addSubview:_pageViewController.view];
    
    
    //找到pageViewController view的scrollview，并将其代理设为self
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)view).delegate = self;
        }
    }*/
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
   /* for (UIView *v in _titleScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *s = (UIButton *)v;
            s.selected = NO;
        }
    }
    
    NSInteger jumpToPage = btn.tag - 100;
    if (jumpToPage == 4) {
        _isNew = YES;
    } else {
        _isNew = NO;
    }
    [_pageViewController setViewControllers:@[_vcArray[jumpToPage]] direction:jumpToPage<_curPage animated:YES completion:^(BOOL finished) {
        _curPage = jumpToPage;
    }];
    for (UIView *v in _titleScrollView.subviews) {
        if (v.tag == jumpToPage+100) {
            UIButton *s = (UIButton *)v;
            s.selected = YES;
        }
    }*/
    NSInteger t=btn.tag-100;
    if (t!=_curPage) {
        
        _curPage=t;
        sub0.dataDictionary=[menus objectAtIndex:t];
        for (int i=0; i<_vcArray.count; i++) {
            UIButton *b=[_vcArray objectAtIndex:i];
            if (i==_curPage) {
                [b setTitleColor:RGB_yellow forState:UIControlStateNormal];
            }else{
                [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    [sub0 reflash];
    
    
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /*CGFloat width = self.view.frame.size.width;
    CGFloat offSetX = scrollView.contentOffset.x;
    
    CGFloat offSetIndicatorX = (width/_vcArray.count)/width * (offSetX-width);
    CGRect frame = _indicatorView.frame;
    frame.origin.x = offSetIndicatorX + _curPage*width/_vcArray.count;
    _indicatorView.frame = frame;*/
    _indicatorView.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

