//
//  AccountDQSubOne.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJYSubOne.h"
#import "AccountJYModel.h"
#import "AccountJYSubOneCell.h"
@interface AccountJYSubOne ()<UITableViewDataSource,HZMAPIManagerDelegate,UITableViewDelegate>
{
    //网络请求的，当前是第几页：
    NSInteger _currentPage;
    //网络请求的，总条数：
    NSInteger _totalNum;
    //是否是下拉加载
    BOOL isAdd;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AccountJYSubOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView  registerNib:[UINib nibWithNibName:@"AccountJYSubOneCell" bundle:nil] forCellReuseIdentifier:@"AccountJYSubOneCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle       = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.data = [NSMutableArray arrayWithCapacity:0];
    
    self.view.backgroundColor = RGB_gray;
    
    _currentPage = 1;
    
     __weak UITableView *tableView = self.tableView;
    //下拉率刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     
            _currentPage= 1;
            isAdd = NO;
            [self getProduct:[NSString stringWithFormat:@"%ld",self.pageNum-1]:@"1"];
            [tableView reloadData];
            [tableView.header endRefreshing];
        
        
    }];
    // 上啦刷新
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
            if (_currentPage>_totalNum/20) {//每页10条数据
                [self.view makeToast:@"数据已经全部加载完"];
                [tableView.footer endRefreshing];
//                [tableView reloadData];
                return ;
            }else{
                _currentPage++;
            }
            isAdd = YES;
            
            [self getProduct:[NSString stringWithFormat:@"%ld",self.pageNum-1]:[NSString stringWithFormat:@"%ld",_currentPage]];
            [tableView reloadData];
            [tableView.footer endRefreshing];
        }
        
    ];
    
//    [self datai];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.pageNum)
        [self getProduct:[NSString stringWithFormat:@"%ld",self.pageNum-1]:@"1"];
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
//- (void)datai {
//    for (int i=0; i<self.pageNum; i++) {
//        NSString *str;
//         AccountJYModel *model = [[AccountJYModel alloc] init];
//        if (self.pageNum == 2)
//            model.leftUp = [NSString stringWithFormat:@"购买%@XX",i%2?@"活期":@"定期"];
//        if (self.pageNum == 3)
//            model.leftUp = [NSString stringWithFormat:@"充值%@",i%2?@"2000":@"1000"];
//        if (self.pageNum == 4)
//            model.leftUp = [NSString stringWithFormat:@"赎回"];
//        if (self.pageNum == 5)
//            model.leftUp = [NSString stringWithFormat:@"提现"];
//        
//       
//        
//        model.leftDOwn = [NSString stringWithFormat:@"%@",i%2?@"2015-12-12 12:00":@"2016-12-12 12:00"];
//        model.rightUp = [NSString stringWithFormat:@"%@",i/2?@"2000":@"3000"];
//        model.rightDown = [NSString stringWithFormat:@"可用余额%@",i/2?@"22":@"444"];
//        
//        [self.data addObject:model];
//    }
//}

#pragma mark - 网络
- (void)getProduct:(NSString *)type:(NSString *)page{
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",
                              type,@"txntype",
                              page,@"pageNum",
                              @"20",@"pageSize",nil];//10页
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounJiaoyijilu_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounJiaoyijilu_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            _totalNum =  [response.responseData[@"recordCount"] integerValue];
            NSArray *arr= [response.responseData objectForKey:@"data"];
            if (isAdd) {//上啦
            }else{
                [self.data removeAllObjects];
            }
            
            for (NSDictionary *dic in arr) {
                AccountJYModel *model = [[AccountJYModel alloc] initWithDic:dic];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountJYModel *model = self.data[indexPath.row];
    static NSString *AccountDQCellID = @"AccountJYSubOneCell";
    AccountJYSubOneCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountDQCellID];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =[UIColor whiteColor];
    if (indexPath.row%2) {
        cell.backgroundColor = RGB_gray;
        cell.contentView.backgroundColor = RGB_gray;
    }else{
        cell.backgroundColor =[ UIColor whiteColor];
        cell.contentView.backgroundColor =[ UIColor whiteColor];

    }
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
