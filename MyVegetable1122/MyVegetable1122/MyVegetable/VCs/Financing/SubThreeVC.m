//
//  SubViewController.m
//  PageViewController
//
//  Created by 蒋孝才 on 15/8/6.
//  Copyright (c) 2015年 ShiShu. All rights reserved.
//


#import "SubThreeVC.h"
//#import "CCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DrowCircle.h"
//#import "IOPowerSources.h"
#import "DetailVC.h"
#import <CoreMotion/CoreMotion.h>
#import "UICountingLabel.h"
#import "PICircularProgressView.h"
#import "UIDevice+ProcessesAdditions.h"
#define EPSILON     1e-6
#define kDuration 1.0   // 动画持续时间(秒)
#import "BuyOne.h"
#import "NameSure.h"
//半径为 10；
@interface SubThreeVC ()<HZMAPIManagerDelegate>

{
    UILabel *_titleLabel1;
    UILabel *_titleLabel;
    BuyModel* currModel;
    
    float _x ;
}
@property (nonatomic, strong) NSMutableArray *productData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnW;


@property (nonatomic, strong) CMMotionManager* motionManager;
@property (nonatomic, strong) CADisplayLink* motionDisplayLink;

@property (nonatomic) float motionLastYaw;

@property (weak, nonatomic) IBOutlet UIButton *fuBtn;
- (IBAction)clickedFuBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *xixian;


//上方label
@property (weak, nonatomic) IBOutlet UILabel *uplabel;

@property (weak, nonatomic) IBOutlet UIView *dropview;
//指示图标
@property (weak, nonatomic) IBOutlet UIImageView *indBg;
@property (weak, nonatomic) IBOutlet UILabel *indLabe;

@property (weak, nonatomic) IBOutlet UIView *midView;
//3图标
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *labelone;
@property (weak, nonatomic) IBOutlet UIImageView *imgone;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgtwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgthree;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;

@property (weak, nonatomic) IBOutlet UIView *upBg;

//xiafang
@property (weak, nonatomic) IBOutlet UILabel *detaillabel;

@property (weak, nonatomic) IBOutlet UIButton *qiangouBtn;
- (IBAction)qianggouClicked;
@property (weak, nonatomic) IBOutlet UIView *HidMidView;


//popview 85-30-13
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popLabelH;
//140
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropViewH;
//顶部月期的label的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;



@end

@implementation SubThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uplabel.hidden = YES;
    self.HidMidView.hidden = YES;
    
    _productData = [NSMutableArray array];
    
    [self configUI];
    //    [self configDropView];
    [self.scrollerv setContentSize:self.view.frame.size];
    self.scrollerv.header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getProduct];
        //[tableView reloadData];
        [self.scrollerv.header endRefreshing];
        
        
    }];
    progress=0;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getProduct];
//    self.uplabel.text = @"项目######";
    self.uplabel.font = JFont(20);
    self.uplabel.textColor = RGB_black;
    
    [self.indBg setImage:[UIImage imageNamed:@"fifancing_biankuang1"]];
//    self.indLabe.text = @"已出售70%";
    self.indLabe.font = JFont(12);
    self.indLabe.textColor = RGB(153, 208, 94, 1);
    
    
    [self.imgone setImage:[UIImage imageNamed:@"financing_ding_bao1"]];
    [self.imgtwo setImage:[UIImage imageNamed:@"financing_ding_bao3"]];
    [self.imgthree setImage:[UIImage imageNamed:@"financing_ding_bao2"]];
    self.labelone.text = @"银行存管";
    self.labelone.font = JFont(12);
    self.labelone.textColor = [UIColor lightGrayColor];
    self.labelTwo.text = @"风险备付金";
    self.labelTwo.font = JFont(12);
    self.labelTwo.textColor = [UIColor lightGrayColor];
    self.labelThree.text = @"优质可靠";
    self.labelThree.font = JFont(12);
    self.labelThree.textColor = [UIColor lightGrayColor];
    
    [self.fuBtn setBackgroundImage:[UIImage imageNamed:@"financing_xinshoubiao_fubiao"] forState:UIControlStateNormal];
    [self.xixian setImage:[UIImage imageNamed:@"finanacing_xinshoubiao_fenge_xian-1"]];
    
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.midView.backgroundColor = RGB_gray;
    
