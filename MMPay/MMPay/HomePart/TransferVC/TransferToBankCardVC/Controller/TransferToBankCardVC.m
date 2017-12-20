//
//  TransferToBankCardVC.m
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferToBankCardVC.h"
#import "TransferToBankCardCell.h"
#import "CardIssuerVC.h"
#import "TransferMoneyVC.h"
@interface TransferToBankCardVC ()
@end

@implementation TransferToBankCardVC

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
 
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 320;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransferToBankCardCell *cell = [TransferToBankCardCell cellWithTableView:tableView];
    __weak typeof(cell) weakCell = cell;
    cell.block = ^(NSString *str) {
        if ([str isEqualToString:@"next"]) {
            //下一步
            TransferMoneyVC *vc = [[TransferMoneyVC alloc]init];
            vc.title = @"Transfer money";
            vc.type =@"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            //选择银行
            CardIssuerVC *vc = [[CardIssuerVC alloc]init];
            vc.title = @"Card Issuer";
            __strong typeof(weakCell) strongCell= weakCell;
            vc.selectBlock = ^(NSString *bank) {
                strongCell.banksTextField.text  = bank;
                if ([strongCell.nameTextField.text isEqualToString:@""]) {
                    return ;
                }
                if ([strongCell.cardNoTextField.text isEqualToString:@""]) {
                    return ;
                }
                if ([strongCell.banksTextField.text isEqualToString:@""]) {
                    return ;
                }
                if ([strongCell.amountTextField.text isEqualToString:@""]) {
                    return ;
                }
                strongCell.nextBut.enabled = YES;
                strongCell.nextBut.backgroundColor = MMP_BLUECOLOR;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backButClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
