//
//  TransferSuccessVC.m
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferSuccessVC.h"

@interface TransferSuccessVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneButTop;


@end

@implementation TransferSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (MMP_iPhoneX) {
        self.doneButTop.constant=44;
    }
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)doneButClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.finishlock) {
            self.finishlock(@"finish");
            self.finishlock = nil;
        }
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
