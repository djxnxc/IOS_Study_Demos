  //
//  LoginVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/25.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "BuyOne.h"
#import "PayOne.h"
#import "NameSure.h"
#import "MainTabbarController.h"
#import "FinancingVC.h"
#import "DingLICAIModel.h"
#import "Tiyanjin.h"
#import "TiyanjinCell.h"
#import "ChongZhi.h"
@interface BuyOne ()<UITextFieldDelegate,HZMAPIManagerDelegate,UITableViewDataSource,UITableViewDelegate,TYJChangDelegate>
{
    //总的体验金
    NSInteger _totalMoney;
    //优惠券列表
    NSString *couponId;
    //体验金列表
    NSMutableArray *tyjData;
    //选择的体验金列表
    NSMutableArray *selectData;
    //选择的体验金列表
    NSInteger yue;
    NSInteger kegou;
    CGFloat minRate;
    
    BOOL isTrue;//实名认证
    BOOL isPassword;//设置交易密码；
    
    NSString* overSecont;
    NSTimer *timer;
    
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnH;
@property (weak, nonatomic) IBOutlet UILabel *topOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *topshengyu;
@property (weak, nonatomic) IBOutlet UILabel *topKegou;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewH;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UITextField *text;

@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *popLabel;

@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *totalPay;
@property (weak, nonatomic) IBOutlet UIButton *surebtn;

- (IBAction)buyClicked;
- (IBAction)clickedSure;


@property (weak, nonatomic) IBOutlet UILabel *willhidLbael;
@property (weak, nonatomic) IBOutlet UIView *willhidView;
@property (weak, nonatomic) IBOutlet UILabel *willhidKeYongLabel;
@property (weak, nonatomic) IBOutlet UISwitch *willHidswitch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelH;
@property (weak, nonatomic) UISwitch *witch;
@end

@implementation BuyOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
     self.num = 60;
    self.popView.hidden = YES;
    self.title = @"购买";
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (iPhone6P|iPhone6) {
        
        _BtnH.constant = 40;
        _topViewH.constant = 240;
        _labelH.constant = 56;
        self.surebtn.layer.cornerRadius = 40.0/2;
    } else {
        
        _BtnH.constant = 35;
        _topViewH.constant = 210;
        _labelH.constant = 45;
        self.surebtn.layer.cornerRadius = 35.0/2;
    }
    
