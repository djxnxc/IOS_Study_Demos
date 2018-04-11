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


//#define NUMBER_OF_VISIBLE_VIEWS 6
@interface SubTwoVC ()<LTInfiniteScrollViewDelegate,LTInfiniteScrollViewDataSource,DingQiLCDViewDelegate,HZMAPIManagerDelegate>
{
    
    NSInteger  NUMBER_OF_VISIBLE_VIEWS;
    NSInteger i;
   
}
@property (nonatomic,strong) LTInfiniteScrollView *scrollView;
@property (nonatomic) CGFloat viewSize;

@property (weak, nonatomic) IBOutlet UIButton *fuBtn;
- (IBAction)clickedFuBtn:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnW;

@property (nonatomic, strong) NSMutableArray *productData;
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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popLabelH;


@property (assign, nonatomic) NSInteger isSelectedNum;

@end

@implementation SubTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NUMBER_OF_VISIBLE_VIEWS = 6;
    self.isSelectedNum = 101;
    i = 0;
     _productData = [NSMutableArray array];
    [self getdata];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configUI];
    [self getdata];
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
    self.indLabe.font = JFont(13);
    self.indLabe.textColor = RGB(248, 198, 104, 1);
    
    [self.imgone setImage:[UIImage imageNamed:@"financing_ding_bao1"]];
    [self.imgtwo setImage:[UIImage imageNamed:@"financing_ding_bao3"]];
    [self.imgthree setImage:[UIImage imageNamed:@"financing_ding_bao2"]];
    self.labelone.text = @"银行托管";
    self.labelone.font = JFont(12);
    self.labelone.textColor = [UIColor lightGrayColor];
    self.labelTwo.text = @"风险备付金";
    self.labelTwo.font = JFont(12);
    self.labelTwo.textColor = [UIColor lightGrayColor];
    self.labelThree.text = @"本息保障";
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
    JLog(@"++++++++%ld",self.scrollView.subviews.count);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.productData removeAllObjects];
    [self.dropview removeAllSubviews];
    i = 0;
}
- (void)getdata {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getProduct:@"1" :@"3"];//6个月，每天
    [self getProduct:@"3" :@"3"];//1个月，每天
    [self getProduct:@"6" :@"3"];//3个月，每天
    [self getProduct:@"9" :@"3"];//9个月，每天
    [self getProduct:@"12" :@"3"];//12个月，每天
    

}
#pragma mark - UI
- (void)configUI {
    
    if (iPhone6) {
        self.popW.constant = 120;
        self.popH.constant = 50;
        self.detaillabel.font = JFont15;
        self.popLabelH.constant = 18;
        self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 18, [UIScreen mainScreen].bounds.size.width, 230)];
    } else if (iPhone6P){
        self.popW.constant = 110;
        self.popH.constant = 45;
        self.detaillabel.font = JFont15;
        self.popLabelH.constant = 20;
        self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 18, [UIScreen mainScreen].bounds.size.width, 360)];
    }else{
        self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 18, [UIScreen mainScreen].bounds.size.width, 200)];
    }
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.dataSource = self;
    self.scrollView.maxScrollDistance = 5;
    self.scrollView.delegate = self;
    
}
#pragma mark - 中间的UI的代理方法等
//总的数量
- (NSInteger)numberOfViews
{
    return 7;
}
//显示的数量
- (NSInteger)numberOfVisibleViews
{
    return 3;
}
//返回一个显示的UI
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view){
                return view;
            }
    
    DingqiLICAI *qview = [DingqiLICAI viewWith:@""];
    qview.frame = self.dropview.frame;
    qview.delegate = self;
    DingLICAIModel *m = [[DingLICAIModel alloc]init];
    
