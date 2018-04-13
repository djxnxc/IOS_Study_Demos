//
//  SubTwoVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/12.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "SubTwoVC.h"
#import "LTInfiniteScrollView.h"
#import "DingqiLICAI.h"
#import "DingLICAIModel.h"
#import "BuyOne.h"
#import "DetailVC.h"
#import "TransData.h"
#import "NameSure.h"
//#define NUMBER_OF_VISIBLE_VIEWS 6
@interface SubTwoVC ()<LTInfiniteScrollViewDelegate,LTInfiniteScrollViewDataSource,DingQiLCDViewDelegate,HZMAPIManagerDelegate>
{
    
    NSInteger  NUMBER_OF_VISIBLE_VIEWS;
    NSInteger index;
    NSInteger sIndex;
    long long overTimer;
    NSTimer *timer;
    BuyModel* currmode;
   
}
@property (nonatomic,strong) LTInfiniteScrollView *scrollView;
@property (nonatomic) CGFloat viewSize;

@property (weak, nonatomic) IBOutlet UIButton *fuBtn;
- (IBAction)clickedFuBtn:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnW;

@property (nonatomic, strong) NSMutableArray *useData;
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
//scrollw的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popLabelH;

@property (weak, nonatomic) IBOutlet UIView *HidMidView;

@property (assign, nonatomic) NSInteger isSelectedNum;
//scrollview顶部的H
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewTopH;
//顶部月份的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UpLbelH;

@end

@implementation SubTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uplabel.hidden = YES;
    self.HidMidView.hidden = YES;
//    NUMBER_OF_VISIBLE_VIEWS = 6;
    self.isSelectedNum = 101;
//    i = 0;
//     _productData = [NSMutableArray array];
    _useData = [NSMutableArray array];
//    [self getProduct];
    sIndex = 912;
    [self.svt setContentSize:self.view.frame.size];
    self.svt.header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getProduct];
        //[tableView reloadData];
        [self.svt.header endRefreshing];
        
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configUI];
//    [self getProduct];
    self.viewSize = 40;
    
    
    self.bgview.backgroundColor = RGB_gray;
    self.midView.backgroundColor = RGB_gray;
    self.dropview.backgroundColor =RGB_gray;
    self.upBg.backgroundColor =RGB_gray;
//    self.uplabel.text = @"3月份";
    self.uplabel.font = JFont(20);
    self.uplabel.textColor = RGB_black;
    
    [self.indBg setImage:[UIImage imageNamed:@"fifancing_biankuang3"]];
//    self.indLabe.text = @"已出售70%";
    
    self.indLabe.textColor = RGB(248, 198, 104, 1);
    
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
    
    
    
    
    self.detaillabel.font = JFont(13);
    self.detaillabel.textColor = [UIColor lightGrayColor];
    
    if (iPhone6P) {
        _qiangouBtn.layer.cornerRadius = highti6_40/2.0;
        _qiangouBtn.layer.masksToBounds = YES;
        _BtnW.constant = highti6_40;
    }else if(iPhone6){
        _qiangouBtn.layer.cornerRadius = highti6_40/2.0;
        _qiangouBtn.layer.masksToBounds = YES;
        _BtnW.constant = highti6_40;
    }else {
        _qiangouBtn.layer.cornerRadius = highti5_35/2.0;
        _qiangouBtn.layer.masksToBounds = YES;
        _BtnW.constant = highti5_35;
    }
    [self.qiangouBtn setBackgroundColor:RGB_red];
    self.qiangouBtn.titleLabel.font = JFont(fontBtn);
    
    
}
- (void)viewDidAppear:(BOOL)animated {
//    JLog(@"++++++++%ld",self.scrollView.subviews.count);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.scrollView removeAllSubviews];
    [self configUI];
    [self getProduct];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.useData removeAllObjects];
//    [self.dropview removeAllSubviews];
    [self.scrollView removeAllSubviews];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.useData removeAllObjects];
    [self.scrollView removeAllSubviews];
//    i = 0;
}
#pragma mark - UI
- (void)configUI {
    if (iPhone4s) {
        
    }
    if (iPhone6) {
        self.popW.constant = 100;
        self.popH.constant = 45;
        self.detaillabel.font = JFont11;
        self.indLabe.font = JFont(12);
        self.popLabelH.constant = 24;
        self.UpLbelH.constant = 30;
        self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230)];//48
    } else if (iPhone6P){
        self.popW.constant = 110;
        self.popH.constant = 45;
        self.detaillabel.font = JFont11;
        self.indLabe.font = JFont(12);
        
        self.popLabelH.constant = 24;
        self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 360)];//33
    }else if (iPhone5){
        self.indLabe.font = JFont(12);
        self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];//18
    }
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.dropview addSubview:self.scrollView];
    
    self.scrollView.dataSource = self;
    self.scrollView.maxScrollDistance = 5;
    self.scrollView.delegate = self;
    
}
#pragma mark - 中间的UI的代理方法等
//总的数量
- (NSInteger)numberOfViews
{
    return self.useData.count;
}
//显示的数量
- (NSInteger)numberOfVisibleViews
{
    return 3;
}
//返回一个显示的UI
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view)
    {
        return view;
    }
    //long tin=index%self.useData.count;
    DingqiLICAI *qview = [DingqiLICAI viewWith:@""];
    qview.frame = self.dropview.frame;
    qview.delegate = self;
    DingLICAIModel *m = [[DingLICAIModel alloc]init];
    
