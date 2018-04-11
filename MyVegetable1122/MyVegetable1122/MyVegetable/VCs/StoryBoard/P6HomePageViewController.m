//
//  P6HomePageViewController.m
//  MyVegetable
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yunhoo. All rights reserved.
//

#import "P6HomePageViewController.h"

@interface P6HomePageViewController ()

@end

@implementation P6HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    [self configUI];
    //    [self configDropView];
    //self.dropview.frame = CGRectMake(0, 0, JSCREEN_W, 140);
    
    
    
    //self.midView.constant = self.midView.constant*ratioH;
    //self.threeBtnViewH.constant = self.threeBtnViewH.constant*ratioH;
    //    self.kegouH.constant = self.kegouH.constant*ratioH;
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
    _productData = [NSMutableArray array];
    _JArr = [NSMutableArray array];
    if (![Tool objectForKey:@"first"]) {
        FirstUserView *view=[[FirstUserView alloc]initWithNib];
        [view show];
        [Tool setObject:@"first" forKey:@"first"];
    }
    
    if (![[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"] &&[Tool objectForKey:@"first"]){
      
        [self.view makeToast:@"用户未登录，请到“帐户”处登录！" duration:1.5];
    }
    
    [self.totalScroll setContentSize:self.view.frame.size];
    self.totalScroll.header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getProduct];
        //[tableView reloadData];
        [self.totalScroll.header endRefreshing];
        
        
    }];
    process=0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 起始
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    iphone4SFlag=NO;
    UIImageView* imgArrow=_hongbaoBtn.imageView;
    [_hongbaoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgArrow.size.width, 0, imgArrow.size.width)];
    [_hongbaoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _hongbaoBtn.titleLabel.bounds.size.width, 0, -_hongbaoBtn.titleLabel.bounds.size.width)];
    [self getImg];
    [self getProduct];
    [self configUI];
    //    [self configDropView];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self.progressView  removeFromSuperview];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 页面配置
