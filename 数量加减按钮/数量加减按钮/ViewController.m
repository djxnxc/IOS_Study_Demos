//
//  ViewController.m
//  数量加减按钮
//
//  Created by 12 on 2018/3/7.
//  Copyright © 2018年 DJX. All rights reserved.
//

#import "ViewController.h"
#import "DJStepper.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DJStepper*stepper = [DJStepper initViewWithFrame:CGRectMake(50, 100, 80, 25)];
    stepper.backBlock = ^(NSString *number) {
        NSLog(@"%@",number);
    };
    [self.view addSubview:stepper];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
