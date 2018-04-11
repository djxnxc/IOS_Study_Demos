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
@interface FinancingVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>
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




@end

@implementation FinancingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"理财";
    
    [self configUI];
    //创建子页
    [self initData];
    [self configTitleScrollView];
    [self configPageViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 100+1;
    [self changePage:btn];
}
#pragma - 创建通用UI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    立即抢购
    self.qiangouBtn.layer.cornerRadius = self.qiangouBtn.bounds.size.height/2;
    self.qiangouBtn.layer.masksToBounds = YES;
    [self.qiangouBtn setBackgroundColor:RGB_red];
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
    SubOneVC *sub1 = [[SubOneVC alloc]init];
    sub1.pageNum = 0;
    [_vcArray addObject:sub1];
    SubTwoVC *sub2 = [[SubTwoVC alloc]init];
    sub2.pageNum = 0;
    [_vcArray addObject:sub2];
    SubThreeVC *sub3 = [[SubThreeVC alloc]init];
    sub3.pageNum = 0;
    [_vcArray addObject:sub3];
    
}
- (void)configTitleScrollView {
    CGFloat w = JSCREEN_W;
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(0, 0, w, 35);
    _titleScrollView.backgroundColor = [UIColor colorWithRed:222/255.0 green:59/255.0 blue:51/255.0 alpha:1];
    
    for (int i = 0; i<_vcArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(w/_vcArray.count*i, 0, w/_vcArray.count, 35);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:RGB(253, 179, 153, 1) forState:UIControlStateNormal];
        if (i==0){
            [btn setTitle:@"活期" forState:UIControlStateNormal];
        }
        if (i==1){
            [btn setTitle:@"定期" forState:UIControlStateNormal];
        }
        
        if (i==2){
            [btn setTitle:@"新手标" forState:UIControlStateNormal];
        }
        
        
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [_titleScrollView addSubview:btn];
    }
    _titleScrollView.bounces = NO;
    [self.view addSubview:_titleScrollView];
    
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w/3, 40)];
    _indicatorView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_indicatorView.bounds.size.width-20)/2, (_indicatorView.bounds.size.height-11), 16, 9)];
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
    _pageViewController.view.frame = self.dropview.frame;
    _pageViewController.view.backgroundColor = RGB_gray;
    [self.dropview addSubview:_pageViewController.view];
    
    
    //找到pageViewController view的scrollview，并将其代理设为self
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)view).delegate = self;
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
    NSLog(@"---%f",offSetX);
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
@end
