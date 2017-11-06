//
//  DJXIndexTableView.m
//  通讯录索引表
//
//  Created by 12 on 2017/11/6.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "DJXIndexTableView.h"

@interface DJXIndexTableView ()<UITableViewDelegate,UITableViewDataSource>
/**
 * 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 * 取消按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *cancelBut;
/**
 * 列表
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  当前城市数据源，plist取
 */
@property(nonatomic,copy)NSArray *cityArr;
/**
 *  索引数据源
 */
@property (nonatomic, copy) NSMutableArray *indexSource;
@end

@implementation DJXIndexTableView
-(NSMutableArray *)indexSource{
    if (!_indexSource) {
        _indexSource = [NSMutableArray array];
    }
    return _indexSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.titleLabel.text = @"选择城市";
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *city = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    self.cityArr = [[self sortArray:city] copy];
}
//排序并按首字母分组
-(NSMutableArray *)sortArray:(NSMutableArray *)arrayToSort {
    NSMutableArray *arrayForArrays = [[NSMutableArray alloc] init];
    //根据拼音对数组排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //排序
    [arrayToSort sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *tempArray = nil;
    BOOL flag = NO;
    
    //分组
    for (int i = 0; i < arrayToSort.count; i++) {
        NSString *pinyin = [arrayToSort[i] objectForKey:@"pinyin"];
        NSString *firstChar = [pinyin substringToIndex:1];
        if (![self.indexSource containsObject:[firstChar uppercaseString]]) {
            [_indexSource addObject:[firstChar uppercaseString]];
            tempArray = [[NSMutableArray alloc] init];
            flag = NO;
        }
        if ([_indexSource containsObject:[firstChar uppercaseString]]) {
            [tempArray addObject:arrayToSort[i]];
            if (flag == NO) {
                [arrayForArrays addObject:tempArray];
                flag = YES;
            }
        }
    }
    
    return arrayForArrays;
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cityArr[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityArr.count;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexSource;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.indexSource[section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [[self.cityArr[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//点击取消按钮事件
- (IBAction)cancelButClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
