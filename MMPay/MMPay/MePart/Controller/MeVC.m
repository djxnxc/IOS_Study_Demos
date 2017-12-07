//
//  MeVC.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MeVC.h"
#import "MeHeaderCell.h"
#import "MeListCell.h"
@interface MeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat last;
}
@property(nonatomic,strong)UIView *refreshBgV;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation MeVC
//在页面出现的时候就将黑线隐藏起来
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initView{
    last = 0;
    self.refreshBgV = [[UIView alloc] initWithFrame:CGRectMake(0, -MMP_ScreenH, MMP_ScreenW, MMP_ScreenH)];
    self.refreshBgV.backgroundColor = MMP_BLUECOLOR;
//    [self.view addSubview:self.refreshBgV];
//    [self.view sendSubviewToBack:self.refreshBgV];
    
    [DJXRefreshTool initWithTableViewGifRefresh:self.mainTableView andTarget:self andHeaderSelector:@selector(headerRefresh) andFooterSelector:nil];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = MMP_BLUECOLOR;
}
-(void)headerRefresh{
    [self.mainTableView.mj_header endRefreshing];

}
#pragma mark-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==1||section==3) {
        return 1;
    }
    else{
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }
    else {
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==3) {
        return 0.001;
    }
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MeHeaderCell *headCell = [MeHeaderCell cellWithTableView:tableView];
        return headCell;
    }
    else{
        MeListCell *listCell = [MeListCell initCellWithTableView:tableView];
        return listCell;
    }
}

#pragma mark-UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect frame = self.refreshBgV.frame;
    frame.origin.y = frame.origin.y - (scrollView.contentOffset.y - last);
    self.refreshBgV.frame = frame;
    last = scrollView.contentOffset.y;
    [self.view setNeedsLayout];
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
