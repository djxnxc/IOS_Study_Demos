//
//  AccountHQShuhui.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountHQShuhui.h"
#import "AccountVC.h"
#import "PublicString.h"
#import "NameSure.h"
@interface AccountHQShuhui ()<HZMAPIManagerDelegate,UITextFieldDelegate>
{
    CGFloat  lixi_;
    CGFloat chiYouMoney;
    BOOL isTrue,isPassword;
}
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextClicked;

@end

@implementation AccountHQShuhui

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.layer.cornerRadius = self.nextBtn.bounds.size.height/2;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn setBackgroundColor:RGB_red];
    self.nextBtn.titleLabel.font = JFont(fontBtn);
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chiYouMoney=0.0;
   /* [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset1=[[HZMRequest alloc]init];
    requset1.requsetId=Check_Info;
    WDCAccount *a1 = [WDCUserManage getLastUserInfo];
    NSDictionary* dict1=@{@"type":@(1),@"userId":a1.userId};
    requset1.requestParamDic=dict1;
    requset1.callBackDelegate=self;
    requset1.tag=0x9001;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];*/
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    [self getMoneyDetail];
    self.detail.hidden = YES;
    
    if (From1(self)|From2(self)) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backa) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        //self.navigationItem.leftBarButtonItem = backItem;
        [self.navigationController.navigationItem setLeftBarButtonItem:backItem];
    }
    self.title=@"赎回";
    self.textfield.tag=119;
    self.textfield.delegate=self;
}
#pragma mark 可赎回金额
- (void)getMoneyDetail {
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounShuHuiJE_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
//#pragma mark 赎回利息
//#warning 暂无接口信息
//- (void)getMoneyMore {
//    WDCAccount *a = [WDCUserManage getLastUserInfo];
//    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
//                              a.userId,@"userId",nil];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[HZMAPImanager shareMAPImanager] addDelegate:self];
//    HZMRequest *request =[[HZMRequest alloc] init];
//    request.requsetId = AccounShuHuiLiXi_NetWoring;
//    request.requestParamDic = dicParams;
//    request.callBackDelegate = self;
//    request.tag = 0;
//    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
//}
#pragma mark 赎回操作
- (void)getMoneyNext:(NSString *)money {
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",
                              money,@"redeemAmt",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounShuHui_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    //赎回金额
    if ([response.requestId isEqualToString:AccounShuHuiJE_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *dic = [response.responseData objectForKey:@"data"];
            NSString *ss = [NSString stringWithFormat:@"%@",dic[@"curHadShare"]];
            chiYouMoney=[ss floatValue];
            if (ss.length>0) {
                
            ss = [NSString countNumAndChangeformat:ss];
            self.topLabel.text = [NSString stringWithFormat:@"     活期持有份额:￥%@",ss];
            }
            lixi_ = [dic[@"dayRate"] floatValue];
            
            [[HZMAPImanager shareMAPImanager]addDelegate:self];
            HZMRequest* requset1=[[HZMRequest alloc]init];
            requset1.requsetId=Check_Info;
            WDCAccount *a1 = [WDCUserManage getLastUserInfo];
            NSDictionary* dict1=@{@"type":@(1),@"userId":a1.userId};
            requset1.requestParamDic=dict1;
            requset1.callBackDelegate=self;
            requset1.tag=0x9001;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
    }}
//    //赎回利息
//    if ([response.requestId isEqualToString:AccounShuHuiLiXi_NetWoring]) {
//        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
//            
//            lixi_ = 0.5;
//        }}
    //赎回
    if ([response.requestId isEqualToString:AccounShuHui_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
          
            NSString *sss = [NSString stringWithFormat:@"%@",self.textfield.text];
            sss = [NSString countNumAndChangeformat:sss];
            
            NSString *ss = [NSString stringWithFormat:@"您已成功赎回%@元，赎回的钱将转移到您的账户余额",sss];
            ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:ss leftButtonTitle:nil rightButtonTitle:@"查看"];
            __weak ZendaiAlertView *alertt = alert;
            __weak AccountHQShuhui *sel = self;
            alert.cha.hidden=YES;
            alert.leftBlock  =^(){
                
                [alertt removeFromSuperviewi];
            };
            alert.rightBlock = ^(){
#warning 保留了NAV中每个VC的地址，注意是佛安全。
                [sel.navigationController popToViewController:sel.del animated:YES];
                
                [alertt removeFromSuperviewi];
            };
            alert.leftColor=RGB_red;
            alert.rightColor = RGB_red;
            [alert show];
            
            
        }
        
    }
    
    if ([response.requestId isEqualToString:Check_Info]) {//获得是否实名认证
        if(response.tag==0x9001)
        {
            int result=[[response.responseData objectForKey:@"code"] intValue];
            if (result==1) {
                isTrue=YES;
                [Tool setBool:YES forKey:JIsNamesure];
                //[Tool setObject:[NSNumber numberWithBool:YES] forKey:JIsNamesure];
            }else{
                isTrue=NO;
            }
            [[HZMAPImanager shareMAPImanager]addDelegate:self];
            HZMRequest* requset1=[[HZMRequest alloc]init];
            requset1.requsetId=Check_Info;
            WDCAccount *a1 = [WDCUserManage getLastUserInfo];
            NSDictionary* dict1=@{@"type":@(2),@"userId":a1.userId};
            requset1.requestParamDic=dict1;
            requset1.callBackDelegate=self;
            requset1.tag=0x9002;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
            
        }
        if (response.tag==0x9002) {
            int result=[[response.responseData objectForKey:@"code"] intValue];
            if (result==1) {
                isPassword=YES;
            }else{
                isPassword=NO;
            }
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
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.some =self;
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}
#pragma mark 下一步
- (IBAction)nextClicked{
    if (![Tool boolForKey:JIsNamesure]) {
        //[self.view makeToast:@"请先进行实名认证！" duration:JDuration position:@"center"];
        ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"请先进行实名认证！" leftButtonTitle:@"暂不认证" rightButtonTitle:@"实名认证"];
        __weak ZendaiAlertView *alertt = alert;
        __weak AccountHQShuhui *sel = self;
        alert.cha.hidden=YES;
        alert.leftBlock  =^(){
            
            [alertt removeFromSuperviewi];
        };
        alert.rightBlock = ^(){
            NameSure *n = [[NameSure alloc] init];
            n.isform = 1;
            n.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:n  animated:YES];
            
            [alertt removeFromSuperviewi];
        };
        alert.leftColor=RGB_red;
        alert.rightColor = RGB_red;
        [alert show];
        return;
    }
    NSString* ts=self.textfield.text;
    if (ts.length==0) {
        ts=@"0";
    }
    if ([ts floatValue]==0) {
        [self.view makeToast:@"请输入赎回金额！" duration:JDuration position:@"center"];
        return;
    }
   
    if ( [self.textfield.text floatValue]>chiYouMoney) {
        [self.view makeToast:@"金额不得大于持有份额！" duration:JDuration position:@"center"];
        return;
    }
    if ([ts floatValue]<=0) {
        [self.view makeToast:@"请输入赎回金额！" duration:JDuration position:@"center"];
        return;
    }
    
    [self.view endEditing:YES];
    [self getMoneyNext:self.textfield.text];
}
#pragma mark textfield代理
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    
//    self.detail.text = [NSString stringWithFormat:@"赎回后，您7天的利益将减少%.2lf",7*lixi_* [self.textfield.text floatValue]];
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    NSString* rest=[textField.text stringByAppendingString:string];
    NSString* ciyou=[NSString stringWithFormat:@"%.2f",chiYouMoney];
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSArray* thArr=[textField.text componentsSeparatedByString:@"."];
    if (thArr.count==2) {
        NSString* subS=[thArr objectAtIndex:1];
        if (subS) {
            if (subS.length>=2 && string.length>0) {
                return NO;
            }
        }
    }
    
    if (string.length>0) {
     
    if([rest doubleValue]>[ciyou doubleValue])
    {
        [self.nextBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.nextBtn.enabled=NO;
        
//        return NO;
    }else{
        
            
        [self.nextBtn setBackgroundColor:[UIColor colorWithRed:0.98 green:0.44 blue:0.43 alpha:1]];
        self.nextBtn.enabled=YES;
        
    }
    }else{
        NSString* substr=[rest substringToIndex:rest.length-1];
        
        if([substr floatValue]>[ciyou floatValue])
        {
            [self.nextBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.nextBtn.enabled=NO;
            
            //        return NO;
        }else{
            
            
            [self.nextBtn setBackgroundColor:[UIColor colorWithRed:0.98 green:0.44 blue:0.43 alpha:1]];
            self.nextBtn.enabled=YES;
            
        }
    }
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
//    NSArray* thArr=[textField.text componentsSeparatedByString:@"."];
//    if (thArr.count==2) {
//        NSString* subS=[thArr objectAtIndex:1];
//        if (subS) {
//            if (subS.length>=2 && string.length>0) {
//                return NO;
//            }
//        }
//    }
    if ([string isEqualToString:@"."]&&textField.text.length==0 &&textField.tag==119) {
        textField.text=@"0";
    }

    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if ([toBeString length]) { //输入
//        if (([toBeString length]==1&&[toBeString isEqualToString:@"0"]) ) {
//            [self.view makeToast:@"输入格式不对"];
//             return NO;
//        }
        self.detail.hidden = NO;
        self.detail.text = [NSString stringWithFormat:@"赎回后，您7天的利益将减少%0.2f",7*lixi_* [toBeString  floatValue]];
       return YES;
    }else if([toBeString length] == 0){//减掉
        self.detail.hidden= YES;
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.detail.hidden= YES;
    [self.view endEditing:YES];
    return YES;
}
//退回键盘
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
