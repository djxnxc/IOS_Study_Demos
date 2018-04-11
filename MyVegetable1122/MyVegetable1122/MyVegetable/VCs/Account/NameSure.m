//
//  NameSure.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "NameSure.h"
#import "CardSure.h"
#import "UIViewControllerFactory.h"
@interface NameSure ()<HZMAPIManagerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sure;
- (IBAction)sureClicked;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View2H;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *card;
@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *inputCard;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation NameSure

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
    self.View1H.constant = 50*ratioH;
    self.View2H.constant = 50*ratioH;
    self.title = @"实名认证";
    self.view.backgroundColor = RGB_gray;
    _sure.backgroundColor = RGB_red;
    self.btnH.constant = 35.0*ratioH;
    _sure.layer.cornerRadius = 35.0/2*ratioH;
    _sure.layer.masksToBounds = YES;
    [_sure setTitle:@"确认" forState:UIControlStateNormal];
    _sure.titleLabel.font = JFont(fontBtn);
    self.name.font = JFont13;
    self.card.font = JFont13;
    self.inputName.font = JFont13;
    self.inputCard.font = JFont13;
    self.detail.font = JFont10;
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
}


#pragma mark - 网络
#pragma mark 确认修改
- (void)nextNetWorking {
    WDCAccount *a1 = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              _inputName.text,@"userName"
                              ,_inputCard.text,@"idNo",
                              a1.userId,@"userId", nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounNameSure_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounNameSure_NetWoring]) {//重置密码
        if([[response.responseData objectForKey:@"code"]intValue]==1){
            //[self.view makeToast:[response.responseData objectForKey:@"message"] duration:2];
            [Tool setBool:YES forKey:JIsNamesure];
            //[self.navigationController popViewControllerAnimated:YES];
            /*
            ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:[response.responseData objectForKey:@"message"] leftButtonTitle:nil rightButtonTitle:@"返回设置"];
            __weak ZendaiAlertView *alertt = alert;
            __weak NameSure *sel =self;
            alert.cha.hidden=YES;
            alert.rightBlock = ^(){
                if (sel.isform == 1) {
                    CardSure *c = [[CardSure alloc] init];
                    c.hidesBottomBarWhenPushed= YES;
                    [sel.navigationController popViewControllerAnimated:YES];
                }
                [alertt removeFromSuperviewi];
            };
            alert.leftBlock = ^(){
                [sel.navigationController popToRootViewControllerAnimated:YES];
                [alertt removeFromSuperviewi];
            };
            alert.leftColor = RGB_red;
            alert.rightColor = RGB_red;
            [alert show];*/
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:[response.responseData objectForKey:@"message"] duration:2];
//            ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:[response.responseData objectForKey:@"message"] leftButtonTitle:nil rightButtonTitle:@"设置交易密码"];
//            __weak ZendaiAlertView *alertt = alert;
//            
//            alert.cha.hidden=YES;
////            alert.leftBlock  =^(){
////                
////                [alertt removeFromSuperviewi];
////            };
//            alert.rightBlock = ^(){
//                SetUpTrPasswordViewController *stv=[UIViewControllerFactory getViewController:Trad_Password];
//                [self.navigationController pushViewController:stv animated:YES];
//                
//                [alertt removeFromSuperviewi];
//            };
//            alert.leftColor=RGB_red;
//            alert.rightColor = RGB_red;
//            [alert show];
//            
            
        }
    }
    
}
//521693364
//unc732
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounNameSure_NetWoring])
    {
        if ([response.responseCodeOriginal isEqualToString:@"2"]) {
//            SetUpTrPasswordViewController *stv=[UIViewControllerFactory getViewController:Trad_Password];
//            [self.navigationController pushViewController:stv animated:YES];
            ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:[response.responseData objectForKey:@"message"] leftButtonTitle:nil rightButtonTitle:@"设置交易密码"];
            __weak ZendaiAlertView *alertt = alert;
            
            alert.cha.hidden=YES;
            //            alert.leftBlock  =^(){
            //
            //                [alertt removeFromSuperviewi];
            //            };
            alert.rightBlock = ^(){
                SetUpTrPasswordViewController *stv=[UIViewControllerFactory getViewController:Trad_Password];
                [self.navigationController pushViewController:stv animated:YES];
                
                [alertt removeFromSuperviewi];
            };
            alert.leftColor=RGB_red;
            alert.rightColor = RGB_red;
            [alert show];
            [Tool setBool:YES forKey:JIsNamesure];
        }
    }
    if ([response.responseCodeOriginal isEqualToString:@"-99"]) {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 88;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}
#pragma mark - 交互
- (IBAction)sureClicked{
    [self.view endEditing:YES];
    if (![self verificateData]) {
        return;
    };
    [self nextNetWorking];
}


-(BOOL)verificateData
{
    if ((_inputName.text == nil)|[_inputName.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入名称" ifSucess:NO];
        return NO;
    }
    if (![Tool validateIdentityCard:_inputCard.text]) {
        [self.view makeToast:@"请输入正确的身份证号码" ifSucess:NO];
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


@end