//    self.detaillabel.text = @"可售金额:1000,000,000元";
    self.detaillabel.font = JFont(13);
    self.detaillabel.textColor = [UIColor lightGrayColor];
    self.qiangouBtn.titleLabel.font = JFont(fontBtn);
    
    if (iPhone6P) {
        self.topH.constant = 60;
        self.popW.constant = 110;
        self.popH.constant = 45;
        self.detaillabel.font = JFont11;
        self.indLabe.font = JFont(12);
        self.popLabelH.constant = 24;
        _qiangouBtn.layer.cornerRadius = highti6_40/2.0;
        _qiangouBtn.layer.masksToBounds = YES;
        _BtnW.constant = highti6_40;
    }else if(iPhone6){
        
        self.topH.constant = 60;
        self.popW.constant = 100;
        self.popH.constant = 40;
        self.detaillabel.font = JFont11;
        self.indLabe.font = JFont(12);
        self.popLabelH.constant = 22;
        _qiangouBtn.layer.cornerRadius = highti6_40/2.0;
        _qiangouBtn.layer.masksToBounds = YES;
        _BtnW.constant = highti6_40;
    }else {
        _qiangouBtn.layer.cornerRadius = highti5_35/2.0;
        _qiangouBtn.layer.masksToBounds = YES;
        _BtnW.constant = highti5_35;
    }
    [self.qiangouBtn setBackgroundColor:RGB_red];
    
    
}
//- (void
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  
}

