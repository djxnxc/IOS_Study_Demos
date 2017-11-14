//
//  HomeVC.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "HomeVC.h"
#import "HomeHeaderCell.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,HomeButProtocol>

@property (weak, nonatomic) IBOutlet UIView *searchView;//搜索框
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

    // Do any additional setup after loading the view from its nib.
}
/**
 * 初始化
 */
-(void)initView{
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = 20;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
//    [DJXRefreshTool initWithTableViewRefresh:self.mainTableView andTarget:self andHeaderSelector:@selector(headerRefresh) andFooterSelector:@selector(footerRefresh)];

    [DJXRefreshTool initWithTableViewGifRefresh:self.mainTableView andTarget:self andHeaderSelector:@selector(headerRefresh) andFooterSelector:@selector(footerRefresh)];
}
-(void)headerRefresh{
//    [self.mainTableView.mj_header endRefreshing];
}
-(void)footerRefresh{
//    [self.mainTableView.mj_footer endRefreshing];

}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 100;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *headCellID = @"headCell";
        HomeHeaderCell *headCell = [tableView dequeueReusableCellWithIdentifier:headCellID];
        if (!headCell) {
            headCell = [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderCell" owner:self options:nil].lastObject;
            headCell.delegate = self;
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return headCell;
    }
    else
    {
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}
#pragma mark-UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark-HomeButProtocol
-(void)homeVCButClick:(UIButton *)sender{
    /**
     *scan tag=100,pay tag=101, collect tag=102,offers tag=103
     */
    switch (sender.tag) {
        case 100:
            [self.mainTableView.mj_header endRefreshing];

            NSLog(@"scan");
            break;
        case 101:
            NSLog(@"pay");
            break;
        case 102:
            NSLog(@"collect");
            break;
        case 103:
            NSLog(@"offers");
            break;
        default:
            break;
    }
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