-(void)configUI
{
    [self.hongbaoBtn setTitleColor:RGB_red forState:UIControlStateNormal];
    [self.zhuanpanBtn setTitleColor:RGB_red forState:UIControlStateNormal];
    
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    NSMutableArray *marr = [NSMutableArray array];
    //    for (int i=0; i<4; i++) {
    //        ImgModel *model = [[ImgModel alloc]init];
    //        model.iconID = [NSString stringWithFormat:@"%d",i];
    //        model.iconName = @"homePage_ad1";
    ////        model.iconUrl
    //        [marr addObject:model];
    //    }
    //    for (UIView* v in self.scrollview.subviews) {
    //        [v removeFromSuperview];
    //    }
    
    CGRect jcFram=CGRectMake(0, 0, JSCREEN_W, 140);
   
        self.BtnH.constant = highti6_40;
        self.lijiqianggou.layer.cornerRadius = highti6_40/2;
        self.scrollviewH.constant = 150;
    [self.lijiqianggou.layer setMasksToBounds:YES];
    
   
    _j.sdelegate = self;
    if (_j==nil) {
        _j=[[JCycleScrollView alloc]initWithFrame:jcFram duration:2 slideImages:_JArr];
        
        [self.scrollview addSubview:_j];
    }
    
    //    界面的UI
    //    颜色
    self.dropview.backgroundColor = RGB_gray;
   // self.upView.backgroundColor = RGB_gray;
    self.threeBtnView.backgroundColor = RGB_gray;
    
    
    self.lijiqianggou.layer.masksToBounds = YES;
    [self.lijiqianggou setBackgroundColor:RGB_red];
    self.lijiqianggou.titleLabel.font = JFont(fontBtn);
    [self.lijiqianggou setTitleColor:[UIColor whiteColor]];
}
- (UIButton *)createButtonWithTitle:(NSString *)title backImgName:(NSString *)imgName frame:(CGRect)frame titleColor:(UIColor *)color{
    UIButton *Btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitleColor:color forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    Btn.frame = frame;
    return Btn;
}
#pragma mark - 网络
#pragma mark 获取轮播图片
- (void)getImg {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"2",@"type",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HomePageTopImg_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
#pragma mark 获取产品信息
#warning 请求数据待确认
- (void)getProduct {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"1",@"type",
                              @"",@"cycle",
                              @"3",@"cycleType",nil];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HomePageCPGYdetail_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
-(void)getInvestCode
{
    WDCAccount* a=[WDCUserManage getLastUserInfo] ;
    NSDictionary* dt=@{@"type":@"1",@"userId":a.userId};
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HomePageYQM_NetWoring;
    request.requestParamDic = dt;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:HomePageTopImg_NetWoring]) {//首页图片
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *dictt = [response.responseData objectForKey:@"data"];
            NSArray *arr = [dictt objectForKey:@"fileList"];
            if (_JArr.count>0) {
                [_JArr removeAllObjects];
            }
            for (NSDictionary *d in arr) {
                ImgModel *model = [[ImgModel alloc] init];
//                model.iconUrl =  [ResourUrl stringByAppendingPathComponent:[d objectForKey:@"filePath"]];
                model.iconUrl = [d objectForKey:@"filePath"];
                model.iconID =   [d objectForKey:@"id"];
                model.myUrl=[d objectForKey:@"url"];
                [_JArr addObject:model];
            }
            
            [_j reloadImg:_JArr];
        }
    }else if ([response.requestId isEqualToString:HomePageCPGYdetail_NetWoring]) {//首页的产品
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            [self.productData removeAllObjects];
            NSArray *arr = [response.responseData objectForKey:@"data"];
            NSDictionary *dic = [arr objectAtIndex:0];
            process=[[dic objectForKey:@"progress"] floatValue];
            BuyModel *m =[[BuyModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            [self.productData addObject:m];
            [self configDropView];
            
            [self donghua];
            NSInteger bStatus=m.buttonStatus;
            if (bStatus==1) {
                [self.lijiqianggou setTitle:@"即将开启" forState:UIControlStateNormal];
                self.lijiqianggou.enabled=YES;
                [self.lijiqianggou setBackgroundColor:[UIColor lightGrayColor]];
                
            }else if(bStatus==2){
                [self.lijiqianggou setTitle:@"立即抢购" forState:UIControlStateNormal];
                self.lijiqianggou.enabled=YES;
            }else if(bStatus==3){
                [self.lijiqianggou setTitle:@"敬请期待" forState:UIControlStateDisabled];
                [self.lijiqianggou setTitle:@"敬请期待" forState:UIControlStateNormal];
                self.lijiqianggou.enabled=NO;
                [self.lijiqianggou setBackgroundColor:[UIColor lightGrayColor]];
            }
            if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
                [self getInvestCode];
            }
            //倒计时
            //            int bStatus=[[dic objectForKey:@"buttonStatus"] intValue];
            //            if (bStatus==1) {
            //                overSecont=[[dic objectForKey:@"timeLine"] longLongValue];
            //                [self.lijiqianggou setTitle:[self getTime] forState:UIControlStateNormal];
            //                timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
            //            }else if(bStatus==2){
            //                [self.lijiqianggou setTitle:@"立即抢购" forState:UIControlStateNormal];
            //            }else if(bStatus==3){
            //                [self.lijiqianggou setTitle:@"敬请期待" forState:UIControlStateDisabled];
            //                [self.lijiqianggou setTitle:@"敬请期待" forState:UIControlStateNormal];
            //                self.lijiqianggou.enabled=NO;
            //            }
        }
    }
    if ([response.requestId isEqualToString:HomePageYQM_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary* data=[response.responseData objectForKey:@"data"];
            myCode=[data objectForKey:@"code"];
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
    if ([response.requestId isEqualToString:HomePageCPGYdetail_NetWoring])
    {
        [self.productData addObject:[[BuyModel alloc]init]];
        [self configDropView];
        
        [self donghua];
        [self.lijiqianggou setBackgroundColor:[UIColor lightGrayColor]];
        self.lijiqianggou.enabled=NO;
        [self.lijiqianggou setTitle:@"敬请期待" forState:UIControlStateNormal];
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
#pragma mark - 创建中间的水球
- (void)configDropView {
    //    self.dropview. 140*radio
    for (UIView *v in self.dropview.subviews) {
        [v removeFromSuperview];
    }
    BuyModel *modell ;
    
    if (self.productData.count) {
        modell = [self.productData objectAtIndex:0];
    }
    
    CGFloat w = JSCREEN_W;
    CGFloat h=140 ;
    CGFloat l = 35*ratioH;
    if (iPhone4s) {
        self.dropViewH.constant = 100;
        h = 100;
    }
    if (iPhone6) {
        self.dropViewH.constant = 140*1.3;
        h = 140*1.3;
    } else if(iPhone6P) {
        self.dropViewH.constant = 140*1.3;
        h = 140*1.3;
    }else if(iPhone5){
        h = 140;
    }
    
    CGFloat wH=self.dropview.frame.size.height;
    self.view.userInteractionEnabled=YES;
    _circleChart = [[CCProgressView alloc] initWithFrame:CGRectMake((w-h)/2, (wH-h)/2-15,  h, h)];
    _circleChart.userInteractionEnabled = YES;
    _circleChart.backgroundColor = [UIColor clearColor];
    //_circleChart.center=CGPointMake(w/2, wH/2);
    
    [self.dropview addSubview:_circleChart];
    
    r=_circleChart.frame.size.height;
    
    //活期
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w/2-50, wH/2-10-l-10, 100.0, 20.0)];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [self.dropview addSubview:lab];
    lab.text = modell.title;
    lab.font = JFont13;
    
    //按钮
    UIButton *btn =nil;
    self.dropview.userInteractionEnabled = YES;
  
        btn =  [self createButtonWithTitle:@"查看详情>" backImgName:@"" frame:CGRectMake(w/2-50, wH/2+l-15, 100.0, 20) titleColor:[UIColor blackColor]];
    
    btn.enabled =YES;
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(clickedBtnDetail) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setTextAlignment:1];
    [btn.titleLabel setFont:JFont11];
    [btn setTitleColor:[UIColor whiteColor]];
    [self.dropview addSubview:btn];
    [self.view bringSubviewToFront:btn];
    
    
    
    //利率
    _titleLabel=[[UICountingLabel alloc]initWithFrame:CGRectMake(w/2-90, wH/2-25, 180.0, 30)];
    CGRect f=_titleLabel.frame;
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    _titleLabel.method = UILabelCountingMethodEaseInOut;
    [self.dropview addSubview:_titleLabel];
    NSString *min = [NSString stringWithFormat:@"%.2lf",modell.minRate];
    min = [min stringByAppendingString:@"%"];
    NSString *max = [NSString stringWithFormat:@"%.2lf",modell.maxRate];
    max = [max stringByAppendingString:@"%"];
    _titleLabel.text=[NSString stringWithFormat:@"%@~%@",min,max];
    _titleLabel.textColor = RGB(229, 60, 59, 1);
    
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        int a = (int)_titleLabel.text.length;
        a--;
        NSRange r1 = [min rangeOfString:@"."];
        NSString *rs1 = [min substringToIndex:r1.location];
        NSRange r2 = [max rangeOfString:@"."];
        NSString *rs2 = [max substringToIndex:r2.location];
        [self setFontColorLabel:_titleLabel :0 :rs1.length];
        [self setFontColorLabel:_titleLabel :a-max.length+1 :rs2.length];
    
#warning 数据需要重设文字大小
    
    [_circleChart setProgress:0.35 animated:YES];
    [self startGravity];
    currentTransform=_circleChart.transform;
    
    //可购份额
    NSString *ss = [NSString stringWithFormat:@"%f",modell.amount];
    ss = [NSString countNumAndChangeformat:ss];
    _kegoufene.text = [NSString stringWithFormat:@"可购份额:%@",ss];
    
}