- (void)viewDidDisappear:(BOOL)animated{
    [_circleChart removeFromSuperview];
    [self.progressView  removeFromSuperview];
    [self.dropview removeAllSubviews];
    
}
#pragma - UI
- (void)configUI {
    self.dropview.backgroundColor = RGB_gray;
    self.upBg.backgroundColor = RGB_gray;
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
#warning 请求数据待确认
- (void)getProduct {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"2",@"type",nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HomePageCPGYdetail_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:HomePageCPGYdetail_NetWoring]) {//产品
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            [self.productData removeAllObjects];
            NSArray *arr = [response.responseData objectForKey:@"data"];
            NSDictionary *dic = [arr objectAtIndex:0];
            progress=[[dic objectForKey:@"progress"]floatValue];
            BuyModel *m =[[BuyModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            currModel=m;
            [self.productData addObject:m];
            self.uplabel.hidden = NO;
            self.HidMidView.hidden = NO;
            [self configDropView];
            [self donghua ];
            NSInteger bStatus=m.buttonStatus;
            if (bStatus==1) {
                [self.qiangouBtn setTitle:@"即将开启" forState:UIControlStateNormal];
                self.qiangouBtn.enabled=YES;
                [self.qiangouBtn setBackgroundColor:[UIColor lightGrayColor]];
                
            }else if(bStatus==2){
                [self.qiangouBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
                self.qiangouBtn.enabled=YES;
            }else if(bStatus==3){
                [self.qiangouBtn setTitle:@"敬请期待" forState:UIControlStateDisabled];
                [self.qiangouBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
                self.qiangouBtn.enabled=NO;
                [self.qiangouBtn setBackgroundColor:[UIColor lightGrayColor]];
            }
        }
    }
    if ([response.requestId isEqualToString:Buy_Jump]) {//购买跳转
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            BuyOne *b = [[BuyOne alloc]  init];
            b.isfrom = 24;
            b.data = self.productData;
            b.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:b animated:YES];
            UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:b];
#warning 注意此处不同的跳转方式！！
            self.view.window.rootViewController = bb;
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
        [self.qiangouBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.qiangouBtn.enabled=NO;
        [self.qiangouBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
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

#pragma mark 点击详情
- (void)clickedBtnDetailll{
    DetailVC *d = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    d.productId=[NSString stringWithFormat:@"%lld",currModel.productId];
    d.hidesBottomBarWhenPushed = YES;
    d.isfrom = 24;
    UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:d];
    [self presentViewController:bb animated:YES completion:nil];
}
#pragma mark 点击抢购
- (IBAction)qianggouClicked{
      
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
                [Tool setObject:@"101" forKey:@"ojp"];
                n.hidesBottomBarWhenPushed = YES;
                [self.nc pushViewController:n  animated:YES];
                
                [alertt removeFromSuperviewi];
            };
            alert.leftColor=RGB_red;
            alert.rightColor = RGB_red;
            [alert show];
            
            return;
        }
/*        BuyOne *b = [[BuyOne alloc]  init];
        b.isfrom = 24;
        b.data = self.productData;
        b.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:b animated:YES];
        UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:b];
#warning 注意此处不同的跳转方式！！
        self.view.window.rootViewController = bb;*/
        //        [self presentViewController:bb animated:YES completion:nil];
        WDCAccount *a1 = [WDCUserManage getLastUserInfo];
        NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                                  a1.userId,@"userId",@(currModel.productId) ,@"loanId",nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HZMAPImanager shareMAPImanager] addDelegate:self];
        HZMRequest *request =[[HZMRequest alloc] init];
        request.requsetId = Buy_Jump;
        request.requestParamDic = dicParams;
        request.callBackDelegate = self;
        request.tag = 0;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
    }else
    {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 78;
        l.hidesBottomBarWhenPushed = YES;
        UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:l];
        [self presentViewController:bb animated:YES completion:nil];
    }
    
}
#pragma mark 点击浮标
- (IBAction)clickedFuBtn:(id)sender{
    
}
#pragma mark - 创建中间的水球
- (void)configDropView {
    
    BuyModel *model ;
    if (self.productData.count) {
        model = self.productData[0];
        NSString *m = [NSString stringWithFormat:@"%f",model.progress*100];
        NSString *s = [NSString countNumAndChangeformat:m];//[m substringToIndex:m.length-3];
        NSString *max = [s stringByAppendingString:@"%"];
        self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
        self.uplabel.text = model.title;
        
    }
    
    CGFloat w = JSCREEN_W;
    CGFloat h =140;
    CGFloat l = 35*ratioH;
    if (iPhone4s) {
        self.dropViewH.constant = 100;
        h = 100;
    }
    if (iPhone6) {
        self.dropViewH.constant = 140*1.3;
        h = 140*1.3;
    } else if(iPhone6P) {
        self.dropViewH.constant = 140*1.5;
        h = 140*1.5;
    }else if(iPhone5){
        h = 140;
    }
    CGFloat wH=self.dropview.frame.size.height;
    self.view.userInteractionEnabled=YES;
    _circleChart = [[DrowCircle alloc] initWithFrame:CGRectMake(w/2-h/2, (wH-h)/2,  h, h)];
    
    _circleChart.backgroundColor = RGB(153, 208, 94, 1);
    [self.dropview addSubview:_circleChart];
    
    
    
    r=_circleChart.frame.size.height;
    
    
    _titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(_circleChart.frame.origin.x, _circleChart.frame.origin.x, 50.0, 50.0)];
    [_titleLabel1 setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel1 setFont:[UIFont boldSystemFontOfSize:33.0f]];
    [_titleLabel1 setTextColor:[UIColor whiteColor]];
    [self.dropview addSubview:_titleLabel1];
    
    
    _titleLabel1.frame=CGRectMake(0, 0, r, r);
