
//
//  CardSure.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "CardSure.h"
#import "JiaoyiMM.h"
#import "SelectCityDialog.h"
#import "MBProgressHUD.h"
@interface CardSure ()<UITextFieldDelegate,HZMAPIManagerDelegate,SelectCityDelegate>
{
    NSDictionary* provDic,*cityDic;
    NSArray* proArray,*cityArray;
    CGRect defaultFram;
}
@property (weak, nonatomic) IBOutlet UIButton *sure;
- (IBAction)sureClicked;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *card;
@property (weak, nonatomic) IBOutlet UITextField *bank;
@property (weak, nonatomic) IBOutlet UIButton *bankBtn;
- (IBAction)clickedBankBtn;
@property (weak, nonatomic) IBOutlet UITextField *shengfeng;
@property (weak, nonatomic) IBOutlet UIButton *shengfengBtn;
- (IBAction)clickedShengfenBtn;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)clickedCityBtn;
@property (weak, nonatomic) IBOutlet UITextField *subBank;

@property (weak, nonatomic) IBOutlet UIView *viewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation CardSure

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"银行卡绑定";
    self.view.backgroundColor = RGB_gray;
    self.BtnH.constant = 35.0*ratioH;
    _sure.backgroundColor = RGB_red;
    _sure.layer.cornerRadius = 35.0/2*ratioH;
    _sure.layer.masksToBounds = YES;
    [_sure setTitle:@"确认" forState:UIControlStateNormal];
    _sure.titleLabel.font = JFont(fontBtn);
    [self configUI];
    
    self.btn1.constant = 50*ratioH;
    self.detail.font = JFont10;
    defaultFram=self.view.frame;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
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
    self.card.delegate=self;
    self.card.tag=0x1001;
    self.subBank.delegate=self;
    self.card.tag=0x1006;
    self.bank.enabled=NO;
    self.city.enabled=NO;
    self.nameLabel.delegate=self;
    self.subBank.delegate=self;
    
}

- (void)configUI {
    self.nameLabel.text = @"";
}
//银行
- (IBAction)clickedBankBtn {
    
}
//省份
- (IBAction)clickedShengfenBtn {
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary* dict=@{@"parentId":@(1)};
        
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=ShengshiProvinceCity_NetWoring;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x301;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
    
    
}
//城市
- (IBAction)clickedCityBtn {
    if (provDic) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSInteger proId=1;
        if (provDic) {
            proId=[[provDic objectForKey:@"id"] integerValue];
        }
        NSDictionary* dict=@{@"parentId":@(1)};
        
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=ShengshiProvinceCity_NetWoring;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x302;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
    }else{
        UIAlertView* altert=[[UIAlertView alloc]initWithTitle:@"未选择省份" message:@"请选择省份，然后选择城市" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [altert show];
    }
    
}
//确认
- (IBAction)sureClicked{
    JiaoyiMM *j = [[JiaoyiMM alloc] init];
    j.hidesBottomBarWhenPushed = YES;
    j.isform = 1;
    [self.navigationController pushViewController:j animated:YES];
    
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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==0x1006) {
        CGRect f=self.view.frame;
        f.origin.y=f.origin.y-100;
        self.view.frame=f;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame=defaultFram;
    if (textField.tag==0x1001) {
        if (textField.text.length>14) {
            //
            [[HZMAPImanager shareMAPImanager]addDelegate:self];
            HZMRequest* requset=[[HZMRequest alloc]init];
            requset.requsetId=AccounBDcard_NetWoring;
            WDCAccount *a = [WDCUserManage getLastUserInfo];
            NSDictionary* dict=@{@"cardNum":textField.text,@"userId":a.userId};
            requset.requestParamDic=dict;
            requset.callBackDelegate=self;
            requset.tag=0x201;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HZMAPIManagerDelegate
-(void)transactionFailed:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.requestId isEqualToString:AccounBDcard_NetWoring]) {
        if ([response.responseData objectForKey:@"data"]) {
            NSDictionary* data=[response.responseData objectForKey:@"data"];
            //NSDictionary* card=[data objectForKey:@"cardbin"];
            self.bank.text=[data objectForKey:@"bankName"];
        }
    }
    if ([response.requestId isEqualToString:ShengshiProvinceCity_NetWoring]) { //城市省份选择
        if (response.tag==0x301) {
            proArray=[response.responseData objectForKey:@"data"];
            NSMutableArray* str=[[NSMutableArray alloc]init];
            for (int i=0; i<proArray.count; i++ ) {
                [str addObject:[[proArray objectAtIndex:i] objectForKey:@"name"]];
            }
            SelectCityDialog* dialog=[[SelectCityDialog alloc]initWithNib];
            dialog.citys=str;
            dialog.selectDelegate=self;
            dialog.tag=0x1001;
            dialog.cityTitle.text=@"选择省份";
            [dialog show];
            
        }
        if (response.tag==0x302) {
            
            cityArray=[response.responseData objectForKey:@"data"];
            NSMutableArray* str=[[NSMutableArray alloc]init];
            for (int i=0; i<cityArray.count; i++ ) {
                [str addObject:[[cityArray objectAtIndex:i] objectForKey:@"name"]];
            }
            SelectCityDialog* dialog=[[SelectCityDialog alloc]initWithNib];
            dialog.citys=str;
            dialog.selectDelegate=self;
            dialog.tag=0x1002;
            dialog.cityTitle.text=@"选择城市";
            [dialog show];
        }
    }
    
}
-(void)transactionFinished:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)selectCityIndex:(id)selectCity atIndex:(NSInteger)index
{
    SelectCityDialog *city=selectCity;
    if (city.tag==0x1001) {
        provDic=[proArray objectAtIndex:index];
        self.shengfeng.text=[provDic objectForKey:@"name"];
    }
    if (city.tag==0x1002) {
        cityDic=[cityArray objectAtIndex:index];
        self.city.text=[cityDic objectForKey:@"name"];
    }
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
