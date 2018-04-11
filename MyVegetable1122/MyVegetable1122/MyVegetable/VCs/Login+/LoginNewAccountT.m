//
//  LoginVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/25.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "LoginNewAccountT.h"
#import "LoseLoginFind.h"
//#import "PasswordGestureViewController.h"
#import "HtmlZP.h"
@interface LoginNewAccountT ()<HZMAPIManagerDelegate,UITextFieldDelegate>
{
    NSInteger _isFirst;
}
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)ClickedTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *yaoqingma;
- (IBAction)clickedSelectedd:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
- (IBAction)clickedLogin;
- (IBAction)clickedNew;

@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *isSelected;

@end

@implementation LoginNewAccountT

- (void)viewDidLoad {
    [super viewDidLoad];
    self.num = 30;
    self.isFromSelf = 0;
    self.viewH.constant = 35*ratioH;
    self.title  = @"注册";
    self.loginbtn.layer.cornerRadius = 35.0/2*ratioH;
    self.loginbtn.layer.masksToBounds = YES;
    [self.loginbtn setBackgroundColor:RGB_red];
    self.loginbtn.titleLabel.font = JFont(fontBtn);
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
//    _timeBtn.titleLabel.numberOfLines = 2;
    
    
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
    if (self.phone) {
        self.phoneNum.text = [NSString stringWithFormat:@"手机号:%@",self.phone];
    }
    if (self.isFromSelf ==99) {//从手势密码跳转而来
        LoginVC *ll = [[LoginVC alloc] init];
        ll.isFrom = 22;
        UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        ll.navigationItem.backBarButtonItem = item;
        ll.navigationItem.hidesBackButton = YES;
        ll.navigationController.navigationBar.translucent = NO;
        [ll.navigationItem setHidesBackButton:YES];
        ll.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ll animated:YES];
    }
    
}
#pragma mark - 网络
#pragma mark 注册
- (void)login {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              self.phone,@"phoneNum",
                               [NSString MD5:self.mima.text],@"password",
                              @"",@"invitationCode",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = LoginZC_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 99;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
#pragma mark 发送验证码
- (void)sendSMS {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"2",@"type"
                              ,self.phone,@"phoneNum",nil];
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = LoginYZMGetSMS_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
#pragma mark 校验短信验证码
- (void)tesTSMS {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type"
                              ,self.phone,@"phoneNum"
                              ,self.yanzhengma.text,@"identifyCode",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = LoginYZMTestSMS_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    
   
    if ([response.requestId isEqualToString: LoginYZMGetSMS_NetWoring]){//验证码
        if ([response.responseCodeOriginal isEqualToString: @"1"]) {
            [self.view makeToast:[response.responseData objectForKey:@"message"] ];//duration:JDuration1 position:@"center"];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
            self.timeBtn.userInteractionEnabled=NO;  //.enabled = NO;
        }
        
    }else if ([response.requestId isEqualToString:LoginYZMTestSMS_NetWoring]){//校验短信验证码
        if ([[response.responseData objectForKey:@"code"] isEqual:@1]) {
            if (_isFirst == 101) {
                [self login];//短信校验后进行注册
            }
        }
    }else if ([response.requestId isEqualToString:LoginZC_NetWoring]){//注册
        if ([[response.responseData objectForKey:@"code"] isEqual:@1]) {
            [self success];
        }else {//注册失败
            [self.view makeToast:response.responseMsg duration:JDuration1 position:@"center"];
        }
        
    }
     
 }
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:JDuration1 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:JDuration1 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
}
- (void)success {
    ZendaiAlertView *alrt = [[ZendaiAlertView alloc] initWithTitle:@"提示" contentText:@"您已经注册成功！" leftButtonTitle:nil rightButtonTitle:@"登录"];
    __weak ZendaiAlertView *alertl = alrt;
     __weak LoginNewAccountT *sel = self;
    alrt.cha.hidden=YES;
    alrt.rightBlock = ^(){
        
        [Tool setBool:NO forKey:JIsSetSecretShoushi];
        LoginVC *ll = [[LoginVC alloc] init];
        ll.isFrom = 66;
        UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        ll.navigationItem.backBarButtonItem = item;
        ll.navigationItem.hidesBackButton = YES;
        ll.navigationController.navigationBar.translucent = NO;
        [ll.navigationItem setHidesBackButton:YES];
        ll.hidesBottomBarWhenPushed = YES;
        [sel.navigationController pushViewController:ll animated:YES];
        [sel.navigationController popoverPresentationController];
        [alertl removeFromSuperviewi];
        
        
    };

  //  alrt.leftColor = RGB_red;
    alrt.rightColor = RGB_red;
    [alrt show];
    WDCAccount* wd=[WDCAccount sharedWDCAccount];
    [wd clear];
    [Tool clearStatus];
}
#pragma mark - 交互
//注册
- (IBAction)clickedLogin {
    
//    if(IS_TEST_1)
//    {
//    [self success];
//    return;
//    }
    if (![self verificateData]) {
        return;
    };
    
    if (self.isSelected.isSelected) {
        //验证码
        _isFirst = 101;
        //在验证码里面进行手机号的注册
        [self tesTSMS];
        
    }else{
       [self.view makeToast:@"请先阅读理财协议并同意" duration:1.5 position:@"center"];
        return;
    }
//    if(IS_TEST_1)
//    {
//        [self success];
//        return;
//    }
    
 
}
//用户协议
- (IBAction)clickedNew {
    HtmlZP *l = [[HtmlZP alloc] init];
    l.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:l animated:YES];
    
}
//选中同意
- (IBAction)clickedSelectedd:(UIButton *)sender {
    if (sender.isSelected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    
}
//点击发送验证码
- (IBAction)ClickedTimeBtn {
    [self.view endEditing:YES];
    
    self.timeBtn.selected = !self.timeBtn.isSelected;
    [self sendSMS];
}
- (void)beginCount:(NSTimer *)timer {
    self.num --;
    
    [self.timeBtn setTitle:[NSString stringWithFormat:@"%lds",self.num] forState:UIControlStateNormal];
    if (self.num==0) {
        self.timeBtn.userInteractionEnabled=YES;//.enabled = YES;
        
        [self.timeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        self.timeBtn.titleLabel.numberOfLines = 2;
        [self.timer invalidate];
        self.timer =nil;
        self.num=30;
        return;
    }
}
-(BOOL)verificateData
{
    if ((_yanzhengma.text == nil)|[_yanzhengma.text isEqualToString:@""])
    {
        if (_isSelected.selected) {
            [self.view makeToast:@"请输入验证码" ifSucess:NO];
        } else {
            [self.view makeToast:@"请点击发送验证码并输入验证码" ifSucess:NO];
        }
        
        return NO;
    }
    if (_yanzhengma.text.length !=4) {
        [self.view makeToast:@"请输入四位短信验证码" ifSucess:NO];
        return NO;
    }
    if ((_mima.text == nil)||[_mima.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
    
    if (([_mima.text length]<6) || ([_mima.text length]>20))
    {
        [self.view makeToast:@"密码应为6-20字符" ifSucess:NO];
        return NO;
    }
    if (![Tool validateIsNumberChar:_mima.text]) {
        [self.view makeToast:@"密码应为6-20英文字母或数字！"];
        return NO;
    }
    return YES;
}
#pragma mark - 其他
//文本框完成输入
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.yanzhengma) {
        if (_timeBtn.isSelected) {
            if (self.yanzhengma.text.length == 4) {
                [self tesTSMS];
            }else{
                [self.view makeToast:@"请输入四位验证码"];
            }
        }
        
    }
    
}
//退回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    self.isFromSelf = 0;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}





@end
