//
//  DJXNavigationController.m
//  DJXTabBar
//
//  Created by 12 on 2017/11/7.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "DJXNavigationController.h"

@interface DJXNavigationController ()

@end

@implementation DJXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:MMP_BLUECOLOR];
    [[UINavigationBar appearance] setTranslucent:NO];

    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Do any additional setup after loading the view.
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
