//
//  ViewController.m
//  LanguageLocalizationsDemo
//
//  Created by 12 on 2018/1/25.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "ViewController.h"
#import "MyLanguageTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 200, 40)];
    lab.text = MyGetStringWithKeyFromTable(@"Chinese", @"");
    [self.view addSubview: lab];
    // Do any additional setup after loading the view, typically from a nib.
}
//点击国际化
- (IBAction)btnClick:(UIButton *)sender {
    NSInteger i = arc4random() % 3;
    NSArray *languageArr = @[@"en",@"fr",@"zh-Hans"];
    [[MyLanguageTool shareInstance]setMyLanguage:languageArr[i]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
