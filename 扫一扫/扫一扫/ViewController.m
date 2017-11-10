//
//  ViewController.m
//  扫一扫
//
//  Created by 12 on 2017/11/8.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "ViewController.h"
#import "DJXScanViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 * 点击扫一扫按钮
 */
- (IBAction)scanButClick:(UIButton *)sender {
    DJXScanViewController *vc = [[DJXScanViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
