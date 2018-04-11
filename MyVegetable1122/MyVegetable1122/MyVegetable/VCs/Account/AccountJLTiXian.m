//
//  AccountHQShuhui.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJLTiXian.h"
#import "AccountVC.h"
#import "MainTabbarController.h"
#import "Province.h"
#import "NameSure.h"
@interface AccountJLTiXian ()<UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource,HZMAPIManagerDelegate>
{
    //键盘弹出标识
    BOOL _isUpOn;
    //是第几个pickerview 1？2
    NSInteger _iswitch;
    
    //选中哪个省份ID
    NSString *IDF;
    //选中哪个城市ID
    NSString *IDcity;
    
    //卡兵查询结果
    NSString *cardID_;
    NSString *cardName_;
    NSDictionary* myCardInfo;
    
    BOOL isTrue,isPassword;
    
}
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property (weak, nonatomic) IBOutlet UITextField *card;
@property (weak, nonatomic) IBOutlet UITextField *kaihu;
@property (weak, nonatomic) IBOutlet UITextField *shengfen;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *zhihang;
@property (strong, nonatomic) IBOutlet UIView *provView;
@property (strong, nonatomic) IBOutlet UIView *cityView;
@property (strong, nonatomic) IBOutlet UIView *barchView;
@property (strong, nonatomic) IBOutlet UIView *moneyView;
//金额
@property (weak, nonatomic) IBOutlet UITextField *textfield;
//从上到下
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
//tag依次是13 14
- (IBAction)clickedXL:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

//@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextClicked;



//picekerview
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong , nonatomic) NSMutableArray *provinceList;
@property (strong , nonatomic) NSMutableArray *cityList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellH;

@end

@implementation AccountJLTiXian

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    _provinceList = [NSMutableArray array];
    _cityList = [NSMutableArray array];
    //返回按钮
//    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    leftItem.title = @"";
//    self.navigationItem.backBarButtonItem = leftItem;
   
    self.topLabel.text = [NSString stringWithFormat:@"      可提现金额(元):%ld",self.totalNum];
//    self.topLabel
    if (self.isfrom == 99) {//我的奖励，红包提现
        self.view.frame = CGRectMake(0, 0, JSCREEN_W, JSCREEN_H);
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
        self.navigationController.navigationBarHidden = NO;
    }

    
    self.nextBtn.layer.cornerRadius = self.nextBtn.bounds.size.height/2;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn setBackgroundColor:RGB_red];
    self.nextBtn.titleLabel.font = JFont(fontBtn);
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _pickerView.backgroundColor = RGB(249, 249, 249, 1);
    IDF = nil;
