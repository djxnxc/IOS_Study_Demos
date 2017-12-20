//
//  MeVC.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MeVC.h"
#import "MeListCell.h"
#import "MeLogOutCell.h"
@interface MeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat last;
}
@property(nonatomic,strong)UIView *refreshBgV;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;//列表
@property(nonatomic,strong)NSArray *cellDataArr;//列表数据源
@end

@implementation MeVC
-(NSArray *)cellDataArr{
    if (!_cellDataArr) {
        _cellDataArr = @[@{@"type":@"1",@"cellTitle":@"Balance",@"value":@"100.00",@"imageName":@"icon_shuaxing"},@{@"type":@"2",@"cellTitle":@"Transactions",@"value":@"",@"imageName":@"icon_disclosurearrow"},@{@"type":@"2",@"cellTitle":@"Settings",@"value":@"",@"imageName":@"icon_disclosurearrow"},@{@"type":@"3",@"cellTitle":@"Help Cenyer",@"value":@"1234567890",@"imageName":@""}];
    }
    return _cellDataArr;
}
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
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDataArr.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==self.cellDataArr.count){
        return 100;
    }
    return 71;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==self.cellDataArr.count){
        MeLogOutCell *logOutCell = [MeLogOutCell initCellWithTableView:tableView];
        logOutCell.block = ^(NSString *logOut) {
            MMP_ALERT_SHOW(@"提示",@"注销登录");
        };
        return logOutCell;
    }
    else{
        MeListCell *listCell = [MeListCell initCellWithTableView:tableView];
        listCell.dictData = _cellDataArr[indexPath.row];
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