//    self transactionFinished:<#(HZMResponse *)#>
    m.title =[NSString stringWithFormat:@"%ld",index];
    m.icon = @"financing_huoqi_bg";
    if (self.useData.count) {
        if (self.useData.count%2&&self.useData.count!=1) {//奇数
            m.model = self.useData[self.useData.count/2+1];
        }else{
            m.model = self.useData[self.useData.count/2];
        }
    }
    [qview setDmodel:m];
    
   // NSLog(@"%ld",index);
    return qview;
}
//翻转的代理
- (void)updateView:(UIView *)view withProgress:(CGFloat)progress scrollDirection:(ScrollDirection)direction
{
    index = [TransData transViewIndex:view arr:_useData];
    sIndex = [TransData transViewSindex:view arr:_useData];
    
    CATransform3D transform = CATransform3DIdentity;
    //NSLog(@"%f",progress);
    // scale
    CGFloat size = self.viewSize;
    CGPoint center = view.center;
    view.center = center;
    //    NSLog(@"%lf",progress);
    //    size = size * (2.2 - 1.5 * (fabs(progress)));
    //    size = size * 2;
    if (iPhone6) {
        if (fabs(progress) <= 0.5) {
            size = 200;
        }else {
            size = 100;
        }
    } else if (iPhone6P){
        if (fabs(progress) <= 0.5) {
            size = 240;
        }else {
            size = 101;
        }
    }else if (iPhone5){
        
        if (fabs(progress) <= 0.5) {
            size = 130;
        }else {
            size = 80;
        }
    }
    //    JLog(@"-------%lf",fabs(progress));
    
    view.frame = CGRectMake(0, 0, size, size);
    view.layer.cornerRadius = size/2 ;
    view.center = center;
    
    // translate
    CGFloat translate = self.viewSize / 3 * progress;
    if (progress > 1) {
        translate = self.viewSize / 3;
    } else if (progress < -1) {
        translate = -self.viewSize / 3;
    }
    transform = CATransform3DTranslate(transform, translate, 0, 0);
    
    // rotate
    if (fabs(progress) < 1) {
        CGFloat angle = 0;
        if(progress > 0) {
            angle = - M_PI * (1 - fabs(progress));
        } else {
            angle =  M_PI * (1 - fabs(progress));
        }
        transform.m34 = 1.0 / -600;
        if (fabs(progress) <= 0.5) {//中间
            angle =  M_PI * progress;
            DingqiLICAI *qview = (DingqiLICAI *)view;
            DingLICAIModel *m ;
            BuyModel *model;
            if (self.useData.count) {
                m = self.useData[index];
                model = m.model;
                currmode=model;
            }
            self.uplabel.text  = model.title;
            NSString *mm = [NSString stringWithFormat:@"%.2lf",model.progress*100];
            NSString *s =[NSString countNumAndChangeformat:mm];// [mm substringToIndex:mm.length-3];
            NSString *max = [s stringByAppendingString:@"%"];
            self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
            NSString *ss = [NSString stringWithFormat:@"%f",model.amount];
            ss = [NSString countNumAndChangeformat:ss];
            
            self.detaillabel.text =[NSString stringWithFormat:@"可购份额:%@份",ss];
            self.isSelectedNum = index;
            
            m.icon = @"financing_huoqi_bg";
            [qview setDmodel:m];
            qview.backgroundColor = [UIColor clearColor];
            
            NSInteger bStatus=model.buttonStatus;
            if (bStatus==1) {
                [self.qiangouBtn setTitle:@"即将开启" forState:UIControlStateNormal];
                self.qiangouBtn.enabled=YES;
                [self.qiangouBtn setBackgroundColor:[UIColor colorWithRed:0.95 green:0.32 blue:0.24 alpha:1]];
                
            }else if(bStatus==2){
                [self.qiangouBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
                self.qiangouBtn.enabled=YES;
                [self.qiangouBtn setBackgroundColor:[UIColor colorWithRed:0.95 green:0.32 blue:0.24 alpha:1]];
            }else if(bStatus==3){
                [self.qiangouBtn setTitle:@"敬请期待" forState:UIControlStateDisabled];
                [self.qiangouBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
                self.qiangouBtn.enabled=NO;
                [self.qiangouBtn setBackgroundColor:[UIColor lightGrayColor]];
            }
        }
        else {//左侧
            
            DingqiLICAI *qview = (DingqiLICAI *)view;
            DingLICAIModel *m = [[DingLICAIModel alloc] init];
            
            if (sIndex!=99) {
                DingLICAIModel *mm = _useData[sIndex];
                BuyModel *model = mm.model;
                m.smallTitle = [NSString stringWithFormat:@"%ld",model.cycle];
            }else{
                m.smallTitle= @"Null";
            }
            m.icon = @"financing_huoqi_bg";
            [qview setDmodel:m];
        }
        transform = CATransform3DRotate(transform, angle , 0.0f, 1.0f, 0.0f);
    } else {
        //右侧
        DingqiLICAI *qview = (DingqiLICAI *)view;
        DingLICAIModel *m = [[DingLICAIModel alloc] init];
        if (sIndex!=99) {
            DingLICAIModel *mm = _useData[sIndex];
            BuyModel *model = mm.model;
            m.smallTitle = [NSString stringWithFormat:@"%ld",model.cycle];
        }else{
            m.smallTitle= @"Null";
        }
        m.icon = @"financing_huoqi_bg";
        [qview setDmodel:m];
        
    }
    
    view.layer.transform = transform;
    
}
#pragma mark 获取产品信息

- (void)getProduct {
    
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"3",@"type",nil];
    
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
            NSArray *arr = [response.responseData objectForKey:@"data"];
//            [self.useData removeAllObjects];
            for (int i=0; i<arr.count; i++) {
                NSDictionary *dic = [arr objectAtIndex:i];
                BuyModel *m =[[BuyModel alloc] init];
                [m setValuesForKeysWithDictionary:dic];
                DingLICAIModel *d = [[DingLICAIModel alloc] init];
                d.model = m;
                d.ID = i;
                if (i == 0) {
                    d.ID=-77;
                    if (arr.count%2==0) {
                      [self.useData addObject:d];
                    }
                    d.ID=i;
                }else if(i == arr.count-1){
                    [self.useData addObject:d];
                }
                [self.useData addObject:d];
            }
            self.uplabel.hidden = NO;
            self.HidMidView.hidden = NO;
                [self.scrollView reloadData];
            if ([response.requestId isEqualToString:HomePageCPGYdetail_NetWoring]&& arr.count==0)
            {
                DingLICAIModel *d = [[DingLICAIModel alloc] init];
                d.model=[[BuyModel alloc]init];
                d.ID=0;
                [self.useData addObject:d];
                [self.useData addObject:d];
                [self.useData addObject:d];
                [self.useData addObject:d];
                
                self.uplabel.hidden = NO;
                self.HidMidView.hidden = NO;
                [self.scrollView reloadData];
                
                
                [self.qiangouBtn setBackgroundColor:[UIColor lightGrayColor]];
                self.qiangouBtn.enabled=NO;
                [self.qiangouBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
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
    if ([response.requestId isEqualToString:HomePageCPGYdetail_NetWoring])
    {
        DingLICAIModel *d = [[DingLICAIModel alloc] init];
        d.model=[[BuyModel alloc]init];
        d.ID=0;
        [self.useData addObject:d];
        [self.useData addObject:d];
        [self.useData addObject:d];
        [self.useData addObject:d];
        
        self.uplabel.hidden = NO;
        self.HidMidView.hidden = NO;
        [self.scrollView reloadData];
        
        
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
- (void)didClickedDetailBtnn:(UIButton *)btn {
    DetailVC *d = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    d.productId=[NSString stringWithFormat:@"%lld",currmode.productId];
    d.hidesBottomBarWhenPushed = YES;
    d.isfrom = 23;
    UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:d];
    [self presentViewController:bb animated:YES completion:nil];
}
#pragma mark 点击立即抢购
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
                n.hidesBottomBarWhenPushed = YES;
                [self.nc pushViewController:n  animated:YES];
                
                [alertt removeFromSuperviewi];
            };
            alert.leftColor=RGB_red;
            alert.rightColor = RGB_red;
            [alert show];
            
            return;
        }
        BuyOne *b = [[BuyOne alloc]  init];
        NSMutableArray *arr = [NSMutableArray array];
        if (self.useData.count) {
            [arr addObject:self.useData[_isSelectedNum]];
        }else
        {[self.view makeToast:@"暂无数据"];
            return;}
        
        b.data = arr;
        b.isfrom = 23;
        UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:b];
#warning 注意此处不同的跳转方式！！
        self.view.window.rootViewController = bb;
//        [self presentViewController:bb animated:YES completion:nil];
    }else
    {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 77;
        l.hidesBottomBarWhenPushed = YES;
        UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:l];
        [self presentViewController:bb animated:YES completion:nil];
    }
    
}
#pragma mark 点击浮标
- (IBAction)clickedFuBtn:(id)sender{
    
}
#pragma mark - 其他
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//        switch (self.isSelectedNum) {
//            case 0:{//1月
//
//                break;
//            }case 1:{//3月
//                [arr addObject:self.useData[1]];
//                b.data = arr;
//                break;
//            }case 2:{//6月
//                [arr addObject:self.useData[2]];
//                b.data = arr;
//                break;
//            }case 3:{//9月
//                [arr addObject:self.useData[3]];
//                b.data = arr;
//                break;
//            }case 4:{//12月
//                [arr addObject:self.useData[4]];
//                b.data = arr;
//                break;
//            }
//            default:
//                break;
//        }


@end