//    self transactionFinished:<#(HZMResponse *)#>
    m.title =[NSString stringWithFormat:@"%ld",(long)index];
    m.icon = @"financing_huoqi_bg";
    if (self.productData.count) {
        m.model = self.productData[0];
    }
    
    [qview setDmodel:m];
    
    
    return qview;
}
//翻转的代理
- (void)updateView:(UIView *)view withProgress:(CGFloat)progress scrollDirection:(ScrollDirection)direction
{
  
    // you can appy animations duration scrolling here
    
    CATransform3D transform = CATransform3DIdentity;
    
    // scale
    CGFloat size = self.viewSize;
    CGPoint center = view.center;
    view.center = center;
//    NSLog(@"%lf",progress);
    //    size = size * (2.2 - 1.5 * (fabs(progress)));
    //    size = size * 2;
    if (iPhone6) {
        if (fabs(progress) <= 0.5) {
            size = 150;
        }else {
            size = 60;
        }
    } else if (iPhone6P){
        if (fabs(progress) <= 0.5) {
            size = 260;
        }else {
            size = 70;
        }
    }else{

        if (fabs(progress) <= 0.5) {
            size = 130;
        }else {
            size = 80;
        }
    }
    JLog(@"-------%lf",fabs(progress));
    
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
            
            if (view.tag == -2) {
                if (self.productData.count) {
                    m = self.productData[0];
                    model = m.model;
                }
                self.uplabel.text  = @"1月份";
                NSString *mm = [NSString stringWithFormat:@"%.2lf",model.progress*100];
                NSString *s = [mm substringToIndex:mm.length-3];
                NSString *max = [s stringByAppendingString:@"%"];
                self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
                self.detaillabel.text =[NSString stringWithFormat:@"可售金额:%lld元",model.amount];
                self.isSelectedNum = 0;
            }
            if (view.tag == -1) {
                if (self.productData.count) {
                    m = self.productData[1];
                    model = m.model;
                }
                self.uplabel.text  = @"3月份";
                NSString *mm = [NSString stringWithFormat:@"%.2lf",model.progress*100];
                NSString *s = [mm substringToIndex:mm.length-3];
                NSString *max = [s stringByAppendingString:@"%"];
                self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
                self.detaillabel.text =[NSString stringWithFormat:@"可售金额:%lld元",model.amount];
                self.isSelectedNum = 1;
            }
            if (view.tag == 0) {
                if (self.productData.count) {
                    m = self.productData[2];
                    model = m.model;
                }
                self.uplabel.text  = @"6月份";
                NSString *mm = [NSString stringWithFormat:@"%.2lf",model.progress*100];
                NSString *s = [mm substringToIndex:mm.length-3];
                NSString *max = [s stringByAppendingString:@"%"];
                self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
                self.detaillabel.text =[NSString stringWithFormat:@"可售金额:%lld元",model.amount];
                self.isSelectedNum = 2;
            }
            if (view.tag == 1) {
                if (self.productData.count) {
                    m = self.productData[3];
                    model = m.model;
                }
                self.uplabel.text  = @"9月份";
                NSString *mm = [NSString stringWithFormat:@"%.2lf",model.progress*100];
                NSString *s = [mm substringToIndex:mm.length-3];
                NSString *max = [s stringByAppendingString:@"%"];
                self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
                self.detaillabel.text =[NSString stringWithFormat:@"可售金额:%lld元",model.amount];
                self.isSelectedNum = 3;
            }
            if (view.tag == 2) {
                if (self.productData.count) {
                    m = self.productData[4];
                    model = m.model;
                }
                self.uplabel.text  = @"12月份";
                NSString *mm = [NSString stringWithFormat:@"%.2lf",model.progress*100];
                NSString *s = [mm substringToIndex:mm.length-3];
                NSString *max = [s stringByAppendingString:@"%"];
                self.indLabe.text = [NSString stringWithFormat:@"已出售%@",max];
                self.detaillabel.text =[NSString stringWithFormat:@"可售金额:%lld元",model.amount];
                self.isSelectedNum = 4;
            }
            m.icon = @"financing_huoqi_bg";
            [qview setDmodel:m];
            qview.backgroundColor = [UIColor clearColor];
//            qview.backgroundColor = [UIColor whiteColor];
        }
        else {//左侧
            
            DingqiLICAI *qview = (DingqiLICAI *)view;
             DingLICAIModel *m = [[DingLICAIModel alloc] init];
//            DingLICAIModel *m;
//            if (self.productData.count) {
//                m = self.productData[0];
//            }
            
            if (view.tag == -2) {
                m.smallTitle = @"1";
            }else if (view.tag == -1) {
                m.smallTitle = @"3";
            }else if (view.tag == 0) {
                m.smallTitle = @"6";
            }else if (view.tag == 1) {
                m.smallTitle= @"9";
            }else if (view.tag == 2) {
                m.smallTitle= @"12";
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
//        DingLICAIModel *m;
//        if (self.productData.count) {
//            m = self.productData[0];
//        }
        if (view.tag == -2) {
            m.smallTitle = @"1";
        }else if (view.tag == -1) {
            m.smallTitle = @"3";
        }else if (view.tag == 0) {
            m.smallTitle = @"6";
        }else if (view.tag == 1) {
            m.smallTitle= @"9";
        }else if (view.tag == 2) {
            m.smallTitle= @"12";
        }else{
            m.smallTitle= @"Null";
        }
        m.icon = @"financing_huoqi_bg";
        [qview setDmodel:m];
        
    }
    
    view.layer.transform = transform;
    
}
#pragma mark 获取产品信息
#warning 请求数据待确认
- (void)getProduct:(NSString *)cycle :(NSString *)type {
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              @"2",@"type",
                              cycle,@"cycle",
                              type,@"cycleType",nil];
    
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
            NSDictionary *dic = [arr objectAtIndex:0];
            BuyModel *m =[[BuyModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            
            DingLICAIModel *d = [[DingLICAIModel alloc] init];
            d.model = m;
            d.ID = i;
            i++;
            
            [self.productData addObject:d];
            if (i==3) {
                [self.scrollView reloadData];
            }
            
        }
       
    }
}
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
}



#pragma mark - 交互

#pragma mark 点击详情
- (void)didClickedDetailBtnn:(UIButton *)btn {
    DetailVC *d = [[DetailVC alloc] init];
    d.hidesBottomBarWhenPushed = YES;
    d.isfrom = 23;
    UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:d];
    [self presentViewController:bb animated:YES completion:nil];
}
#pragma mark 点击立即抢购
- (IBAction)qianggouClicked{
    
    if ([[Tool objectForKey:JIsLoginUser] isEqualToString:@"1"]) {
        BuyOne *b = [[BuyOne alloc]  init];
        NSMutableArray *arr = [NSMutableArray array];
        switch (self.isSelectedNum) {
            case 0:{//1月
                [arr addObject:self.productData[0]];
                b.data = arr;
                break;
            }case 1:{//3月
                [arr addObject:self.productData[1]];
                b.data = arr;
                break;
            }case 2:{//6月
                [arr addObject:self.productData[2]];
                b.data = arr;
                break;
            }case 3:{//9月
                [arr addObject:self.productData[3]];
                b.data = arr;
                break;
            }case 4:{//12月
                [arr addObject:self.productData[4]];
                b.data = arr;
                break;
            }
            default:
                break;
        }
        
        b.isfrom = 23;
        
        UINavigationController *bb = [[UINavigationController alloc] initWithRootViewController:b];
        [self presentViewController:bb animated:YES completion:nil];
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



@end