#pragma mark 动画
- (void)donghua {
    //    外侧的进度条
    self.progressView = [[PICircularProgressView alloc]init];
    self.progressView.userInteractionEnabled = YES;
    CGFloat wH=self.dropview.frame.size.height;
    CGFloat w = JSCREEN_W;
    CGFloat h ;
    if (iPhone6) {
        h = 140*1.3;
    } else if(iPhone6P) {
        h = 140*1.3;
    }else if(iPhone4s){
        h=100;
    }else
    {
        h = 140;
    }
    
    
    self.progressView.frame = CGRectMake(w/2-h/2, ((wH-h)/2)-15,  h, h);
    //self.progressView.center=CGPointMake(w/2, wH/2);
    [self.dropview addSubview:self.progressView];
    _x = 0;
    //   进度条
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(z) userInfo:nil repeats:YES];
    //    粗细
    self.progressView.thicknessRatio = 0.12;//Jradius;
    self.progressView.showText = 0;
    //    颜色
    self.progressView.progressTopGradientColor = [UIColor colorWithRed:233.0/255.0 green:63.0/255.0 blue:74/255.0 alpha:1.0];
    self.progressView.progressBottomGradientColor = RGB(253, 200, 183, 1);
    self.progressView.roundedHead = YES;
    
    
    for (UIView * v  in self.dropview.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            [self.dropview bringSubviewToFront:v];
        }
    }
}
- (void)z {
    if (_x>=process) {
        return;
    }
    _x +=0.02;
    self.progressView.progress = _x;
}
- (BOOL)isGravityActive {
    return self.motionDisplayLink != nil;
}
- (void)startGravity {
    if ( ! [self isGravityActive]) {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval =0.1;// 0.02; // 50 Hz
        self.motionLastYaw = 0;
        _theTimer= [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(motionRefresh:) userInfo:nil repeats:YES];
    }
    if ([self.motionManager isDeviceMotionAvailable]) {
        
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical];
    }
}
- (void)motionRefresh:(id)sender {
    CMQuaternion quat = self.motionManager.deviceMotion.attitude.quaternion;
    double yaw = asin(2*(quat.x*quat.z - quat.w*quat.y));
    
    yaw *= -1;
    
    if (self.motionLastYaw == 0) {
        self.motionLastYaw = yaw;
    }
    
    // kalman filtering
    static float q = 0.1;   // process noise
    static float s = 0.1;   // sensor noise
    static float p = 0.1;   // estimated error
    static float k = 0.5;   // kalman filter gain
    
    float x = self.motionLastYaw;
    p = p + q;
    k = p / (p + s);
    x = x + k*(yaw - x);
    p = (1 - k)*p;
    
    
    newTransform=CGAffineTransformRotate(currentTransform,-x);
    _circleChart.transform=newTransform;
    // }
    //[self stopGravity];
    self.motionLastYaw = x;
}

