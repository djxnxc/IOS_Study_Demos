//
//  AccountDQ.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJY.h"
#import "AccountJYSubOne.h"


@interface AccountJY ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>
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
}
@property (weak, nonatomic) IBOutlet UIView *indView;
@property (weak, nonatomic) IBOutlet UIView *contetnView;



@end

@implementation AccountJY

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    
    [self configUI];
    //创建子页
    [self initData];
    [self configTitleScrollView];
    [self configPageViewController];
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
    [self.navigationController.navigationBar setHidden:NO];
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
#pragma - 创建通用UI
- (void)configUI {
    self.view.backgroundColor = RGB_gray;
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
      
    
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


#pragma mark - 创建pageVC
- (void)initData{
    //创建数据源
    _vcArray = [NSMutableArray array];
    AccountJYSubOne *sub0 = [[AccountJYSubOne alloc]init];
    sub0.pageNum = 1;
    [_vcArray addObject:sub0];
    AccountJYSubOne *sub1 = [[AccountJYSubOne alloc]init];
    sub1.pageNum = 2;
    [_vcArray addObject:sub1];
    AccountJYSubOne *sub2 = [[AccountJYSubOne alloc]init];
    sub2.pageNum = 3;
    [_vcArray addObject:sub2];
    AccountJYSubOne *sub3 = [[AccountJYSubOne alloc]init];
    sub3.pageNum = 4;
    [_vcArray addObject:sub3];
    AccountJYSubOne *sub4 = [[AccountJYSubOne alloc]init];
    sub4.pageNum = 5;
    [_vcArray addObject:sub4];
    
}
- (void)configTitleScrollView {
    CGFloat w = JSCREEN_W;
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(0, 0, JSCREEN_W, 35);
    _titleScrollView.backgroundColor = RGB_red;
    for (int i = 0; i<_vcArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(w/_vcArray.count*i, 0, w/_vcArray.count, 35);
        btn.backgroundColor = [UIColor clearColor];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (i==0){
            [btn setTitle:@"全部" forState:UIControlStateNormal];
        }if (i==1){
            [btn setTitle:@"购买" forState:UIControlStateNormal];
        }if (i==2){
            [btn setTitle:@"充值" forState:UIControlStateNormal];
        }if (i == 3) {
             [btn setTitle:@"赎回" forState:UIControlStateNormal];
        }if (i == 4) {
            [btn setTitle:@"提现" forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [_titleScrollView addSubview:btn];
    }
    _titleScrollView.bounces = NO;
    [self.view addSubview:_titleScrollView];
    
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w/_vcArray.count, 35)];
    _indicatorView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_indicatorView.bounds.size.width-16)/2, (_indicatorView.bounds.size.height-9)+1, 16, 9)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"financing_sanjiao"] forState:UIControlStateNormal];
    [_indicatorView addSubview:btn];
    _indicatorView.alpha = 1;
    [_titleScrollView addSubview:_indicatorView];
    
}
- (void)configPageViewController {
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
    }
}

#pragma mark - 交互



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
        }
    }
    
    
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width;
    CGFloat offSetX = scrollView.contentOffset.x;
    
    CGFloat offSetIndicatorX = (width/_vcArray.count)/width * (offSetX-width);
    CGRect frame = _indicatorView.frame;
    frame.origin.x = offSetIndicatorX + _curPage*width/_vcArray.count;
    _indicatorView.frame = frame;
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
