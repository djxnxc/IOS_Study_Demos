//
//  CardIssuerVC.m
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "CardIssuerVC.h"
#import "CardIssuerCell.h"
@interface CardIssuerVC ()
@property(nonatomic,strong)NSArray *cellDataArr;//列表数据源
@end

@implementation CardIssuerVC
-(NSArray *)cellDataArr{
    if (!_cellDataArr) {
        _cellDataArr = [NSArray arrayWithObjects:@{@"image":@"icon_ccb",@"bank":@"CCB"},@{@"image":@"icon_icbc",@"bank":@"ICBC"},@{@"image":@"icon_bocom",@"bank":@"BOCOM"},@{@"image":@"icon_boc",@"bank":@"BOC"},@{@"image":@"icon_abc",@"bank":@"ABC"},@{@"image":@"icon_cib",@"bank":@"CIB"}, nil];
    }
    return _cellDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
//初始化
-(void)initView{
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
    return 48;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardIssuerCell *cell = [CardIssuerCell cellWithTableView:tableView];
    cell.dictData = self.cellDataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectBlock) {
        self.selectBlock(self.cellDataArr[indexPath.row][@"bank"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)backButClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
