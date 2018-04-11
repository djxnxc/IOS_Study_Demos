//
//  LoseLoginThree.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "LoseLoginFind.h"
#import "LoseLoginReset.h"
@interface LoseLoginFind ()<HZMAPIManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sure;
- (IBAction)sureClicked;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *myNum;

@property (weak, nonatomic) IBOutlet UIButton *get;
- (IBAction)getClicked;

@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getW;

@end

@implementation LoseLoginFind

- (void)viewDidLoad {
    [super viewDidLoad];
    self.num = 30;
    self.title = @"找回密码";
    self.view.backgroundColor = RGB_gray;
    _sure.backgroundColor = RGB_red;
    _sure.layer.cornerRadius = 35.0/2*ratioH;
    _sure.layer.masksToBounds = YES;
    [_sure setTitle:@"下一步" forState:UIControlStateNormal];
    _sure.titleLabel.font = JFont(fontBtn);
    [self configUI];
    self.h1.constant = 50.0*ratioH;
    self.h2.constant = 35.0*ratioH;
    self.getH.constant = 30*ratioH;
    self.getW.constant = 60*ratioH;
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
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
    _get.layer.cornerRadius = 5.0;
    _get.layer.masksToBounds = YES;
    [_get setBackgroundColor:RGB_red];
    [_get setTitle:@"获取验证码" forState:UIControlStateNormal];
    _get.titleLabel.font = JFont(11);
    
    
}
#pragma mark - 网络
#pragma mark 获取验证码
- (void)sendNetWorking {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"1",@"type"
                              ,self.phone.text,@"phoneNum",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = LoginYZMGetSMS_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
#pragma mark 下一步
- (void)nextNetWorking {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"1",@"type"
                              ,self.phone.text,@"phoneNum",
                              _myNum.text,@"identifyCode",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = LoginYZMTestSMS_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:LoginYZMGetSMS_NetWoring]) {//验证码
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:2 position:@"center"];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
        self.get.enabled = NO;
        
    }else if ([response.requestId isEqualToString:LoginYZMTestSMS_NetWoring]){//下一步
        if([response.responseCodeOriginal isEqualToString:@"1"]){
            LoseLoginReset *r = [[ LoseLoginReset alloc] init];
            r.phoneNum = self.phone.text;
            r.code = self.myNum.text;
            r.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:r animated:YES];
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
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}

///下一步
- (IBAction)sureClicked{
    [self.view endEditing:YES];
    if (![self verificateData]) {
        return;
    };
    [self nextNetWorking];
//#warning ceshi
//    LoseLoginReset *r = [[ LoseLoginReset alloc] init];
//    r.phoneNum = self.phone.text;
//    r.code = self.myNum.text;
//    r.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:r animated:YES];
    
}
//获取验证码
- (IBAction)getClicked {
    [self.view endEditing:YES];
    if (![self verificate]) {
        return;
    };
    [self sendNetWorking];
    
}
//校验格式
-(BOOL)verificateData
{
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return NO;
    }
    if ((_myNum.text == nil)||[_myNum.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入验证码" ifSucess:NO];
        return NO;
    }
    
    if ([_myNum.text length]!=4)
    {
        [self.view makeToast:@"验证码是四位数字" ifSucess:NO];
        return NO;
    }
    
    return YES;
}
-(BOOL)verificate
{
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return NO;
    }
    
    return YES;
}
- (void)beginCount:(NSTimer *)timer {
    self.num --;
    
    [self.get setTitle:[NSString stringWithFormat:@"%lds",self.num] forState:UIControlStateNormal];
    if (self.num==0) {
        self.get.enabled = YES;
        [self.get setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer =nil;
        self.num=30;
        return;
    }
}

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