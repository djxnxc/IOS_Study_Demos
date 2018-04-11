//
//  JFriendsPageVC.m
//  QQ好友页面
//
//  Created by 蒋孝才 on 15/7/23.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import "ChangJianWT.h"
#import "JMessageModel.h"
#import "JMessageFrameModel.h"
#import "JMessageCell.h"
#import "JfriendGroupModel.h"
#import "JHeaderView.h"
#define  jScreenW   [UIScreen mainScreen].bounds.size.width
#define  jScreenH   [UIScreen mainScreen].bounds.size.height
@interface ChangJianWT ()<UITableViewDataSource,UITableViewDelegate,JHeaderViewDelegate,HZMAPIManagerDelegate>
@property(nonatomic,strong) NSArray     *friendGroupsArr;//不可变：安全起见
@property(nonatomic,strong) NSMutableArray     *data;
//@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ChangJianWT

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_gray;
    self.title = @"常见问题";
    [self getData];
//    self.friendGroupsArr = [NSMutableArray arrayWithArray:[self arr]];
    [self creatUI];
    _data = [NSMutableArray array];
    
    __weak UITableView *tableView = self.tableView;
    
    //下拉率刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        //        [tableView reloadData];
        [tableView.header endRefreshing];
    }];
    // 上啦刷新
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getData];
        //        [tableView reloadData];
        [tableView.footer endRefreshing];
    }];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

- (void)creatUI{
//    使用UITableviewController 那么会有自带的一些功能：例如可以在顶端显示组名等等。。。
    
    //行高一定时候，调用
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight =50;
    
}

#pragma mark 校验短信验证码
- (void)getData{
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HelpCJWTi_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:HelpCJWTi_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            if (self.data.count) {
                [self.data removeAllObjects];
            }
            NSArray * dic =[response.responseData objectForKey:@"data"];
            if (dic){
//
                    if ([dic isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dic = (NSDictionary *)dic;
                        // 消息模型：
                        JfriendGroupModel *g = [[JfriendGroupModel alloc]init];
                        g.name =  dic[@"title"];
                        
                        JMessageModel *j = [[JMessageModel alloc]init];
                        j.text =  dic[@"vaule"];
                        
                        JMessageFrameModel *jmm = [[JMessageFrameModel alloc]init];
                        jmm.messageModel = j;
                        
                        g.friends = @[jmm];
                        [self.data addObject:g];
                    }
                    if ([dic isKindOfClass:[NSArray class]]) {
                        NSArray *arr = (NSArray *)dic;
                        for (NSDictionary *dict in arr) {
                            JfriendGroupModel *g = [[JfriendGroupModel alloc]init];
                            g.name =  dict[@"title"];
                            
                            JMessageModel *j = [[JMessageModel alloc]init];
                            j.text =  dict[@"vaule"];
                            
                            JMessageFrameModel *jmm = [[JMessageFrameModel alloc]init];
                            jmm.messageModel = j;
                            
                            g.friends = @[jmm];
                            [self.data addObject:g];
                        }
                        
                }
            }
            
        }
        [self.tableView reloadData];
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
        l.some =self;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}


#pragma mark - tableview的代理方法
#pragma mark 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return  self.friendGroupsArr.count;
    return  self.data.count;
}
#pragma mark 行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    JfriendGroupModel *gmodel = self.data[section] ;
//    return gmodel.friends.count;
    // isExpand 默认是NO
    return (gmodel.isExpand?gmodel.friends.count:0);
}
#pragma mark cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1、创建cell
    JMessageCell *cell = [JMessageCell cellWithTableView:tableView isChange:NO];
    // 2、给cell传模型frame模型，首先进行frame的计算。然后进入view中。
    cell.backgroundColor = RGB_gray;
    JfriendGroupModel *m = self.data[indexPath.section];
    cell.messageFrame = [m.friends firstObject];
    // 3、返回cell
    
    
    return cell;
}
#pragma mark 头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JHeaderView *headView = [JHeaderView headerViewWithTableView:tableView];
    headView.groups = _data[section];
    headView.delegate = self;
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     JfriendGroupModel *m = self.data[indexPath.section];
    JMessageFrameModel *mf = [m.friends firstObject] ;
    return mf.cellHeight;
}
#pragma mark - 好友数组-懒加载
/**数组模型懒加载*/ //如果数据是动态的，可以用NSMutableArray。不然用不可变数组。出于安全的角度考虑：同事之间数据沟通让他们知道这个东西不能修改。这就是团队经验，让别人知道这个东西不能修改。

#pragma mark - headerView的代理方法
/**
 *  点击了headerView上面的名字按钮时就会调用
 */
- (void)headerViewDidClickedNameView:(JHeaderView *)headerView
{
    
    [self.tableView reloadData];
}


// 设置组间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // 组之间的间距是由组头的高度和组尾的高度加起来计算.
    return 1.0f;
}


- (NSArray *)arr {
    
    
    NSArray *arr  = @[@[@"银行存管",@"投资人资金由恒丰银行存管，资金去向明确可靠。"],
                      @[@"风险备付金",@"公司自有资金中划拨相应的起始资金存放于风险储备金账户中。平台每笔借款成交时，提取0.1%的成交金额放入“风险备付金账户”。借款出现逾期时，则先启动“风险备用金”先行向投资人垫付此笔借款的剩余出借本息。"],
                      @[@"债权回购金",@"从公司自有资金中划拨一定数量的起始资金存放于债权回购金账户中。平台不定期补充或增加资金放入 “债权回购金账户”。若风险备付金不足以垫付或回购时，则启动“债权回购金”向投资人垫付此笔借款的剩余出借本息。"],
                      @[@"优质可靠",@"中赢金融公司做连带责任担保，保证用户的资金安全。"],
                      @[@"账户资金交易安全",@"阳光财险保险公司对每笔交易承担保险责任，从充值、提现、投资、还款等各个环节全面保障投资者的资金安全，为你在我的菜理财的资金安全保驾护航，让您的投资更安全放心。"]];
    
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSArray *dict in arr) {
        // 消息模型：
        JfriendGroupModel *g = [[JfriendGroupModel alloc]init];
        g.name = dict[0];
        
        
        JMessageModel *j = [[JMessageModel alloc]init];
        j.text = dict[1];
        
        JMessageFrameModel *jmm = [[JMessageFrameModel alloc]init];
        jmm.messageModel = j;
        
        g.friends = @[jmm];
        
        [mArr addObject:g];
    }
    return mArr;
}




#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
