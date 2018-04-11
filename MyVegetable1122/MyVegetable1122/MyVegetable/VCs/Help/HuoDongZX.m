//
//  HuoDongZX.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "HuoDongZX.h"
#import "HuoDongCell.h"
#import "HuoDongModel.h"
#import "AFAPIMarco.h"
#import "HtmlHB.h"
#import "UIViewControllerFactory.h"
@interface HuoDongZX ()<UITableViewDataSource,UITableViewDelegate,HZMAPIManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation HuoDongZX

- (void)viewDidLoad {
    self.title = @"活动中心";
    [super viewDidLoad];
    [self configUI];
    self.view.backgroundColor = RGB_gray;
    [self getData];
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
#pragma mark - 创建UI
- (void)configUI {
    self.data = [NSMutableArray array];
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //    self.tableView.separatorStyle       = NO;
    //    self.tableViewCe.separatorStyle     = NO;
    //    self.tableview.backgroundColor    = [UIColor clearColor];
    [self.tableView  registerNib:[UINib nibWithNibName:@"HuoDongCell1" bundle:nil] forCellReuseIdentifier:@"HuoDongCell"];
    
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
//    
//    for (int i=0; i<5; i++) {
//        HuoDongModel *model = [[HuoDongModel alloc] init];
//        model.isNew = @"1";
//        [self.data addObject:model];
//    }
    
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"HuoDongCell";
    
    HuoDongCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    cell.contentView.backgroundColor = [UIColor clearColor];
    HuoDongModel *model = (HuoDongModel *)[self.data objectAtIndex:indexPath.row];
    [cell setHdmodel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //消除选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HuoDongModel *model = (HuoDongModel *)[self.data objectAtIndex:indexPath.row];
   /* HtmlHB* hb=[[HtmlHB alloc]init];
    hb.title=@"活动";
    hb.url=model.isMore;*/
    WebHtml5ViewController*hb=[UIViewControllerFactory getViewController:HTML5_WebView ];
    hb.messTitle=@"活动";
    if (model.isMore.length>1) {
       
    hb.url=model.isMore;
    [self.navigationController pushViewController:hb animated:YES];
    }else{
        [self.view makeToast:@"暂无详情"];
    }
    
//    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"BTVC" bundle:nil];
//    BTDetailVC *note = [sto instantiateViewControllerWithIdentifier:@"BTDetailVC"];
//    note.index = indexPath.row;
//    MainModel *modell = (MainModel *)[self.data objectAtIndex:indexPath.row];
//    note.arr = [NSArray arrayWithObject:modell];
//    [self presentViewController:note animated:YES completion:nil];
    
}

#pragma mark - 网络请求
#pragma mark 校验短信验证码
- (void)getData{
    //NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",nil];
    /*[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = HelpHuoDZX_NetWoring;
    //request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];*/
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hdData=[[NSMutableData alloc]init];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVICE_URL,HelpHuoDZX_NetWoring]];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    conn=[[NSURLConnection alloc]initWithRequest:req delegate:self];
    
}
- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:HelpHuoDZX_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            if (self.data.count) {
                [self.data removeAllObjects];
            }
            NSDictionary *dict =[response.responseData objectForKey:@"data"];
            
            
            
            
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
        l.isFrom = 88;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
}


#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:@"网络连接失败！" duration:2.0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [hdData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [hdData setLength:0];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (hdData) {
        [self.data removeAllObjects];
        NSDictionary* root=[NSJSONSerialization JSONObjectWithData:hdData options:NSJSONReadingMutableLeaves error:nil];
        NSArray* arr=[root objectForKey:@"data"];
        for (int i=0; i<arr.count; i++) {
            [self.data addObject:[[HuoDongModel alloc] initWithDic:[arr objectAtIndex:i]]];
        }
        [self.tableView reloadData];
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
