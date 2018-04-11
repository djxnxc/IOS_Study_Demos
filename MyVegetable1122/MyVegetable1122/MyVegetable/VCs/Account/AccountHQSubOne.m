//
//  AccountHQSubOne.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountHQSubOne.h"
#import "AccountHQCellModel.h"
#import "AccountHQCell.h"
@interface AccountHQSubOne ()<HZMAPIManagerDelegate>
{
    UINib *nib;
    NSMutableArray *_data;
    
    //网络请求的，当前是第几页：
    NSInteger _currentPage;
    //网络请求的，总条数：
    NSInteger _totalNum;
    //是否是下拉加载
    BOOL isAdd;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AccountHQSubOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =RGB_gray;
    self.tableView.separatorStyle       = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _currentPage=1;
    
    self.data = [NSMutableArray arrayWithCapacity:0];
   
    
    NSDate *  timeDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //    [date formattersetDateFormat:@"HH:mm:ss"];
    [dateformatter setDateFormat:@"yyyy/MM/dd"];
    NSString *  locationString=[dateformatter stringFromDate:timeDate];
    
    __weak UITableView *tableView = self.tableView;
    //下拉率刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage=1;
        if (self.pageNum == 0) {//周
            
            [self getProduct:@"1":locationString:@"1"];
        }else{//月
            [self getProduct:@"2":locationString:@"1"];
        }
        [tableView reloadData];
        [tableView.header endRefreshing];
    }];
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (_currentPage>_totalNum/30) {//每页10条数据
            [self.view makeToast:@"数据已经全部加载完"];
            [tableView.footer endRefreshing];
            return ;
            //            _currentPage;
        }else{
            _currentPage++;
        }
        isAdd = YES;
        
        if (self.pageNum == 0) {//周
            [self getProduct:@"1":locationString:[NSString stringWithFormat:@"%ld",_currentPage]];
        }else{//月
            [self getProduct:@"2":locationString:[NSString stringWithFormat:@"%ld",_currentPage]];
        }
        [tableView reloadData];
        [tableView.footer endRefreshing];
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDate *  timeDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //    [date formattersetDateFormat:@"HH:mm:ss"];
    [dateformatter setDateFormat:@"yyyy/MM/dd"];
    NSString *  locationString=[dateformatter stringFromDate:timeDate];
    
    
    if (self.pageNum == 0) {//周
        [self getProduct:@"1":locationString:@"1"];
    }else{//月
        [self getProduct:@"2":locationString:@"1"];
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
    
    CGRect f=CGRectMake(0, 0, SCREEN_WIDTH, JSCREEN_H-75);
    //f.size=self.view.frame.size;
    //self.tableView.frame = f;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    NSLog(@"ffffffram=====>%f",self.tableView.frame.size.width);
}
-(void)reflash
{
    NSDate *  timeDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //    [date formattersetDateFormat:@"HH:mm:ss"];
    [dateformatter setDateFormat:@"yyyy/MM/dd"];
    NSString *  locationString=[dateformatter stringFromDate:timeDate];
    self.data=[[NSMutableArray alloc]init];
    _currentPage=1;
    if (self.pageNum == 0) {//周
        [self getProduct:@"1":locationString:@"1"];
    }else{//月
        [self getProduct:@"2":locationString:@"1"];
    }
    self.data=[[NSMutableArray alloc]init];
}
#pragma mark - 网络
- (void)getProduct:(NSString *)type:(NSString*)timee:(NSString *)page{
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",
                              page,@"pageNum",
                              @"30",@"pageSize",//每页10条
                              type,@"type",
                              timee,@"endDate",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounHuoQiSY_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounHuoQiSY_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSArray *arr = [response.responseData objectForKey:@"data"];
            NSDictionary *dict=response.responseData;
#warning 页数问题！！！
            _totalNum =  [[dict objectForKey:@"recordCount" ] integerValue];
            if (isAdd) {//上啦
                [self.tableView reloadData];
            }else{
                // 下拉刷新
                [self.data removeAllObjects];
                [self.tableView reloadData];
            }
            
            //[self.data removeAllObjects];
            for (NSDictionary *dic in arr) {
                AccountHQCellModel *model = [[AccountHQCellModel alloc] initWithDic:dic];
                [self.data addObject:model];
            }
            
            [self.tableView reloadData];
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

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    AccountHQCellModel*model = self.data[indexPath.row];
    //static NSString *AccountMianCellID = @"AccountHQCellModelone";
    AccountHQCell* theCell=[tableView dequeueReusableCellWithIdentifier:@"achq"];
    if (theCell==nil) {
        theCell=[[AccountHQCell alloc]initWithNib:self.view.frame.size.width];
        theCell.restorationIdentifier=@"achq";
    }
    //CGFloat f=SCREEN_WIDTH;
    theCell.SBW=SCREEN_WIDTH;

    theCell.model = model;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    theCell.contentView.backgroundColor =RGB_gray;
    //    cell.backgroundColor = [UIColor clearColor];
    return theCell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setTableViewFrame:(CGRect)frame
{
    self.tableView.frame=frame;
    self.tableView.bounds=frame;
}

@end
