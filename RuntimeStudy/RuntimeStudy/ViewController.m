//
//  ViewController.m
//  RuntimeStudy
//
//  Created by 12 on 2018/3/1.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"
#import "TestModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

/**
    runtime 交换方法
**/
    //由于使用runtime方法交换之后，实际调用的是ln_imageNamed:方法
    UIImage *image = [UIImage imageNamed:@"kong"];//图片为空
    UIImage *image1 = [UIImage imageNamed:@"icon_daxie"];//有图片
/**
    runtime 给分类动态添加属性
 **/
    image1.lab = @"image";
    NSLog(@"runtime添加属性---%@",image1.lab);
    
/**
    runtime字典转模型
 **/
    NSDictionary *dict = @{@"name":@"张三",@"age":@"18",@"sex":@"男"};
    TestModel *model = [TestModel modelWithDict:dict];
    NSLog(@"runtime字典装模型----%@",model);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