- (void)stopGravity
{
    if ([self isGravityActive]) {
        [self.motionDisplayLink invalidate];
        self.motionDisplayLink = nil;
        self.motionLastYaw = 0;
        [_theTimer invalidate];
        _theTimer=nil;
        
        self.motionManager = nil;   // release the motion manager memory
    }
    if ([self.motionManager isDeviceMotionActive])
        [self.motionManager stopDeviceMotionUpdates];
}

#pragma mark - 其他
-(void)setFontColorLabel:(UILabel *)label :(int)a :(int)b {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    NSRange r =  NSMakeRange(a, b);
    [att addAttributes:@{NSForegroundColorAttributeName:RGB_red,NSFontAttributeName:[UIFont systemFontOfSize:25]} range:NSMakeRange(a, b)];
    //    [att addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:RGB_red} range:NSMakeRange(a, b)];
    label.attributedText = att;
}
#pragma mark - 交互
#pragma mark  立即抢购
- (IBAction)jiliqianggou {
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
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
        BuyOne *b = [[BuyOne alloc]  init];
        b.data = self.productData;
        b.isfrom=22;
        b.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:b animated:YES];
        
    }else{
        LoginVC *l = [[LoginVC alloc] init];
        l.hidesBottomBarWhenPushed = YES;
        l.isFrom = 88;
        [self.navigationController pushViewController:l animated:YES];
    }
}
#pragma mark  红包
- (IBAction)hongbaoClicked {
    if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
       
        WebHtml5ViewController* l=[UIViewControllerFactory getViewController:HTML5_WebView];
        WDCAccount *a1 = [WDCUserManage getLastUserInfo];
        l.url=[NSString stringWithFormat:@"%@/wx/pages/appInvite.html?type=2&uid=%@",SERVICE_URL,a1.userId];
        l.messTitle=@"邀好友拿现金";
        if (myCode) {
            l.myCode=myCode;
        }
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
        
    }else{
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}
#pragma mark  转盘
- (IBAction)zhuanpanClicked {
    
    if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
        WebHtml5ViewController* l=[UIViewControllerFactory getViewController:HTML5_WebView];
        
        l.hidesBottomBarWhenPushed = YES;
        l.messTitle=@"理财赢好礼";
        WDCAccount *a1 = [WDCUserManage getLastUserInfo];
        l.url=[NSString stringWithFormat:@"%@/wx/pages/appDial.html?type=2&uid=%@",SERVICE_URL,a1.userId];
        [self.navigationController pushViewController:l animated:YES];
    }else
    {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}
#pragma mark  点击查看详情
- (void)clickedBtnDetail{
    BuyModel *m = [_productData objectAtIndex:0];
    DetailVC *d = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    d.productId = [NSString stringWithFormat:@"%lld",m.productId];
    d.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: d animated:YES];//点击头部的滚动视图
}
- (void)didClickedScrollView:(UIGestureRecognizer *)img{
    UIImageView *imgg = [img view];
    UIImage *gg = imgg.image;
    
    HtmlHB* hb=[[HtmlHB alloc]init];
    for (ImgModel* m in _JArr) {
        if ([m.iconID integerValue]==imgg.tag) {
            hb.url=m.myUrl;
        }
    }
    
    hb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hb animated:YES];
    
    
}
#pragma mark - 倒计时
-(void)timeCount
{
    [self.lijiqianggou setTitle:[self getTime] forState:UIControlStateNormal];
    [self.lijiqianggou setTitle:[self getTime] forState:UIControlStateDisabled];
}
-(NSString*)getTime
{
    NSString *ss;
    NSDate *dat=[NSDate dateWithTimeIntervalSince1970:overSecont/1000];
    NSDate *today=[NSDate date];
    long long more=[today timeIntervalSinceDate:dat];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [format setDateFormat:@"HH:mm:ss"];
    NSDate *dt=[NSDate dateWithTimeIntervalSince1970:more];
    ss=[format stringFromDate:dt];
    if (more>0) {
        
        return [NSString stringWithFormat:@"即将开始(%@)",ss];
    }else{
        [timer invalidate];
        timer=nil;
        self.lijiqianggou.enabled=YES;
        return @"立即抢购";
    }
}
@end