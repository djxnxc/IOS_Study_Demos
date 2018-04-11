//
//  LoginVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/25.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "LoginNewAccountO.h"
#import "LoseLoginFind.h"
#import "LoginNewAccountT.h"
#import "UIButton+WebCache.h"
@interface LoginNewAccountO ()<HZMAPIManagerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnh;

@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
- (IBAction)clickedLogin;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengma;
- (IBAction)clickedYZM;

@end

@implementation LoginNewAccountO

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新用户注册";
    self.viewH.constant = 35*ratioH;
    
    self.loginbtn.layer.cornerRadius = 35.0/2*ratioH;
    self.loginbtn.layer.masksToBounds = YES;
    [self.loginbtn setBackgroundColor:RGB_red];
    self.loginbtn.titleLabel.font = JFont(fontBtn);
    self.btnh.constant = 35.0*ratioH;
    
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
     [_yanzhengma setBackgroundImage:nil forState:UIControlStateNormal];
    [_yanzhengma.layer setCornerRadius:5];
    [_yanzhengma.layer setMasksToBounds:YES];
    
    //多线程按顺序执行任务
    //1、串行队列+异步 这个不用写了应该
    
    //2、GCD使用barrier
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
       //下载图片1
    });
    dispatch_barrier_async(queue1, ^{
        //下载图片2
        //barrier（栅栏 ）执行完任务1才会执行任务2，任务2执行完才执行任务3
    });
    dispatch_async(queue1, ^{
        //下载图片3
    });
    //3、NSOpeartion，用addDenpency(添加依赖关系)来实现
    NSOperationQueue *queue2 = [[NSOperationQueue alloc]init];
    NSBlockOperation *A=[NSBlockOperation blockOperationWithBlock:^{
    }];
    NSBlockOperation *B=[NSBlockOperation blockOperationWithBlock:^{
    }];
    
    NSBlockOperation *C=[NSBlockOperation blockOperationWithBlock:^{
    }];
    //添加依赖关系 先执行后者 即执行完A在执行B
    [B addDependency:A];
    [C addDependency:B];
    //添加到队列
    [queue2 addOperation:A];
    [queue2 addOperation:B];
    [queue2 addOperation:C];
    //执行结果A  B  C
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载1
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载2
    });
   
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //界面刷新
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载3
    });
    //结果 1 2 3
}

- (void)viewWillAppear:(BOOL)animated{
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [self reloadImg];
}
#pragma mark - 网络
- (void)reloadImg {
    //http://116.226.191.6:9901/passport
    //http://116.226.191.6:9081
    NSString *urlStr = [NSString stringWithFormat:@"%@/code.p2p?type=1&divnceId=%@", SERVICE_Passort_URL,PHONEID];
    [_yanzhengma sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)reloadData {
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              self.phone.text,@"phoneNum",
                              self.mima.text,@"code",
                              PHONEID,@"divnceId",nil];
    
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = LoginYZMTestImg_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:LoginYZMTestImg_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]) {//验证码不OK
            [self.view makeToast:[response.responseData objectForKey:@"message"] duration:JDuration1 position:@"center"];
        } else if ([response.responseCodeOriginal isEqualToString:@"1"]){//验证码OK
            [self.view makeToast:[response.responseData objectForKey:@"message"] duration:JDuration1 position:@"center"];
            LoginNewAccountT *l = [[LoginNewAccountT alloc]init];
            l.hidesBottomBarWhenPushed = YES;
            l.phone = self.phone.text;
            [self.navigationController pushViewController:l animated:YES];
        }
        
    }
}
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:JDuration1 position:@"center"];
    }else{
        [self.view makeToast:response.responseMsg duration:JDuration1 position:@"center"];}
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.responseCodeOriginal isEqualToString:@"-2"]) {
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - 交互
#pragma mark 下一步
- (IBAction)clickedLogin {
#warning 测试用
//    if (IS_TEST_1) {
//        LoginNewAccountT *l = [[LoginNewAccountT alloc]init];
//        l.hidesBottomBarWhenPushed = YES;
//        l.phone = self.phone.text;
//        [self.navigationController pushViewController:l animated:YES];
//        return;
//    }
//    
    //校验手机号
    if (![self verificateData]) {
        return;
    };
    [self.view endEditing:YES];
    [self reloadData];

    
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
    if ((_mima.text == nil)||[_mima.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入验证码" ifSucess:NO];
        return NO;
    }
    
    return YES;
}

#pragma mark 验证码刷新
- (IBAction)clickedYZM {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self reloadImg];
    self.mima.text = @"";
}

#pragma mark - 其他
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
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
        [self.navigationController popViewControllerAnimated:YES];
}




@end
