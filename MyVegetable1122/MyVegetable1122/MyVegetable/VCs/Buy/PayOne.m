//
//  PayOne.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/26.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "PayOne.h"
#import "MainTabbarController.h"
@interface PayOne ()<UITextFieldDelegate,HZMAPIManagerDelegate>
{
    NSString *_password;
}
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)clickedBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;

@end

@implementation PayOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    
    if (iPhone6P|iPhone6) {
        
        _btnH.constant = 40;
        self.btn.layer.cornerRadius = 40.0/2;
    } else {
        
        _btnH.constant = 35;
        self.btn.layer.cornerRadius = 35.0/2;
    }
    self.btn.layer.masksToBounds = YES;
    [self.btn setBackgroundColor:RGB_red];
    self.btn.titleLabel.font = JFont(fontBtn);
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
    if (self.payNum>1) {
        NSString *ss = [NSString stringWithFormat:@"%ld",self.payNum];
        ss = [NSString countNumAndChangeformat:ss];
        
        self.topLabel.text = [NSString stringWithFormat:@"支付金额:%@",ss];
        int l = (int)self.topLabel.text.length;
        [Tool setLabel:self.topLabel withFrom:5 to:l-5 andfont:fontMid withColor:RGB_red];
    }else{
        NSString *ss = [NSString stringWithFormat:@"%@",self.ListAmount];
        ss = [NSString countNumAndChangeformat:ss];
        
        self.topLabel.text = [NSString stringWithFormat:@"支付金额:%@",ss];
        int l = (int)self.topLabel.text.length;
        [Tool setLabel:self.topLabel withFrom:8 to:l-8 andfont:fontMid withColor:RGB_red];
    }
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
    self.payPassword.delegate=self;
}
- (void)viewDidAppear:(BOOL)animated {
   
}


#pragma mark 网络
- (void)getProduct {
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    if (!_ListAmount) {
        _ListAmount = @"0";
    }if (_ListAmount.length==0) {
        _ListAmount = @"0";
    }
    NSDictionary *dicParams=nil;
    if (self.isFrom==24) {
        
  dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%ld",_payNum],@"investAmt",
                              a.userId,@"userId",
                              _prodctID,@"prodId",
                              [NSString MD5:_password],@"tradePassword",
                              _List,@"couponList",
                              _ListAmount,@"couponSumAmt",nil];
    }else{
        dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%ld",_payNum],@"investAmt",
                    a.userId,@"userId",
                    _prodctID,@"prodId",
                    [NSString MD5:_password],@"tradePassword",
                    _ListAmount,@"couponSumAmt",nil];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = FinancingGMPay_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:FinancingGMPay_NetWoring ]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
//            NSDictionary *dictt = [response.responseData objectForKey:@"data"];
            
            ZendaiAlertView *alrt = [[ZendaiAlertView alloc] initWithTitle:@"提示" contentText:@"您已经购买成功，是否查看账户" leftButtonTitle:@"确定" rightButtonTitle:@"查看"];
            alrt.cha.hidden=YES;
            __weak ZendaiAlertView *alertl = alrt;
             __weak PayOne *sel = self;
            alrt.leftBlock = ^(){
                MainTabbarController *tabVC = [[MainTabbarController alloc] init];
                if (self.isFrom==22) {
                    tabVC.isfrom=99;
                    [Tool setObject:@"99" forKey:@"ojp"];
                }else if(self.isFrom==24){
                    tabVC.isfrom=99;
                    [Tool setObject:@"101" forKey:@"ojp"];
                }else{
                tabVC.isfrom = 2;//账户
                    [Tool setObject:@"0" forKey:@"ojp"];
                }
                sel.view.window.rootViewController = tabVC;
                [alertl removeFromSuperview];
            };
            alrt.rightBlock = ^(){
                MainTabbarController *tabVC = [[MainTabbarController alloc] init];
                tabVC.isfrom = 3;//账户
                sel.view.window.rootViewController = tabVC;
                [alertl removeFromSuperview];
            };
            alrt.leftColor = RGB_red;
            alrt.rightColor = RGB_red;
            [alrt show];
            
        }
    }
}
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:2];
    }else
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:2];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.responseCodeOriginal isEqualToString:@"-99"]) {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 88;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}



- (IBAction)clickedBtn {
    [self.view endEditing:YES];
    
    if (self.payPassword.text.length>5) {
        
       _password = self.payPassword.text;
        [self getProduct];
    }else{
        [self.view makeToast:@"密码不足六位"];
        return;
    }
    

}


#pragma mark - 键盘处



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    //    [self clickedSure];
    return YES;
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