//    UIImage *stretchableButtonImage = [buttonImage  stretchableImageWithLeftCapWidth:12  topCapHeight:0];
//    [self.detail  setImage:buttonImage  forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //提现接口
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary* dict=@{@"userId":@([a.userId intValue])};
    
    [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset=[[HZMRequest alloc]init];
    requset.requsetId=AccountTiXian_Jump;
    requset.requestParamDic=dict;
    requset.callBackDelegate=self;
    requset.tag=0x301;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pickerView.hidden = YES;
    
    if (iPhone6P) {
        _cellH.constant = 65;
    } else if (iPhone6 ) {
        _cellH.constant = 60;
    }else if (iPhone5) {
        _cellH.constant = 50;
    }
    
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
- (void)back {
    
    MainTabbarController * t = [[MainTabbarController alloc] init];
    t.isfrom = 3;
    self.view.window.rootViewController = t;
}
#pragma mark - 卡柄查询
- (void)getCard{
    //    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString SubWhiteSpaceString:_card.text],@"cardNum",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounBDcard_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}



#pragma mark 提现
- (void)getChoose{
//    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              _card.text,@"cardNum",
                              cardID_,@"prcptcd",
                              IDF,@"provinceCode",
                              IDcity,@"cityCode",
                              _zhihang.text,@"braBankName",
                              _textfield.text,@"amount",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounHongBaoTiXian_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
#pragma mark 提现
- (void)getProvince:(NSString *)ID {
    
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              ID,@"parentId",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = ShengshiProvinceCity_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    //卡兵查询
    if ([response.requestId isEqualToString: AccounBDcard_NetWoring]) {//省市
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            cardID_ = [[response.responseData objectForKey:@"data"] objectForKey:@"bankCode"];
            cardName_ = [[response.responseData objectForKey:@"data"] objectForKey:@"bankName"];
            _kaihu.text = cardName_;
            _kaihu.enabled = NO;
        }}
    
    
    
    if ([response.requestId isEqualToString: ShengshiProvinceCity_NetWoring]) {//省市
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            
            if (_iswitch == 1) {
                [_provinceList removeAllObjects];
                NSArray *arr = [response.responseData objectForKey:@"data"];
                for (NSDictionary *dic in arr) {
                    Province *p = [[Province alloc] initWithDic:dic];
                    [_provinceList addObject:p];
                }[self.pickerView reloadAllComponents];
            }
            if (_iswitch == 2) {
                NSArray *arr = [response.responseData objectForKey:@"data"];
                [_cityList removeAllObjects];
                for (NSDictionary *dic in arr) {
                    Province *p = [[Province alloc] initWithDic:dic];
                    [_cityList addObject:p];
                }[self.pickerView reloadAllComponents];
            }
            
        }
    }
    if ([response.requestId isEqualToString:AccountTiXian_Jump]) {
        NSDictionary* data=[response.responseData objectForKey:@"data"];
        NSArray* cardList=[data objectForKey:@"cardList"];
        myCardInfo =[cardList firstObject];
        if (myCardInfo) {
            self.totalNum=[[data objectForKey:@"amount"] integerValue];
            self.topLabel.text=[NSString stringWithFormat:@"      可提现金额(元):%ld",self.totalNum];
            //NSLog(@"%@",myCardInfo);
            self.card.text=[myCardInfo objectForKey:@"cardNo"];
            self.kaihu.text=[myCardInfo objectForKey:@"bankName"];
            if ([myCardInfo objectForKey:@"prcptcd"]) {
                //[self.moneyView setTranslatesAutoresizingMaskIntoConstraints:YES];
                CGRect f=self.provView.frame;
                CGAffineTransform transform =CGAffineTransformMakeTranslation(0, 207-self.moneyView.frame.origin.y);
                [self.moneyView setTransform:transform]; //setTransform:transform];
                self.provView.hidden=YES;
                self.cityView.hidden=YES;
                self.barchView.hidden=YES;
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
        }
        
    }
    if ([response.requestId isEqualToString:Check_Info]) {//获得是否实名认证
        if(response.tag==0x9001)
        {
            int result=[[response.responseData objectForKey:@"code"] intValue];
            if (result==1) {
                isTrue=YES;
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
            requset1.tag=0x9001;
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
#pragma mark - 交互
#pragma mark 下一步
- (IBAction)nextClicked{
    if (![Tool boolForKey:JIsNamesure]) {
//        [self.view makeToast:@"请先进行实名认证！" duration:JDuration position:@"center"];
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
    if (![NSString textfieldHaveText:_card]) {
        [self.view makeToast:@"请输入银行卡号"];
        return;
    }
    if (cardName_.length==0|cardID_.length==0) {
        
        [self getCard];
        return;
    }
    if ([NSString textfieldHaveText:_shengfen]) {
        [self.view makeToast:@"请选择省份"];
        return;
    }
    if ([NSString textfieldHaveText:_city]) {
        [self.view makeToast:@"请选择城市"];
        return;
    }if ([NSString textfieldHaveText:_zhihang]) {
        [self.view makeToast:@"请输入开户支行"];
        return;
    }
    if (![NSString textfieldHaveText:_textfield]) {
        [self.view makeToast:@"请输入金额"];
        return;
    }
    
    [self getChoose];
//    ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"您已成功提现 元，赎回的钱将转移到您的账户余额。" leftButtonTitle:@"取消" rightButtonTitle:@"查看"];
////    [self.view addSubview:alert];
//   
//    __weak ZendaiAlertView *alertt = alert;
//    __weak AccountJLTiXian *sel = self;
//    alert.leftBlock  =^(){
//        [alertt removeFromSuperviewi];
//    };
//    alert.rightBlock = ^(){
//        MainTabbarController * t = [[MainTabbarController alloc] init];
//        t.isfrom = 3;
//        sel.view.window.rootViewController = t;
//        //查看的方式二
////        [self presentViewController:t  animated:YES completion:nil];
//        [alertt removeFromSuperviewi];
//        
//    };
//     [alert show];
    
}
#pragma mark 点击下拉
- (IBAction)clickedXL:(UIButton *)sender{

    if (sender.tag == 13) {
        sender = _btn3;
    }else if (sender.tag == 14){
        sender = _btn4;
    }
    if (sender.isSelected == YES) {
        sender.selected = NO;
        [self hiddenPickerView];
        sender.transform = CGAffineTransformMakeRotation(0);
        _iswitch = 0;
        return;
    }else{
        if(sender.tag ==14){
            if (_shengfen.text.length<1) {
                [self.view makeToast:@"请先选择省份"];
                return;
            }}
        sender.selected = YES;
        [self showPickerView];
        sender.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
    
    
    if (sender.tag==13) {
        if (_btn4.selected == YES) {
            _btn4.transform = CGAffineTransformMakeRotation(0);
        }
//        sender.selected = !_btn3.selected;
        if (sender.selected) {
            [self getProvince:@"1"];
            _iswitch = 1;
        }else{
            
        }
    }else if(sender.tag ==14){
        if (_btn3.selected == YES) {
            _btn3.transform = CGAffineTransformMakeRotation(0);
        }
        if (sender.selected) {
            [self getProvince:IDF];
            _iswitch = 2;
        }
    }
    

   
}

#pragma mark - pickerview
#pragma mark 展示pickerView
- (void)showPickerView {
    [self.view endEditing:YES];
    self.pickerView.hidden = NO;
    self.pickerView.showsSelectionIndicator = YES;
    
}
#pragma mark 隐藏pickerView
- (void)hiddenPickerView {
    [self.view endEditing:YES];
    self.pickerView.hidden = YES;
    
}
#pragma mark pickerview delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (_iswitch == 1) {//省份
        return [self.provinceList count];
    }else if(_iswitch == 2){//城市
        return self.cityList.count;
    }
    return 10;
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_iswitch == 1) {//省份
        Province *p = _provinceList[row];
        return p.name;
    }else if(_iswitch == 2){//城市
        Province *p = _cityList[row];
        return p.name;
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_iswitch == 1) {//省份
        Province *p = _provinceList[row];
        _shengfen.text = p.name;
        IDF = p.ID;
    }else if(_iswitch == 2){//城市
        Province *p = _cityList[row];
        _city.text = p.name;
        IDcity = p.ID;
    }
//    return nil;
}


#pragma mark - 键盘处理
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    if (!_isUpOn) {
        return;
    }
    CGFloat duartion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardFrame.origin.y;
    CGFloat transfromY ;
    if (y <=768) {
        if (500 > y) {
            transfromY =  -200;
        }else if(500 <= y && y<768){
            transfromY =  0;
        }
        [UIView animateWithDuration:duartion animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, transfromY);
        }];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_iswitch) {
        if (_iswitch == 1) {
            //            _btn3.selected = YES;
            [self clickedXL:_btn3];
        }else if(_iswitch == 2){
            //            _btn4.selected = YES;
            [self clickedXL:_btn4];
        }
    }
    if (textField == _zhihang|textField == _textfield) {
        _isUpOn = YES;
    } else {
        _isUpOn = NO;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _zhihang|textField == _textfield) {
        _isUpOn = YES;
    } else {
        _isUpOn = NO;
    }
    
    if (textField == _card) {
        [self getCard];
    }
}
//退回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    if (_iswitch) {
        if (_iswitch == 1) {
//            _btn3.selected = YES;
            [self clickedXL:_btn3];
        }else if(_iswitch == 2){
//            _btn4.selected = YES;
            [self clickedXL:_btn4];
        }
    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    实现银行卡的分割效果。
    NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    static int jij = 0,jj = 0;
    static BOOL cont = NO;
    
    if (str.length/5>=1) {
        jj=(int)str.length/5;
    }
    if (string.length>=1) {//输入
        if ((str.length-jj)%4==0) {
            textField.text = [str stringByAppendingString:@" "];
            jj=0;
            if (string.length==0) {
                return YES;
            }
            return NO;
        }
    }else {
        if ((str.length)%5==0) {
            if (!str.length) {
                return YES;
            }
            textField.text = [str substringToIndex:str.length-2];
            jj=0;
            return NO;
        }
        else if ((str.length+1)%5==0){
            textField.text = [str substringToIndex:str.length-1];
            return NO;
        }
    }
    return YES;
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
