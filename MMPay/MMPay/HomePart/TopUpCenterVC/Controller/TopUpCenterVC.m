//
//  TopUpCenterVC.m
//  MMPay
//
//  Created by 12 on 2017/12/21.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TopUpCenterVC.h"
#import "TopUpCell.h"
@interface TopUpCenterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *topUpType;//默认为topUp
}
@property (weak, nonatomic) IBOutlet UIButton *topUpBut;//充话费按钮
@property (weak, nonatomic) IBOutlet UIView *topUpLine;//充话费下划线
@property (weak, nonatomic) IBOutlet UIButton *dataBut;//充流量按钮
@property (weak, nonatomic) IBOutlet UIView *dataLine;//充流量下划线
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *topUpArr;//话费套餐数组
@property(nonatomic,strong)NSArray *dataArr;//流量套餐数组
@end

@implementation TopUpCenterVC
-(NSArray *)topUpArr{
    if (!_topUpArr) {
        _topUpArr = [NSArray arrayWithObjects:@"500-TZSA",@"1,000-TZS",@"5,000-TZS",@"10,000-TZS",@"50,000-TZS",@"100,000-TZS", nil];
    }
    return _topUpArr;
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithObjects:@"500-TZSB",@"1,000-TZS",@"5,000-TZS",@"10,000-TZS",@"50,000-TZS",@"100,000-TZS", nil];
    }
    return _dataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}
//初始化
-(void)initView{
    topUpType = @"topUp";
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBut.frame = CGRectMake(0, 0, 50, 40);
    [leftBut addTarget:self action:@selector(backButClick) forControlEvents: UIControlEventTouchUpInside];
    leftBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [leftBut setImage:MMP_IMAGE(@"icon_back") forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBut];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataLine.hidden = YES;
    [self.dataBut setTitleColor:MMP_CUSTOM_COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    self.topUpLine.hidden = NO;
    [self.topUpBut setTitleColor:MMP_CUSTOM_COLOR(57, 150, 254, 1) forState:UIControlStateNormal];
}
-(void)backButClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击话费充值
- (IBAction)topUpbutClick:(UIButton *)sender {
    if (![topUpType isEqualToString:@"topUp"]) {
        topUpType = @"topUp";
        self.dataLine.hidden = YES;
        [self.dataBut setTitleColor:MMP_CUSTOM_COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
        self.topUpLine.hidden = NO;
        [self.topUpBut setTitleColor:MMP_CUSTOM_COLOR(57, 150, 254, 1) forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
}
//点击流量充值
- (IBAction)dataButClick:(UIButton *)sender {
    if (![topUpType isEqualToString:@"data"]) {
        topUpType = @"data";
        self.dataLine.hidden = NO;
        [self.dataBut setTitleColor:MMP_CUSTOM_COLOR(57, 150, 254, 1) forState:UIControlStateNormal];
        self.topUpLine.hidden = YES;
        [self.topUpBut setTitleColor:MMP_CUSTOM_COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
   
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopUpCell *cell = [TopUpCell cellWithTableView:tableView];
    __weak typeof(self) weakSelf = self;
    /****选中套餐***/
    cell.selectblcok = ^(NSString *amountStr) {
        /*****生产订单*****/
        MMPPaymentDetailsView *paymentDetailV = [MMPPaymentDetailsView initPaymentDetailsViewWithFrame:CGRectMake(0, 0, MMP_ScreenW, MMP_ScreenH) superView:[UIApplication sharedApplication].keyWindow];
        paymentDetailV.amountLabel.text = amountStr; //支付金额
        __weak typeof(paymentDetailV)  weakPaymentDetailV= paymentDetailV;
        /*****退出生产支付订单界面*****/
        paymentDetailV.backBlock = ^(NSString *back) {
            [weakPaymentDetailV removeFromSuperview];//移除支付订单界面
        };
        /****点击支付****/
        paymentDetailV.payBlock = ^(NSString *pay) {
            /****输入密码*****/
            MMPPassWordView *passwordV = [MMPPassWordView initPassWordViewWithFrame:CGRectMake(0, 0, MMP_ScreenW, MMP_ScreenH) superView:[UIApplication sharedApplication].keyWindow];
            __weak typeof(passwordV)  weakPasswordV= passwordV;
            /*****退出支付密码界面*****/
            passwordV.block = ^(NSString *remove) {
                [weakPasswordV removeFromSuperview];//移除支付密码界面
            };
            __strong typeof(weakSelf) strongSelf = weakSelf;
            /****跳转支付成功****/
            passwordV.successBlock = ^(NSString *success) {
                [weakPaymentDetailV removeFromSuperview];//移除订单界面
                /********支付成功*******/
                TransferSuccessVC *vc = [[TransferSuccessVC alloc]initWithNibName:@"TransferSuccessVC" bundle:nil];
                NSString *promptStr = @"Top Up Complete";//提示语
                NSString *amountStr = [NSString stringWithFormat:@"TZS %@",weakPaymentDetailV.amountLabel.text];//支付金额
                NSString *itemStr = @"";//订单类型
                if ([topUpType isEqualToString:@"topUp"]) {
                    itemStr = @"Top Up";
                }
                else{
                    itemStr = @"Data";
                }
                vc.dictData=@{@"prompt": promptStr,@"item":itemStr,@"amount":amountStr};
                /*****支付流程结束****/
                vc.finishlock = ^(NSString *str) {
                    [strongSelf.navigationController popToRootViewControllerAnimated:NO];//回到首页
                };
                [strongSelf presentViewController:vc animated:YES completion:nil];
            };
        };
    };
    if ([topUpType isEqualToString:@"topUp"]) {
        cell.arrData = [self.topUpArr copy];
    }
    else{
        cell.arrData = [self.dataArr copy];
    }
    return cell;
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
