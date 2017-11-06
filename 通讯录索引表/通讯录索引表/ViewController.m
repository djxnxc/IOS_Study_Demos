//
//  ViewController.m
//  通讯录索引表
//
//  Created by 12 on 2017/11/6.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "ViewController.h"
#import "DJXIndexTableView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//点击索引表按钮事件
- (IBAction)indexButClick:(UIButton *)sender {
    DJXIndexTableView *tableViewVC = [[DJXIndexTableView alloc]initWithNibName:@"DJXIndexTableView" bundle:nil];
    [self presentViewController:tableViewVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
