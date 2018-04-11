//
//  MainSetting.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "MainSetting.h"
#import "helpCell.h"
#import "helpModel.h"
#import "NameSure.h"
#import "CardSure.h"
#import "LoginMima.h"
#import "LoseLoginOne.h"
#import "PasswordGestureViewController.h"
#import "HZMAPImanager.h"
#import "UIViewControllerFactory.h"
@interface MainSetting ()<UITableViewDataSource,UITableViewDelegate,HZMAPIManagerDelegate>
{
    UINib * nib;
}
@end

@implementation MainSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self configUI];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.data removeAllObjects];
    [self creatData];
    [self.tableView reloadData];
    
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
    if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
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
    
}
- (NSMutableArray *)creatData {
    [self.data removeAllObjects];
    NSMutableArray *a = [NSMutableArray array];
    NSMutableArray *b = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        helpModel *model = [[helpModel alloc]init];
        model.detailTitle = nil;
        
        switch (i) {
            case 0:{
                model.title = @"实名认证";
                if ([Tool boolForKey:JIsNamesure]) {
                    model.detailTitle = @"已认证";
                }else{
                    model.detailTitle = @"未认证";
                }
                
                break;
            }
//            case 1:{
//                model.title = @"银行卡绑定";
//                if ([Tool boolForKey:JIsTieCard]) {
//                    model.detailTitle = @"已绑定";
//                }else{
//                    model.detailTitle = @"未绑定";
//                }
//                break;
//            }
//            case 1:{
//                model.title = @"手势密码";
//                if ([Tool boolForKey:JIsSetSecretShoushi]) {
//                    model.detailTitle = @"修改";
//                }else{
//                    model.detailTitle = @"设置";
//                }
//                
//                break;
            case 1:{
                model.title = @"登录密码";
                if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
                    model.detailTitle = @"修改";
                }else{
                    model.detailTitle = @"设置";
                }
                
                model.detailTitle = @"修改";
                break;
            }case 2:{
                model.title = @"交易密码";
                model.detailTitle = @"修改";
                break;
            }
            default:
                break;
        }
        if (i>=1) {
            model.image = [NSString stringWithFormat:@"account_setting%d",i+2];
        } else {
            model.image = [NSString stringWithFormat:@"account_setting%d",i+1];
        }
        model.imageNext = @"next";
//        if (i<=1) {
            [a addObject:model];
//        }else{
//            [b addObject:model];
//        }
        
    }
    [self.data addObject:a];
//    [self.data addObject:b];
    return self.data;
}

#pragma mark - UI

