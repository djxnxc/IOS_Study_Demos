//
//  TranstoMobileMoneyAccountVC.m
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TranstoMobileMoneyAccountVC.h"
#import "TransferMoneyVC.h"
@interface TranstoMobileMoneyAccountVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;//转账金额输入框
@property (weak, nonatomic) IBOutlet UIButton *nextBut;//下一步输入框

@end

@implementation TranstoMobileMoneyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}
//初始化
-(void)initView{
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBut.frame = CGRectMake(0, 0, 50, 40);
    [leftBut addTarget:self action:@selector(backButClick) forControlEvents: UIControlEventTouchUpInside];
    leftBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [leftBut setImage:MMP_IMAGE(@"icon_back") forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBut];
    self.nextBut.layer.cornerRadius = 4;
    self.nextBut.layer.masksToBounds = YES;
    [self.accountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.nextBut.enabled = NO;
    self.nextBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length>0) {
        self.nextBut.enabled = YES;
        self.nextBut.backgroundColor = MMP_BLUECOLOR;
    }
    else{
        self.nextBut.enabled = NO;
        self.nextBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
    }

}
//下一步按钮
- (IBAction)nextButClick:(UIButton *)sender {
    [self.view endEditing:YES];
    TransferMoneyVC *vc = [[TransferMoneyVC alloc]init];
    vc.title = @"Transfer money";
    vc.type = @"2";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)backButClick{
    [self.navigationController popViewControllerAnimated:YES];
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
