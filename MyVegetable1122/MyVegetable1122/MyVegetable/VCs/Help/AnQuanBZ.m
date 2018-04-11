//
//  AnQuanBZ.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AnQuanBZ.h"

#import "JMessageModel.h"
#import "JMessageFrameModel.h"
#import "JMessageCell.h"

@interface AnQuanBZ ()
@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation AnQuanBZ

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_gray;
    self.title = @"安全保障";
    
    self.data = [NSMutableArray arrayWithArray:[self arr]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB_gray;
//    self.tableView.frame
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1、创建cell
    JMessageCell *cell = [JMessageCell cellWithTableView:tableView isChange:YES];
    // 2、给cell传模型frame模型，首先进行frame的计算。然后进入view中。
    cell.backgroundColor = [UIColor whiteColor];
    cell.messageFrame = self.data[indexPath.row];
    // 3、返回cell
    
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMessageFrameModel *mf = _data[indexPath.row];
    return mf.cellHeight;
}

#pragma mark -其他
- (NSArray *)arr {
    
    
    NSArray *arr  = @[@[@"银行存管",@"投资人资金由恒丰银行存管，资金去向明确可靠。"],
                      @[@"风险备付金",@"公司自有资金中划拨相应的起始资金存放于风险储备金账户中。平台每笔借款成交时，提取0.1%的成交金额放入“风险备付金账户”。借款出现逾期时，则先启动“风险备用金”先行向投资人垫付此笔借款的剩余出借本息。"],
                      @[@"债权回购金",@"从公司自有资金中划拨一定数量的起始资金存放于债权回购金账户中。平台不定期补充或增加资金放入 “债权回购金账户”。若风险备付金不足以垫付或回购时，则启动“债权回购金”向投资人垫付此笔借款的剩余出借本息。"],
                      @[@"优质可靠",@"中赢金融公司做连带责任担保，保证用户的资金安全。"],
                      @[@"账户资金交易安全",@"阳光财险保险公司对每笔交易承担保险责任，从充值、提现、投资、还款等各个环节全面保障投资者的资金安全，为你在我的菜理财的资金安全保驾护航，让您的投资更安全放心。"]];
    
    
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSArray *dict in arr) {
            // 消息模型：
            JMessageModel *jmm = [[JMessageModel alloc]init];
            jmm.title = dict[0];
            jmm.text = dict[1];
            // 添加数据：
            JMessageFrameModel *jmf = [[JMessageFrameModel alloc] init];
            jmf.messageModel = jmm;
            
            [mArr addObject:jmf];
        }
    return mArr;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
