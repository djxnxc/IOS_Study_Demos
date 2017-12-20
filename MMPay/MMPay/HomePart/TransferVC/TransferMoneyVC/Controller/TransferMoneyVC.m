//
//  TransferMoneyVC.m
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferMoneyVC.h"
#import "TransferMoneyCell.h"
#import "TransferMobileMoneyCell.h"
#import "TransferSuccessVC.h"
@interface TransferMoneyVC ()

@end

@implementation TransferMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
//初始化
-(void)initView{
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBut.frame = CGRectMake(0, 0, 50, 40);
    [leftBut addTarget:self action:@selector(backButClick) forControlEvents: UIControlEventTouchUpInside];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.type isEqualToString:@"1"]){//银行卡转账
        TransferMoneyCell *cell = [TransferMoneyCell cellWithTableView:tableView];
        __weak typeof(self) weakSelf = self;
        cell.block = ^(NSString *str) {
            MMPPassWordView *passwordV = [MMPPassWordView initPassWordViewWithFrame:CGRectMake(0, 0, MMP_ScreenW, MMP_ScreenH) superView:[UIApplication sharedApplication].keyWindow];
            __strong typeof(weakSelf) strongSelf = weakSelf;
            passwordV.block = ^(NSString *Str) {
                [strongSelf.navigationController popViewControllerAnimated:YES];
            };
            passwordV.successBlock = ^(NSString *str) {
                TransferSuccessVC *vc = [[TransferSuccessVC alloc]initWithNibName:@"TransferSuccessVC" bundle:nil];
                vc.finishlock = ^(NSString *str) {
                    [strongSelf.navigationController popToRootViewControllerAnimated:NO];
                };
                [strongSelf presentViewController:vc animated:YES completion:nil];
            };
        };
        return cell;
    }
    else{//type=2 个人账户转账
        TransferMobileMoneyCell *cell = [TransferMobileMoneyCell cellWithTableView:tableView];
        __weak typeof(self) weakSelf = self;
        cell.block = ^(NSString *str) {
            MMPPaymentDetailsView *paymentDetailV = [MMPPaymentDetailsView initPaymentDetailsViewWithFrame:CGRectMake(0, 0, MMP_ScreenW, MMP_ScreenH) superView:[UIApplication sharedApplication].keyWindow];
            __weak typeof(paymentDetailV)  weakPaymentDetailV= paymentDetailV;
            paymentDetailV.backBlock = ^(NSString *Str) {
                [weakPaymentDetailV removeFromSuperview];
            };
            paymentDetailV.payBlock = ^(NSString *str) {
                MMPPassWordView *passwordV = [MMPPassWordView initPassWordViewWithFrame:CGRectMake(0, 0, MMP_ScreenW, MMP_ScreenH) superView:[UIApplication sharedApplication].keyWindow];
                __weak typeof(passwordV)  weakPasswordV= passwordV;
                passwordV.block = ^(NSString *Str) {
                    [weakPasswordV removeFromSuperview];
                };
                __strong typeof(weakSelf) strongSelf = weakSelf;
                passwordV.successBlock = ^(NSString *str) {
                    [weakPaymentDetailV removeFromSuperview];
                    TransferSuccessVC *vc = [[TransferSuccessVC alloc]initWithNibName:@"TransferSuccessVC" bundle:nil];
                    vc.itemLabel.text = @"To Mobile Money account";
                    vc.amountLabel.text = @"TZS  320.00";
                    vc.finishlock = ^(NSString *str) {
                        [strongSelf.navigationController popToRootViewControllerAnimated:NO];
                    };
                    [strongSelf presentViewController:vc animated:YES completion:nil];
                };
            };
        };
        return cell;
    }
    return nil;
}
-(void)backButClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