- (void)configUI {
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone6) {
        _btn.frame = CGRectMake(20, (JSCREEN_H-64-44-35-120), JSCREEN_W-40, highti6_40);
        _btn.layer.cornerRadius = highti6_40/2.0;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JSCREEN_W, 410) style:UITableViewStylePlain];
    }else if (iPhone6P){
        _btn.frame = CGRectMake(20, (JSCREEN_H-64-44-35-120), JSCREEN_W-40, highti6_40);
        _btn.layer.cornerRadius = highti6_40/2.0;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JSCREEN_W, 420) style:UITableViewStylePlain];
    }else{
        _btn.frame = CGRectMake(20, (JSCREEN_H-64-44-35-120), JSCREEN_W-40, highti5_35);
        _btn.layer.cornerRadius = highti5_35/2.0;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JSCREEN_W, 240) style:UITableViewStylePlain];
    }
    
    self.view.backgroundColor = RGB_gray;
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:_tableView];
    [self.tableView  registerNib:[UINib nibWithNibName:@"helpCell" bundle:nil] forCellReuseIdentifier:@"helpCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle       = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate =self;
    
    
    _btn.backgroundColor = RGB_red;
    [_btn addTarget:self action:@selector(didClickedBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _btn.layer.masksToBounds = YES;
    [_btn setTitle:@"退出登录" forState:UIControlStateNormal];
    _btn.titleLabel.font = JFont(fontBtn);
    [self.view addSubview:_btn];
    
    
    
    self.data = [NSMutableArray arrayWithCapacity:0];
    self.data = [NSMutableArray array];
    [self creatData];
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] init];
    leftItem.title = @"";
    self.navigationItem.backBarButtonItem =leftItem;
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.data[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    helpModel *model = self.data[indexPath.section][indexPath.row];
    static NSString *AccountMianCellID = @"helpCell";
    
    if (nib == nil) {
        
        nib = [UINib nibWithNibName:@"helpCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:AccountMianCellID];
    }
    helpCell * cell = [tableView dequeueReusableCellWithIdentifier:AccountMianCellID];
    
    
    
    cell.helpmodel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =[UIColor whiteColor];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    }else {
        return 15.0f;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (iPhone6) {
        return highti6_cell;
    }else if (iPhone6P){
        return highti6P_cell;
    }else{
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{//实名未认证
                if ([Tool boolForKey:JIsNamesure]) {
                    [self.view makeToast:@"您已经通过实名认证，无需再次认证！"];
                }else{
                NameSure *n = [[NameSure alloc] init];
                n.isform = 1;
                n.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:n  animated:YES];
                }
                break;
            }
//            case 1:{//银行卡绑定
//#warning 先确认是否实名认证。
////                if ([Tool objectForKey:JIsNamesure]) {//尚未实名认证
////                    [self.view makeToast:@"您尚未实名认证，请先实名认证" duration:JDuration position:@"center"];
////                }
//                
//                CardSure *c = [[CardSure alloc]init];
//                c.hidesBottomBarWhenPushed =YES;
//                [self.navigationController pushViewController:c animated:YES];
//                break;
//            }
//            default:
//                break;
//        }
//    }else if (indexPath.section == 1){
//        switch (indexPath.row)
//        {
//            case 1:{//手势密码
//                SetUpTrPasswordViewController *stv=[UIViewControllerFactory getViewController:Trad_Password];
//                [self.navigationController pushViewController:stv animated:YES];
//
////                [self.navigationController pushViewController:l animated:YES];
//                break;
//            }
            case 1:{//登录密码
                LoginMima *l = [[LoginMima alloc]init];
                l.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:l animated:YES];
                break;
            }case 2:{//交易密码
                LoseLoginOne *l = [[LoseLoginOne alloc]init];
                l.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:l animated:YES];
                break;
            }
                
            default:
                break;
        }
    }
    
    
}
#pragma mark - 交互
//退出登录
- (void)didClickedBtn {
    //是否登录
    if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
        //清除手势信息
        [Tool clearStatus];
        [Tool setBool:NO forKey:JIsSetSecretShoushi];
        [Tool removeObjectForKey:SSFBDGesturePasswordKey];
        //清除登录信息
        [Tool removeObjectForKey:JIsLoginUser];
        //
        
        [self.view makeToast:@"您已退出登录"];
        LoginVC *ll = [[LoginVC alloc] init];
        ll.isFrom = 22;
        //UINavigationController *lll  = [[UINavigationController alloc]initWithRootViewController:ll];
        //[self presentViewController:lll animated:YES completion:nil];
        [self.navigationController pushViewController:ll animated:YES];
        
        
    }else{
        [self.view makeToast:@"您尚未登录"];
    }
    
    
}
- (void)PopNav {
    [self dismissViewControllerAnimated:YES completion:nil];
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
-(void)transactionFailed:(HZMResponse *)response
{
    
}
-(void)transactionFinished:(HZMResponse *)response
{
    if ([response.requestId isEqualToString:Check_Info]) {
        int result=[[response.responseData objectForKey:@"code"] intValue];
        if (result==1) {
            [Tool setBool:YES forKey:JIsNamesure];
           // [Tool setObject:[NSNumber numberWithBool:YES] forKey:JIsNamesure];
        }else{
            
            //[Tool setObject:[NSNumber numberWithBool:NO] forKey:JIsNamesure];
        }
        [self creatData];
        [self.tableView reloadData];
    }
}
@end
