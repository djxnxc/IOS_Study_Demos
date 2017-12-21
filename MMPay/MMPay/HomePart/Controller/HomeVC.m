//
//  HomeVC.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "HomeVC.h"
#import "HomeHeaderCell.h"
#import "HomeMenuCell.h"
#import "HomeSearchVC.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,HomeButProtocol,HomeMenuCellDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navStateHeight;

@property (weak, nonatomic) IBOutlet UIView *searchView;//搜索框
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
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
    self.navStateHeight.constant = MMP_NAV_STATESBAR_HEIGHT;
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
//    [DJXRefreshTool initWithTableViewRefresh:self.mainTableView andTarget:self andHeaderSelector:@selector(headerRefresh) andFooterSelector:@selector(footerRefresh)];

//    [DJXRefreshTool initWithTableViewGifRefresh:self.mainTableView andTarget:self andHeaderSelector:@selector(headerRefresh) andFooterSelector:@selector(footerRefresh)];
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
        return 210;
    }
    return 8+MMP_ScreenW/375*165;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

  if (indexPath.row==0) {
        HomeMenuCell *menuCell = [HomeMenuCell cellWithTableView:tableView];
        menuCell.delegate = self;
        return menuCell;
    }
    else
    {
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, MMP_ScreenW, MMP_ScreenW/375*165)];
        cell.contentView.backgroundColor = MMP_CUSTOM_COLOR(250, 249, 249, 1);
        imageV.image = [UIImage imageNamed:@"bg_banner"];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview: imageV];
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
        case 100:{
            [self.mainTableView.mj_header endRefreshing];
            DJXScanViewController *vc = [[DJXScanViewController alloc]init];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
            NSLog(@"scan");
            }
            break;
        case 101:{
            HomeSearchVC *vc = [[HomeSearchVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"pay");
            }
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
#pragma mark-HomeMenuCellDelegate
-(void)mmpCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title{
    if ([title isEqualToString:@"Transfer"]) {
        TransferVC *vc = [[TransferVC alloc]init];
        vc.title = @"Transfer";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"Phone Top up"]){
        TopUpCenterVC *vc = [[TopUpCenterVC alloc]initWithNibName:@"TopUpCenterVC" bundle:nil];
        vc.title = @"Top Up Center";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
