//
//  TransferVC.m
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferVC.h"
#import "TransferCell.h"
#import "TransferToBankCardVC.h"
@interface TransferVC ()
@property(nonatomic,strong)NSArray *cellDataArr;//列表数据
@end

@implementation TransferVC
-(NSArray *)cellDataArr{
    if (!_cellDataArr) {
        _cellDataArr = [NSArray arrayWithObjects:@{@"image":@"icon_friend",@"title":@"Transfer to Mobile Money account"}, @{@"image":@"icon_bank",@"title":@"Transfer to bank card"},nil];
    }
    return _cellDataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
//初始化
-(void)initView{
    self.title = @"Transfer";
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBut.frame = CGRectMake(0, 0, 50, 40);
    [leftBut addTarget:self action:@selector(backButClick) forControlEvents: UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MMP_ScreenW, 15)];
    self.tableView.tableHeaderView =view;
    leftBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [leftBut setImage:MMP_IMAGE(@"icon_back") forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBut];
    self.tableView.backgroundColor = MMP_BackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransferCell *cell = [TransferCell cellWithTableView:tableView];
    cell.dictData = self.cellDataArr[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                
            }
            break;
        case 1:
            {
                TransferToBankCardVC *vc = [[TransferToBankCardVC alloc]init];
                vc.title = @"Transfer to bank card";
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        default:
            break;
    }
}
//返回
-(void)backButClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
