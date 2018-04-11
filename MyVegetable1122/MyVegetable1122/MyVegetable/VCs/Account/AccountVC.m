//
//  AccountVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/11.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountVC.h"
#import "helpCell.h"
#import "AccountModel.h"
#import "MainSetting.h"
#import "AccountDQ.h"
#import "AccountMyHQ.h"
#import "AccountJL.h"
#import "AccountJY.h"
#import "ChongZhi.h"
#import "AccountJLTiXian.h"
#import "UIViewControllerFactory.h"
#import "PublicString.h"
#import "NameSure.h"
@interface AccountVC ()<UITableViewDataSource,UITableViewDelegate,HZMAPIManagerDelegate>
{
    UINib * nib;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2H;
@property (weak, nonatomic) IBOutlet UIButton *peopleicon;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIView *UpView;


@property (strong, nonatomic) IBOutlet UILabel *freezonCash;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *zaitou;
@property (weak, nonatomic) IBOutlet UILabel *keyong;
//昨日总收益
@property (weak, nonatomic) IBOutlet UILabel *totalInput;
//点击右上角btn
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelH;

@property (weak, nonatomic) IBOutlet UIButton *chongzhi;
@property (weak, nonatomic) IBOutlet UIButton *tixian;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewH;

- (IBAction)chongzhiClicked;
- (IBAction)tixianClicked;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2W;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;//5S10
@property (strong, nonatomic) NSMutableArray *data;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upviewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upmidLabelH;

@end

@implementation AccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户";
    [self configUI];
    self.peopleicon.layer.cornerRadius=22;
    [self.peopleicon.layer setMasksToBounds:YES];
 /*
    if (iPhone6) {
        _bottomH.constant = 30;
        self.tableViewH.constant = highti6_cell*4.2;
        self.btn2H.constant = highti6_40;
        self.btn2W.constant = 160;
    }else if (iPhone6P){
        _bottomH.constant = 30;
        self.tableViewH.constant = highti6P_cell*4.2;
        self.btn2H.constant = highti6_40;
        self.btn2W.constant = 180;
    }else{
        _bottomH.constant = 20;
        self.tableViewH.constant = highti5_cell*4.2;
        self.btn2H.constant = 30;
        self.btn2W.constant = 140;
    }
    */
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getProduct];
    self.navigationController.navigationBarHidden=NO;
    /*
    if (iPhone6P) {
        _upviewH.constant = 220;
        _upmidLabelH.constant =60;
        _topLabelH.constant = 95;
    }else if (iPhone6) {
        _upviewH.constant = 210;
        _upmidLabelH.constant =60;
        _topLabelH.constant = 90;
    }else if (iPhone5) {
        _upviewH.constant = 180;
        _upmidLabelH.constant =50;
        _topLabelH.constant = 75;
    }else {
        
    }*/
}
#pragma - UI
- (void)configUI {
    __weak UITableView *tableView = self.tableView;
    //下拉率刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getProduct];
        [tableView reloadData];
        [tableView.header endRefreshing];
    }];
    
//    // 上啦刷新
//    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [self getProduct];
//        [tableView reloadData];
//        [tableView.footer endRefreshing];
//    }];
    
    
    self.view.backgroundColor = RGB_gray;
    self.UpView.backgroundColor = RGB_red;
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
    