//    _titleLabel1.text=@"8%~18%";
    _titleLabel1.textColor = [UIColor whiteColor];
    _titleLabel1.font = [UIFont systemFontOfSize:15.0f];
    [_titleLabel1 setCenter:CGPointMake(r/2+_circleChart.frame.origin.x,r+_circleChart.frame.origin.y-75)];
    
    
    //按钮
    self.dropview.userInteractionEnabled = YES;
    UIButton *btn=nil;
    if (iPhone4s) {
        btn =  [self createButtonWithTitle:@"查看详情>" backImgName:@"" frame:CGRectMake(w/2-35, wH/2+l-5, 70.0, 20) titleColor:[UIColor blackColor]];
    }else{
        btn =  [self createButtonWithTitle:@"查看详情>" backImgName:@"" frame:CGRectMake(w/2-35, wH/2+l, 70.0, 20) titleColor:[UIColor blackColor]];
    }
    btn.enabled =YES;
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(clickedBtnDetailll) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setTextAlignment:1];
    [btn.titleLabel setFont:JFont11];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dropview addSubview:btn];
    [self.view bringSubviewToFront:btn];
    
    UIImageView *labb = [[UIImageView alloc] initWithFrame:CGRectMake(w/2-35, wH/2-10+l, 80.0, 1.0)];
    [labb setImage:[UIImage imageNamed:@"financing_huoqi_xuxian2"]];
    [self.dropview addSubview:labb];
    
    //年化收益率
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w/2-35, wH/2-10-l, 80.0, 20.0)];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [self.dropview addSubview:lab];
    lab.textColor = [UIColor whiteColor];
    lab.text = @"年化收益";
    lab.font = JFont13;
    
    
    //利率
    _titleLabel=[[UICountingLabel alloc]initWithFrame:CGRectMake(w/2-70, wH/2-15, 140.0, 30)];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    //[_titleLabel setFont:[UIFont boldSystemFontOfSize:25.0f]];
   
    [_titleLabel setTextColor:[UIColor whiteColor]];
//    _titleLabel.method = UILabelCountingMethodEaseInOut;
    [self.dropview addSubview:_titleLabel];
    NSString *min = [NSString stringWithFormat:@"%.2lf",model.minRate];
    min = [min stringByAppendingString:@"%"];
    NSString *max = [NSString stringWithFormat:@"%.2lf",model.maxRate];
    max = [max stringByAppendingString:@"%"];
    _titleLabel.text=[NSString stringWithFormat:@"%@",min];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    int a = (int)_titleLabel.text.length;
    a--;
    NSRange r1 = [min rangeOfString:@"."];
    NSString *rs1 = [min substringToIndex:r1.location];
    NSRange r2 = [max rangeOfString:@"."];
    NSString *rs2 = [max substringToIndex:r2.location];
    [self setFontColorLabel:_titleLabel :0 :rs1.length];
    [self setFontColorLabel:_titleLabel :a-max.length+1 :rs2.length];
    
    currentTransform=_circleChart.transform;
    
    
    
    
    for (UIView * v  in self.dropview.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            [self.dropview bringSubviewToFront:v];
        }
    }
    NSString *ss = [NSString stringWithFormat:@"%f",model.amount];
    ss = [NSString countNumAndChangeformat:ss];
    self.detaillabel.text = [NSString stringWithFormat:@"可购份额：%@",ss];
}
- (void)donghua {
    CGFloat w = JSCREEN_W;
    CGFloat h ;
    if (iPhone6) {
        h = 140*1.3;
    } else if(iPhone6P) {
        h = 140*1.5;
    }else if(iPhone4s)
    {
        h=100;
    }else{
        h = 140;
    }
    //    外侧的进度条
     CGFloat wH=self.dropview.frame.size.height;
    self.progressView = [[PICircularProgressView alloc]init];
    self.progressView.frame = CGRectMake(w/2-h/2, (wH-h)/2,  h, h);
    [self.dropview addSubview:self.progressView];
    _x = 0;
    //   进度条
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(z) userInfo:nil repeats:YES];
    //    粗细
    self.progressView.thicknessRatio = Jradius;
    self.progressView.showText = 0;
    //    颜色
    self.progressView.progressTopGradientColor = RGB(143, 193, 80, 1);
    self.progressView.progressBottomGradientColor = RGB(192, 247, 192, 1);
    self.progressView.roundedHead = YES;
    for (UIView * v  in self.dropview.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            [self.dropview bringSubviewToFront:v];
        }
    }
}

//进度条的显示百分比
- (void)z{
    if (_x>=progress) {
        return;
    }
    _x +=0.02;
    self.progressView.progress = _x;
}




#pragma mark - 其他
-(void)setFontColorLabel:(UILabel *)label :(int)a :(int)b {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:25]} range:NSMakeRange(a, b)];
    //    [att addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:RGB_red} range:NSMakeRange(a, b)];
    label.attributedText = att;
}
-(void)dealloc
{
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


@end
