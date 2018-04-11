//
//  LoginMima.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "LoginMima.h"

@interface LoginMima ()<UITextFieldDelegate,HZMAPIManagerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h1;
@property (weak, nonatomic) IBOutlet UITextField *nextMM;
@property (weak, nonatomic) IBOutlet UIButton *sure;
- (IBAction)sureClicked;
@property (weak, nonatomic) IBOutlet UITextField *NewMM;
@property (weak, nonatomic) IBOutlet UITextField *oldMM;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;
@end

@implementation LoginMima

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    self.view.backgroundColor = RGB_gray;
    _sure.backgroundColor = RGB_red;
    _sure.layer.cornerRadius = 35.0/2*ratioH;
    _sure.layer.masksToBounds = YES;
    [_sure setTitle:@"确认" forState:UIControlStateNormal];
    _sure.titleLabel.font = JFont(fontBtn);
    [self configUI];
    self.h1.constant = 50*ratioH;
    self.btnH.constant = 35*ratioH;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
}
- (void)configUI {
    
}

#pragma mark - 网络
#pragma mark 确认修改
- (void)nextNetWorking {
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"1",@"type"
                              , [NSString MD5:self.NewMM.text],@"password"
                              ,[NSString MD5:self.oldMM.text],@"oldPassword",
                              a.userId,@"userId",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounXGMMa_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounXGMMa_NetWoring]) {//重置密码
        if([response.responseCodeOriginal isEqualToString:@"1"]){
            
            ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"您已成功修改密码。" leftButtonTitle:nil rightButtonTitle:@"确认"];
            WDCAccount *a = [WDCUserManage getLastUserInfo];
            a.pas=[NSString MD5:self.NewMM.text];
            [WDCUserManage saveLastUserInfo:a];
            __block ZendaiAlertView *alertt = alert;
             __weak LoginMima *sel = self;
            alert.rightBlock = ^(){
//                [sel.navigationController popToRootViewControllerAnimated:YES];
                LoginVC *l = [[LoginVC alloc] init];
                l.hidesBottomBarWhenPushed = YES;
                l.isFrom = 88;
                [self.navigationController pushViewController:l animated:YES];

                
                [alertt removeFromSuperviewi];
            };
            [alert show];
            
        }
        
    }
    
    
}
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
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



- (IBAction)sureClicked {
    
    
    if (![self verificateData]) {
        return;
    }
    [self nextNetWorking];
    
    
}
//校验格式
-(BOOL)verificateData
{
    
    if ((_oldMM.text == nil)||[_oldMM.text isEqualToString:@""])
    {
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
    if (([_NewMM.text length]<6) || ([_NewMM.text length]>20))
    {
        [self.view makeToast:@"密码应为6-20字符!" ifSucess:NO];
        return NO;
    }
    if (![Tool validateIsNumberChar:_NewMM.text]) {
        [self.view makeToast:@"密码应为6-20字母或数字" ifSucess:NO];
        return NO;
    }
    
    if ((_nextMM.text == nil)||[_nextMM.text isEqualToString:@""])
    {
        [self.view makeToast:@"请再次输入密码"ifSucess:NO];
        return NO;
    }
    if (![_nextMM.text isEqualToString:_NewMM.text])
    {
        
        [self.view makeToast:@"两次输入的密码不一致"ifSucess:NO];
        return NO;
    }
    
    return YES;
}

#pragma mark - 其他
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