//    self.chongzhi.backgroundColor = [UIColor clearColor];
    [self.chongzhi setBackgroundColor:RGB(234, 60, 52, 1)];
    self.chongzhi.layer.cornerRadius = 5.0;
    self.chongzhi.layer.masksToBounds = YES;
    self.chongzhi.titleLabel.font = JFont(fontBtn);
    
    [self.tixian setBackgroundColor:RGB(239,123, 58, 1)];
    self.tixian.layer.cornerRadius = 5.0;
    self.tixian.layer.masksToBounds = YES;
    self.tixian.titleLabel.font = JFont(fontBtn);
    
    //右侧按钮
    UIButton *rightBtn = [self createButtonWithTitle:@"" backImgName:@"account_bar_icon@2x" frame:CGRectMake(0, 0, 16*ratioW, 16*ratioW) titleColor:[UIColor clearColor]];
    [rightBtn addTarget:self action:@selector(jumpSet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
   self.navigationItem.backBarButtonItem = item;
    
 
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle       = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.data = [NSMutableArray arrayWithCapacity:0];
    [self creatData:@"0.00" :@"0.00"];
}



- (NSString *)string:(NSString*)str {
    NSString *string;
    NSString *s1 = [str substringToIndex:3];
    NSString *s2 = [str substringFromIndex:(str.length - 4)];
    string = [NSString stringWithFormat:@"%@****%@",s1,s2];
    return string;
}

- (NSMutableArray *)creatData :(NSString *)str1 :(NSString *)str2 {
    [self.data removeAllObjects];
    for (int i=0; i<4; i++) {
        AccountModel *model = [[AccountModel alloc]init];
        //model.detailTitle = @"";
        switch (i) {
            case 0:{
                model.title = @"活期产品";
                model.detailTitle = @"";
                break;
            }case 1:{
                model.title = @"定期产品";
                model.detailTitle = @"";
                break;
            }case 2:{
                model.title = @"交易记录";
                break;
            }case 3:{
                model.title = @"我的奖励";
                break;
            }
            default:
                break;
        }
        model.image = [NSString stringWithFormat:@"account_tableview%d",i+1];
        model.imageNext = @"next";
        [self.data addObject:model];
    }
    return self.data;
}
- (UIButton *)createButtonWithTitle:(NSString *)title backImgName:(NSString *)imgName frame:(CGRect)frame titleColor:(UIColor *)color{
    UIButton *Btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitleColor:color forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    Btn.frame = frame;
    return Btn;
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

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounTotal_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *dictt = [response.responseData objectForKey:@"data"];
#warning 头像数据？？？
            //[self.peopleicon setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
            self.phone.text = [self string:[dictt objectForKey:@"phoneNum"]];
            
            NSString *ss = [NSString stringWithFormat:@"%@",[dictt objectForKey:@"yesterdayIncome"]];
            ss = [NSString countNumAndChangeformat:ss];
            self.totalInput.text = ss;//[PublicString stringToMoney:ss];
            
            NSString *sst = [NSString stringWithFormat:@"%@",[dictt objectForKey:@"accountAmt"]];
            sst = [NSString countNumAndChangeformat:sst];
            self.keyong.text =sst;// [PublicString stringToMoney:sst];
            
            NSString *sse = [NSString stringWithFormat:@"%@",[dictt objectForKey:@"inUseAmt"]];
            sse = [NSString countNumAndChangeformat:sse];
            self.zaitou.text =sse;// [PublicString stringToMoney:sse];
            
            NSString *s1 =[NSString countNumAndChangeformat: [dictt objectForKey:@"currentIncome"]];
            NSString *s2 = [NSString countNumAndChangeformat:[dictt objectForKey:@"regularIncome"]];
            if ([dictt objectForKey:@"onLandAmt"]) {
                self.freezonCash.text=[NSString stringWithFormat:@"%@",[dictt objectForKey:@"onLandAmt"]];
            }
            
            
            
            [self creatData:s1 :s2];
            [self.tableView reloadData];
//            [self.peopleicon setTitle:[dictt objectForKey:@"accountAmt"] forState:UIControlStateNormal];
//            self.phone.text =
//            self.keyong.text = [NSString stringWithFormat:@"￥%@",[dictt objectForKey:@"accountAmt"]];
            
            
        }
        //校验实名认证
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset1=[[HZMRequest alloc]init];
        requset1.requsetId=Check_Info;
        WDCAccount *a1 = [WDCUserManage getLastUserInfo];
        NSDictionary* dict1=@{@"type":@(1),@"userId":a1.userId};
        requset1.requestParamDic=dict1;
        requset1.callBackDelegate=self;
        requset1.tag=0x9001;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
    }
    if ([response.requestId isEqualToString:Check_Info]) {
        int result=[[response.responseData objectForKey:@"code"] intValue];
        if (result==1) {
            
            [Tool setBool:YES forKey:JIsNamesure];
            //[Tool setObject:[NSNumber numberWithBool:YES] forKey:JIsNamesure];
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

#pragma mark - 交互
 
- (IBAction)chongzhiClicked{
    if (![Tool boolForKey:JIsNamesure]) {
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
    ChongZhi *c = [[ChongZhi alloc] init];
    c.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c  animated:YES];
}
- (IBAction)tixianClicked{
    //AccountJLTiXian *c = [[AccountJLTiXian alloc] init];
    if (![Tool boolForKey:JIsNamesure]) {
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
    AccountTiXianViewController* c=[UIViewControllerFactory getViewController:ACCOUNT_UI_TIXIAN];
    c.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c  animated:YES];
}
- (void)PopNav {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)jumpSet{
    MainSetting *s = [[MainSetting alloc]init];
    s.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:s animated:YES];
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountModel *model = self.data[indexPath.row];
    static NSString *AccountMianCellID = @"helpCell";
    
    if (nib == nil) {
        
        nib = [UINib nibWithNibName:@"helpCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:AccountMianCellID];
    }
    helpCell * cell = [tableView dequeueReusableCellWithIdentifier:AccountMianCellID];
    
    
    
    cell.accountmodel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =[UIColor whiteColor];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {//活期产品
        AccountMyHQ *m = [[AccountMyHQ alloc]init];
        m.hidesBottomBarWhenPushed = YES;
        m.del = self;
        [self.navigationController pushViewController:m animated:YES];
    }else if (indexPath.row == 1){//定期产品
        AccountDQ *m = [[AccountDQ alloc] init];
        m.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:m animated:YES];
    }else if (indexPath.row == 2){//交易记录
        AccountJY *m = [[AccountJY alloc]init];
        m.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:m animated:YES];
    }else if (indexPath.row == 3){//我的奖励
        AccountJL *m = [[AccountJL alloc]init];
//        UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:m];
         m.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:m animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if (iPhone6) {
        return highti6_cell;
    }else if (iPhone6P){
        return highti6P_cell;
    }else{*/
        return 44;
    //}
    
}
#pragma mark - 其他
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