    self.surebtn.layer.masksToBounds = YES;
    [self.surebtn setBackgroundColor:RGB_red];
    self.surebtn.titleLabel.font = JFont(fontBtn);
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
    if (self.isfrom == 22|self.isfrom == 23|self.isfrom == 24) {
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(-2, 0, 12, 20);
            UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
            buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [backBtn setImage:buttonImage forState:UIControlStateNormal];
            [backBtn addTarget:self action:@selector(backa) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
            self.navigationItem.leftBarButtonItem = backItem;
    }
    
    [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset1=[[HZMRequest alloc]init];
    requset1.requsetId=Check_Info;
    WDCAccount *a1 = [WDCUserManage getLastUserInfo];
    NSDictionary* dict1=@{@"type":@(1),@"userId":a1.userId};
    requset1.requestParamDic=dict1;
    requset1.callBackDelegate=self;
    requset1.tag=0x9001;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
    _witch=[[UISwitch alloc]init];
    _witch.on=NO;
    
   
//    _willHidswitch.enabled = YES;
//    _witch.on = YES;
    tyjData = [NSMutableArray array];
    selectData = [NSMutableArray array];
    [self.tableView  registerNib:[UINib nibWithNibName:@"TiyanjinCell" bundle:nil] forCellReuseIdentifier:@"TiyanjinCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = NO;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    if (self.isfrom!=22) {
        BuyModel* nn;
        if (self.isfrom==23) {
            
    DingLICAIModel *model = [self.data objectAtIndex:0];
     nn=model.model;
        }else{
            nn=self.data[0];
        }
    NSInteger bStatus=nn.buttonStatus;
    if (bStatus==1) {
        overSecont=nn.timeLine;
        self.ProdctID=[NSString stringWithFormat:@"%lld",nn.productId];
        self.surebtn.enabled=NO;
        [self.surebtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.surebtn setTitle:[self getTime] forState:UIControlStateNormal];
        timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
        //立即预约
        NSString* ss=@"如有意购买本产品，请点击“立即预约”。系统将在开标前5分钟，通过短信通知到您！";
        ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:ss leftButtonTitle:@"暂不预约" rightButtonTitle:@"立即预约"];
        __weak ZendaiAlertView *alertt = alert;
        //__weak AccountHQShuhui *sel = self;
        alert.leftBlock  =^(){
            
            [alertt removeFromSuperviewi];
        };
        alert.rightBlock = ^(){
#warning 保留了NAV中每个VC的地址，注意是佛安全。
            WDCAccount *a = [WDCUserManage getLastUserInfo];
            NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                                      a.userId,@"userId",
                                      self.ProdctID,@"loanId",
                                      nil];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[HZMAPImanager shareMAPImanager] addDelegate:self];
            HZMRequest *request =[[HZMRequest alloc] init];
            request.requsetId = User_Appointment;
            request.requestParamDic = dicParams;
            request.callBackDelegate = self;
            request.tag = 0;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
            [alertt removeFromSuperviewi];
        };
        alert.leftColor=RGB_red;
        alert.rightColor = RGB_red;
        [alert show];
        //
        
        
    }else if(bStatus==2){
        [self.surebtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    }else if(bStatus==3){
        [self.surebtn setTitle:@"敬请期待" forState:UIControlStateDisabled];
        [self.surebtn setTitle:@"敬请期待" forState:UIControlStateNormal];
        self.surebtn.enabled=NO;
        [self.surebtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _witch.on=NO;
    
//    [super viewWillAppear:animated];
    if (self.isfrom == 24) {
//        self.willhidView.hidden = NO;
        self.willhidLbael.hidden = NO;
//        _willHidswitch.on = YES;
        [self getMoney];
    }else
    {
//        self.willhidView.hidden = YES;
        self.willhidLbael.hidden = YES;
//        _willHidswitch.on = NO;
    }
    [self getProduct ];
    if (self.data.count) {
        id m = [self.data objectAtIndex:0];
        if ([m isKindOfClass:[BuyModel class]]) {
            BuyModel *model = [self.data objectAtIndex:0];
            self.name = model.title;
            self.canBuy = [NSString stringWithFormat:@"%.2f", model.amount];
            self.minInterest = model.minInterest;
            self.minInvestAmount = [NSString stringWithFormat:@"%ld", model.minInvestAmount];
            self.maxInvestAmount = [NSString stringWithFormat:@"%lld", model.maxInvestAmount];
            minRate=model.minRate;
        }else if([m isKindOfClass:[DingLICAIModel class]]){
            DingLICAIModel *ff = [self.data objectAtIndex:0];
            BuyModel *model = ff.model;
            self.name = model.title;
            self.canBuy = [NSString stringWithFormat:@"%.2f", model.amount];
            self.minInterest = model.minInterest;
            self.minInvestAmount = [NSString stringWithFormat:@"%ld", model.minInvestAmount];
            self.maxInvestAmount = [NSString stringWithFormat:@"%lld", model.maxInvestAmount];
        }
    }
    
    
    if (self.text.text.length>=1) {
       self.totalPay.hidden = NO;
    }else
    self.totalPay.hidden = YES;
    
    self.topOneLabel.text = self.name;
    NSString *ss = [NSString stringWithFormat:@"%@",self.canBuy];
    kegou=[ss integerValue];
    ss = [NSString countNumAndChangeformat:ss];
    self.topKegou.text =[NSString stringWithFormat:@"￥%@",ss];
    self.detailLabel.text = [NSString stringWithFormat:@"起投金额为:%@元",self.minInvestAmount];
    if (self.maxInvestAmount.length>1) {
        //NSString *s = [NSString countNumAndChangeformat:self.maxInvestAmount];
        //self.detailLabel.text = [NSString stringWithFormat:@"%@",self.detailLabel.text];
    }
    self.topOneLabel.adjustsFontSizeToFitWidth = YES;
    
    
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
    [self.navigationController.navigationBar setHidden:NO];
    if (self.isfrom==24) {
        self.text.enabled=NO;//新手标禁输入
        
    }else{
        self.text.enabled=YES;
        self.tableView.hidden=YES;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    for (UIView *v  in self.view.subviews) {
        v.userInteractionEnabled = YES;
        if (v.subviews.count>=1) {
            for (UIView *v  in self.view.subviews) {
                v.userInteractionEnabled = YES;
                if (v.subviews.count>=1) {
                    for (UIView *v  in self.view.subviews) {
                        v.userInteractionEnabled = YES;
                    }
                }
            }
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    
    BOOL i =  [self isBeingPresented ];
    BOOL j =  [self isBeingDismissed ];
    BOOL k =  [self isMovingToParentViewController ];
    BOOL l =  [self isMovingFromParentViewController ];
    BOOL ll =  [self isMovingFromParentViewController ];
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JSCREEN_W, JSCREEN_H)];
//    [self.view addSubview:v];
//    v.backgroundColor = [UIColor whiteColor];
//    v.tag = Tagteshu;
//    [self.view bringSubviewToFront:v];
    if (timer) {
        [timer invalidate];
        timer =nil;
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!self.text.text.length) {
        self.totalPay.hidden = YES;
        self.popView.hidden = YES;
    }
   
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (!self.text.text.length) {
        self.totalPay.hidden = YES;
        self.popView.hidden = YES;
    }else{
        self.totalPay.hidden = NO;
        self.popView.hidden = NO;
        NSString *ss = [NSString stringWithFormat:@"%@",self.text.text];
        if (ss.length==0) {
            ss=@"0";
        }
        ss = [NSString countNumAndChangeformat:ss];
        self.totalPay.text = [NSString stringWithFormat:@"总计支付%@元",ss];
        if (!_witch.isOn) {
            CGFloat yu=[self.text.text floatValue]*self.minInterest/[self.minInvestAmount floatValue];
            if (self.isfrom==22) {
                self.popLabel.text = [NSString stringWithFormat:@"预计每月收益%.2lf",yu];
            }else
        self.popLabel.text = [NSString stringWithFormat:@"预计收益%.2lf",yu];
        }
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString* str=@"";
    if (string.length>0) {
        
        str=[textField.text stringByAppendingString:string];
    }else{
        str=[textField.text substringToIndex:textField.text.length-1];
    }
    if (textField.text.length>1) {
        self.totalPay.hidden = NO;
        self.popView.hidden = NO;
        NSString* ss=[NSString countNumAndChangeformat:str];
        self.totalPay.text = [NSString stringWithFormat:@"总计支付%@元",ss];
        if (!_witch.isOn) {
            CGFloat yu=([str floatValue]*self.minInterest)/[self.minInvestAmount floatValue];
            if (self.isfrom==22) {
                self.popLabel.text = [NSString stringWithFormat:@"预计每月收益%.2lf",yu];
            }else{
                self.popLabel.text = [NSString stringWithFormat:@"预计收益%.2lf",yu];
            }
        }
    }else {
        self.popView.hidden = YES;
        self.totalPay.hidden = YES;
    }
    if ([string isEqualToString:@"."]&&textField.text.length==0) {
        textField.text=@"0";
    }
       
    
    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.popView.hidden= YES;
    [self.view endEditing:YES];
    return YES;
}
#pragma mark 获取产品信息
- (void)getProduct {
   WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounTotal_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)getMoney{
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",
                              @"2",@"rewardType",
//                              @"1",@"pageNum",
//                              @"100",@"pageSize",
                              nil];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounJiangLi_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounTotal_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *dictt = [response.responseData objectForKey:@"data"];
            NSString *ss = [NSString stringWithFormat:@"%@",[dictt objectForKey:@"accountAmt"]];
            yue = [ss integerValue];
            ss = [NSString countNumAndChangeformat:ss];
            self.topshengyu.text = [NSString stringWithFormat:@"￥%@",ss];
            
        }
    }
    if ([response.requestId isEqualToString:User_Appointment]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            [self.view makeToast:@"恭喜您！预约申请成功！" duration:2];
        }
    }
    if ([response.requestId isEqualToString:AccounJiangLi_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *d = [response.responseData objectForKey:@"data"];
            NSInteger j=0;
            [tyjData removeAllObjects];
            NSArray *arr = d[@"rewardResultList"];
                for (NSDictionary *dic in arr) {
                    Tiyanjin *model = [[Tiyanjin alloc] initWithDic:dic];
                    if (model.status==1) {
                     
                    j+=  [dic[@"amount"] integerValue];
                    }
                    [tyjData addObject:model];
                }
            _totalMoney = j;
            if (self.isfrom == 24) {
                if (j==0) {
//                    _willHidswitch.on = NO;
//                    _willHidswitch.enabled = NO;
                    //[self.view makeToast:@"目前无体验金可用，不可购买新手标！"];
                    self.tableView.hidden=YES;
                    [self.surebtn setBackgroundColor:[UIColor lightGrayColor]];
                    self.surebtn.enabled=NO;
                    if (arr.count>0) {
                        [self.surebtn setTitle:@"您已经购买过" forState:UIControlStateNormal];
                        self.surebtn.enabled=NO;
                        [self.surebtn setBackgroundColor:[UIColor lightGrayColor]];
                    }else{
                        [self.surebtn setTitle:@"无体验金" forState:UIControlStateNormal];
                    }
                }
            }
            [self.tableView reloadData];
        }
    }
    if ([response.requestId isEqualToString:Check_Info]) {//获得是否实名认证
        if(response.tag==0x9001)
        {
            int result=[[response.responseData objectForKey:@"code"] intValue];
            if (result==1) {
                isTrue=YES;
                [Tool setObject:[NSNumber numberWithBool:YES] forKey:JIsNamesure];
            }else{
                isTrue=NO;
                [Tool setObject:[NSNumber numberWithBool:NO] forKey:JIsNamesure];
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
                [Tool setObject:[NSNumber numberWithBool:YES] forKey:JSaveSecretShoushi];
            }else{
                isPassword=NO;
                [Tool setObject:[NSNumber numberWithBool:YES] forKey:JSaveSecretShoushi];
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
        l.some =self;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}

#pragma mark - 交互
#pragma mark  充值
- (IBAction)buyClicked {
    if (![Tool boolForKey:JIsNamesure]) {//实名认证
        ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"请先进行实名认证！" leftButtonTitle:@"暂不认证" rightButtonTitle:@"实名认证"];
        __weak ZendaiAlertView *alertt = alert;
        
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
    }else {
        ChongZhi *c = [[ChongZhi alloc] init];
        [self.navigationController pushViewController:c animated:YES];
//        NameSure *n = [[NameSure alloc] init];
//        n.isform = 1;
//        n.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:n  animated:YES];
    }
    
}
#pragma mark  确定
- (IBAction)clickedSure {
    if (![Tool boolForKey:JIsNamesure]) {
       // [self.view makeToast:@"请先进行实名认证！" duration:JDuration position:@"center"];
        ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"请先进行实名认证！" leftButtonTitle:@"暂不认证" rightButtonTitle:@"实名认证"];
        __weak ZendaiAlertView *alertt = alert;
        
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
    if(![Tool boolForKey:JSaveSecretShoushi])
    {
        [self.view makeToast:@"请先设置交易密码！" duration:JDuration position:@"center"];
        return;
    }
    BuyModel *model = self.data[0];
    NSString *str = self.text.text;
    NSRange _range = [str rangeOfString:@" "];
    NSRange _range2 = [str rangeOfString:@"."];
    if (/*_witch.isOn == NO&&*/ self.isfrom!=24) {//关
        //判空
        
        
        if ([str isKindOfClass:[NSNull class]]|(str.length ==0)|_range.location != NSNotFound) {
            [self.view makeToast:@"请先输入投资金额" duration:JDuration position:@"center"];
            return;
        }
        
        if ([_text.text integerValue]>yue && self.isfrom!=24) {
            [self.view makeToast:@"账户余额不足"];
            return;
        }
        
        
        if ([str doubleValue]<[self.minInvestAmount doubleValue]) {
            [self.view makeToast:[NSString stringWithFormat:@"起投金额为%@",self.minInvestAmount] duration:JDuration position:@"center"];
            return;
        }
        if (([str intValue]%[self.minInvestAmount integerValue]>0 )) {
            [self.view makeToast:[NSString stringWithFormat:@"投资金额为%@整数倍",self.minInvestAmount] duration:JDuration position:@"center"];
            return;
        }
        if ([_text.text doubleValue]>[self.maxInvestAmount doubleValue]) {
            [self.view makeToast:[NSString stringWithFormat:@"单笔购买金额，必须小余或等于最大限额！（限额：%@）",self.maxInvestAmount]];
            return;
        }
    }else{
        if ([_text.text doubleValue]<=0) {
            [self.view makeToast:@"请选择你的体验金！" duration:JDuration position:@"center"];
            return;
        }
    }
    if ([_text.text floatValue]>[self.canBuy floatValue]) {
        [self.view makeToast:@"您输入金额大于可购份额！" duration:2.0];
        return;
    }
    
    PayOne *p = [[PayOne alloc] init];
    p.hidesBottomBarWhenPushed= YES;
    p.payNum = [self.text.text intValue];
    if (self.data.count) {
        id m = [self.data objectAtIndex:0];
        if ([m isKindOfClass:[BuyModel class]]) {
            BuyModel *model = [self.data objectAtIndex:0];
            p.prodctID = [NSString stringWithFormat:@"%lld",model.productId];
        }else if([m isKindOfClass:[DingLICAIModel class]]){
            DingLICAIModel *ff = [self.data objectAtIndex:0];
            BuyModel *model = ff.model;
            p.prodctID = [NSString stringWithFormat:@"%lld",model.productId];
        }
    }
    p.isFrom=self.isfrom;
    p.List = [NSString stringWithFormat:@"%ld",_witch.tag];
    if (_witch.isOn == YES) {
        p.ListAmount =[NSString stringWithFormat:@"%ld",_totalMoney];
    }else
        p.ListAmount =@"0";
    [self.navigationController pushViewController:p animated:YES];
}
#pragma mark  返回
- (void)backa{
    
    MainTabbarController *t = [[MainTabbarController alloc] initWith:22];
    //发送消息
    if (self.isfrom == 22) {//活期
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"99"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else if (self.isfrom == 23){//定期
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"0"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else if (self.isfrom == 24){//新手标
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"101"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    [self presentViewController:t animated:YES completion:nil];
//    self.view.window.rootViewController = t;
//     [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 点击switch开关
- (void)tyjChoose:(UISwitch *)s father:(id)tyjCell {
    self.witch = s;
    if (s.on) {
        
    TiyanjinCell* cell=tyjCell;
    self.text.text=cell.amountValue;
    //self.totalPay.hidden = NO;
    self.popView.hidden = NO;
    //NSString* ss=[NSString countNumAndChangeformat:str];
    //self.totalPay.text = [NSString stringWithFormat:@"总计支付%@元",ss];
    
        CGFloat yu=([cell.amountValue floatValue]*self.minInterest)/[self.minInvestAmount floatValue];
        
        self.popLabel.text = [NSString stringWithFormat:@"预计收益%.2lf",yu];
    }else{
        self.text.text=@"";
        self.popView.hidden = YES;
    }
    
    
}
#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tyjData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"TiyanjinCell";
    TiyanjinCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TiyanjinCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.delegate = self;
    cell.modell = tyjData[indexPath.row];
    return cell;
}
#pragma mark - 其他
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

- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setFontColorLabel:(UILabel *)label :(int)a :(int)b {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    NSRange r =  NSMakeRange(a, b);
    [att addAttributes:@{NSForegroundColorAttributeName:RGB_red,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(a, b)];
    //    [att addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:RGB_red} range:NSMakeRange(a, b)];
    label.attributedText = att;
}
 
-(void)timeCount
{
    [self.surebtn setTitle:[self getTime] forState:UIControlStateNormal];
    [self.surebtn setTitle:[self getTime] forState:UIControlStateDisabled];
}
-(NSString*)getTime
{
    NSString *ss;
    NSDateFormatter* ole=[[NSDateFormatter alloc]init];
    [ole setDateStyle:NSDateFormatterMediumStyle];
    //[ole setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [ole setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dat=[ole dateFromString:overSecont];
    NSDate *today=[NSDate date];
    long long more=[dat timeIntervalSinceDate:today];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    //[format setDateStyle:NSDateFormatterMediumStyle];
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [format setDateFormat:@"HH:mm:ss"];
    NSDate *dt=[NSDate dateWithTimeIntervalSince1970:more];
    ss=[format stringFromDate:dt];
    if (more>0) {
        
        return [NSString stringWithFormat:@"即将开始(%@)",ss];
    }else{
        [timer invalidate];
        timer=nil;
        self.surebtn.enabled=YES;
        [self.surebtn setBackgroundColor:[UIColor redColor]];
        return @"立即抢购";
    }
}
@end
